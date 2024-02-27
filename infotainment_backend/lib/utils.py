import os
import json
import math
import logging
import decimal
from random import choice
from datetime import datetime
from string import ascii_lowercase

from infotainment_backend.config import VEHICLE_ID_LEN, VEHICLE_WHEEL_RADIUS


class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            return str(o)
        return super().default(o)


def vehicle_id_generator() -> str:
    return ''.join(choice(ascii_lowercase) for _ in range(VEHICLE_ID_LEN))


def create_publish_state(vehicle: {}) -> str | None:
    if not vehicle:
        return None
    return json.dumps({
        'telemetry': {
            'dpfWarning': vehicle['dpf_warning'],
            'battery': vehicle['battery_level'],
            'rpm': vehicle['rpm'],
            'velocity': vehicle['velocity']
        }
    }, cls=DecimalEncoder)


def velocity_to_rpm(velocity) -> float:
    return (velocity * 60) / (2 * math.pi * VEHICLE_WHEEL_RADIUS)


def create_socket_state(vehicle: {}, vehicle_fields: [], blinker_relevant: bool, blinker: str = None) -> {}:
    state = {field: vehicle[field] for field in vehicle_fields}
    if blinker_relevant:
        state['blinker'] = blinker
    return json.dumps(state, cls=DecimalEncoder)


def bytes_to_dict(data: bytes) -> {}:
    return json.loads(data.decode("utf-8"))


def logging_config(folder: str = None):

    handlers = [logging.StreamHandler()]
    if folder:
        if not os.path.exists(folder):
            os.makedirs(folder)
        filename = os.path.join(folder,
                                f'execution_{datetime.now().strftime("%Y-%m-%d_%H:%M:%S")}.log')
        handlers.append(
            logging.FileHandler(filename=filename, mode='a')
        )

    logging.basicConfig(
        level=logging.DEBUG,
        # format='%(message)s',
        format='%(asctime)s [%(threadName)-12.12s] [%(levelname)-5.5s]  %(message)s',
        handlers=handlers
    )
