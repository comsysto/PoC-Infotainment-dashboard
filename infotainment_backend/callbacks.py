import logging

from infotainment_backend.lib.database import DbConnectionHandler
from infotainment_backend.lib.enum import Velocity
from infotainment_backend.lib.mqtt import MqttClient
from infotainment_backend.lib.socket import WebSocketServer
from infotainment_backend.lib.utils import bytes_to_dict, velocity_to_rpm, create_publish_state, create_socket_state
from infotainment_backend.config import *


async def command_received_callback(topic: str,
                                    payload: bytes,
                                    vehicle_id: str,
                                    mqtt_client: MqttClient,
                                    socket: WebSocketServer,
                                    db_client: DbConnectionHandler):
    # prepare data
    data: {} = bytes_to_dict(payload)
    logging.debug(f"Command: topic: '{topic}', data: {data}")

    blinker: str = data['commands']['blinker']
    velocity: str = data['commands']['velocity']

    # get newest values
    check, vehicle = db_client.check_vehicle(vehicle_id=vehicle_id, raise_exception=True)
    # if something failed with connection or query
    if not check:
        return

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

    # store partial updates only for relevant columns
    updated, vehicle = db_client.update_vehicle(vehicle_id=vehicle_id, vehicle=vehicle,
                                                columns=['battery_level', 'rpm', 'velocity'])
    # if something failed with connection or query
    if not updated:
        return

    # send updates
    published = await mqtt_client.publish(message=create_publish_state(vehicle), topic=UPDATE_TOPIC)
    if not published:
        return

    # infotainment state
    socket_state: str = create_socket_state(
        vehicle=vehicle,
        vehicle_fields=['dpf_warning', 'battery_level', 'rpm', 'velocity'],
        blinker_relevant=True,
        blinker=blinker
    )
    await socket.send(data=socket_state)
