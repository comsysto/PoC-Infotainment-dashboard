import time
import asyncio
import logging
from sys import exit
from awscrt import mqtt

from infotainment_backend.lib.database import ConnectionHandler
from infotainment_backend.lib.enum import Velocity
from infotainment_backend.lib.mqtt import MqttClient
from infotainment_backend.lib.socket import SocketClient, SocketServer
from infotainment_backend.lib.utils import *
from infotainment_backend.config import *


# logging_config(folder=os.path.join('logs'))
logging_config(folder=None)

mqtt_client = MqttClient(
    endpoint=ENDPOINT,
    client_id=CLIENT_ID,
    cert=CERTIFICATE,
    private_key=PRIVATE_KEY,
    root_cert=AMAZON_ROOT_CA_1
)
db_client = ConnectionHandler(
    hostname='localhost',
    port='55432',
    username='test_db_user',
    password='test_password',
    database='postgres'
)

# get free random port
infotainment_server = SocketServer(ip='127.0.0.1', port=0)
infotainment_client = SocketClient(ip='127.0.0.1', port=infotainment_server.get_port())

# everytime backend restarts, create new vehicle id
vehicle_id: str = vehicle_id_generator()


def command_received_callback(topic: str, payload: bytes, dup: bool, qos: mqtt.QoS, retain: bool, **kwargs):
    data: {} = bytes_to_dict(payload)
    logging.debug(f"Command: topic: '{topic}', data: {data}")

    blinker: str = data['commands']['blinker']
    velocity: str = data['commands']['velocity']

    # get newest values
    _, vehicle = db_client.check_vehicle(vehicle_id=vehicle_id, raise_exception=True)

    logging.info(f'Command: Vehicle: {vehicle}')

    if velocity:
        is_increase: bool = velocity == Velocity.INCREASE.value
        if is_increase:
            # init values for velocity and rpm
            vehicle['velocity'] = 1 if vehicle['velocity'] == 0 else vehicle['velocity']
            vehicle['rpm'] = 1 if vehicle['rpm'] == 0 else vehicle['rpm']

        # multiply velocity & rpm with factor
        vehicle['velocity'] *= VEHICLE_VELOCITY_INCREASE_FACTOR if is_increase else VEHICLE_VELOCITY_DECREASE_FACTOR
        vehicle['rpm'] = velocity_to_rpm(vehicle['velocity'])
        vehicle['battery_level'] *= VEHICLE_BATTERY_DECREASE_FACTOR if is_increase else VEHICLE_BATTERY_INCREASE_FACTOR

        # limit values between interval: [0, <max>]
        if is_increase:
            vehicle['velocity'] = min(vehicle['velocity'], VEHICLE_VELOCITY_MAX)
            vehicle['rpm'] = velocity_to_rpm(vehicle['velocity'])
            vehicle['battery_level'] = min(vehicle['battery_level'], VEHICLE_BATTERY_MAX)
        else:
            vehicle['velocity'] = max(vehicle['velocity'], 0)
            vehicle['rpm'] = max(vehicle['rpm'], 0)
            vehicle['battery_level'] = max(vehicle['battery_level'], 0)

    logging.info(f'Command: Updated Vehicle: {vehicle}')

    # store partial updates only for relevant columns
    _, vehicle = db_client.update_vehicle(vehicle_id=vehicle_id, vehicle=vehicle,
                                          columns=['battery_level', 'rpm', 'velocity'])
    # send updates
    mqtt_client.publish(message=create_publish_state(vehicle), topic=UPDATE_TOPIC)

    # infotainment state
    socket_state: str = create_socket_state(
        vehicle=vehicle,
        vehicle_fields=['dpf_warning', 'battery_level', 'rpm', 'velocity'],
        blinker_relevant=True,
        blinker=blinker
    )
    infotainment_client.send(data=socket_state)


def dpf_handler(dpf_state: {}, vehicle: {}):
    if vehicle['velocity'] < VEHICLE_DPF_VELOCITY_THRESHOLD:
        # when velocity is lower
        dpf_state['above_start'] = None
        if not dpf_state['below_start']:
            dpf_state['below_start'] = time.time()

        # if greater than threshold, set warning
        vehicle['dpf_warning'] = time.time() - dpf_state['below_start'] >= VEHICLE_DPF_LOW_VELOCITY_TIME_THRESHOLD
    else:
        # when velocity is higher
        dpf_state['below_start'] = None
        if not dpf_state['above_start']:
            dpf_state['above_start'] = time.time()

        # if greater than threshold, set warning
        vehicle['dpf_warning'] = time.time() - dpf_state['above_start'] < VEHICLE_DPF_HIGH_VELOCITY_TIME_THRESHOLD


async def vehicle_telemetry(telemetry_frequency: float):
    # dpf init state timers
    dpf_state = {
        'below_start': None,
        'above_start': None
    }
    # wait for messages and check sensors
    while True:
        # get newest values
        _, vehicle = db_client.check_vehicle(vehicle_id=vehicle_id, raise_exception=True)

        # check sensors
        dpf_handler(dpf_state=dpf_state, vehicle=vehicle)

        # store partial updates only for relevant columns
        _, vehicle = db_client.update_vehicle(vehicle_id=vehicle_id, vehicle=vehicle, columns=['dpf_warning'])
        # send updates
        mqtt_client.publish(message=create_publish_state(vehicle), topic=UPDATE_TOPIC)

        # infotainment state
        socket_state: str = create_socket_state(
            vehicle=vehicle,
            vehicle_fields=['dpf_warning', 'battery_level', 'rpm', 'velocity'],
            blinker_relevant=False
        )
        infotainment_client.send(data=socket_state)

        # async wait
        await asyncio.sleep(telemetry_frequency)


def vehicle_init():
    created, vehicle = db_client.create_vehicle(vehicle_id=vehicle_id)
    logging.info(f'Initial vehicle state: {vehicle}')

    # set initial state
    mqtt_client.publish(message=create_publish_state(vehicle), topic=UPDATE_TOPIC)


async def main(main_frequency: float, telemetry_frequency: float):
    # create tasks
    asyncio.create_task(vehicle_telemetry(telemetry_frequency=telemetry_frequency))
    try:
        while True:
            # async wait - hold main program running
            await asyncio.sleep(main_frequency)
    except KeyboardInterrupt as e:
        # close connections
        mqtt_client.close()
        db_client.close()


if __name__ == '__main__':
    # init vehicle
    vehicle_init()
    # subscribe
    mqtt_client.subscribe(topic=COMMAND_TOPIC, callback=command_received_callback)

    # start main method
    asyncio.run(main(main_frequency=60, telemetry_frequency=1))
