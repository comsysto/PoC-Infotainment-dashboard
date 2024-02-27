import time
import asyncio
import logging

from infotainment_backend.callbacks import command_received_callback
from infotainment_backend.lib.database import DbConnectionHandler
from infotainment_backend.lib.mqtt import MqttClient
from infotainment_backend.lib.socket import WebSocketServer
from infotainment_backend.lib.utils import *
from infotainment_backend.config import *


# logging_config(folder=os.path.join('logs'))
logging_config(folder=None)

mqtt_client = MqttClient(
    endpoint=ENDPOINT,
    port=8883,
    client_id=CLIENT_ID,
    cert=CERTIFICATE,
    private_key=PRIVATE_KEY,
    root_cert=AMAZON_ROOT_CA_1
)
db_client = DbConnectionHandler(
    hostname='localhost',
    port='55432',
    username='test_db_user',
    password='test_password',
    database='postgres'
)

# get free random port
# infotainment_server = SocketServer(ip='127.0.0.1', port=0)
# infotainment_client = SocketClient(ip='127.0.0.1', port=infotainment_server.get_port())
infotainment_server = WebSocketServer(ip='127.0.0.1', port=56034)

# everytime backend restarts, create new vehicle id
vehicle_id: str = vehicle_id_generator()


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
        check, vehicle = db_client.check_vehicle(vehicle_id=vehicle_id, raise_exception=True)
        if not check:
            continue

        # check sensors
        dpf_handler(dpf_state=dpf_state, vehicle=vehicle)

        # store partial updates only for relevant columns
        updated, vehicle = db_client.update_vehicle(vehicle_id=vehicle_id, vehicle=vehicle, columns=['dpf_warning'])
        if not updated:
            continue

        # send updates
        published = await mqtt_client.publish(message=create_publish_state(vehicle), topic=UPDATE_TOPIC)
        if not published:
            return

        # infotainment state
        socket_state: str = create_socket_state(
            vehicle=vehicle,
            vehicle_fields=['dpf_warning', 'battery_level', 'rpm', 'velocity'],
            blinker_relevant=False
        )
        await infotainment_server.send(data=socket_state)

        # async wait
        await asyncio.sleep(telemetry_frequency)


async def vehicle_init() -> bool:
    created, vehicle = db_client.create_vehicle(vehicle_id=vehicle_id)
    logging.info(f'Initial vehicle state: {vehicle}')

    # wait for mqtt client init & set initial state
    while not mqtt_client.is_connected():
        await asyncio.sleep(0.1)

    # send updates
    _ = await mqtt_client.publish(message=create_publish_state(vehicle), topic=UPDATE_TOPIC)

    # infotainment state
    socket_state: str = create_socket_state(
        vehicle=vehicle,
        vehicle_fields=['dpf_warning', 'battery_level', 'rpm', 'velocity'],
        blinker_relevant=False
    )
    _ = await infotainment_server.send(data=socket_state)
    return True


async def main(telemetry_frequency: float):
    # mqtt callbacks
    topic_callbacks = {
        COMMAND_TOPIC: command_received_callback
    }
    # required first tasks
    asyncio.create_task(
        mqtt_client.run(
            subscribe_topics=topic_callbacks,
            vehicle_id=vehicle_id,
            socket=infotainment_server,
            db_client=db_client
        )
    )
    asyncio.create_task(infotainment_server.run())

    # # init vehicle
    published = await vehicle_init()
    if not published:
        raise Exception(f'Cannot initialize vehicle for id: {vehicle_id}')

    # # create other tasks
    asyncio.create_task(vehicle_telemetry(telemetry_frequency=telemetry_frequency))

    try:
        # hold main program running
        await asyncio.Future()
    except KeyboardInterrupt as e:
        # close connections
        db_client.close()


if __name__ == '__main__':
    # start main method
    asyncio.run(main(telemetry_frequency=1))
