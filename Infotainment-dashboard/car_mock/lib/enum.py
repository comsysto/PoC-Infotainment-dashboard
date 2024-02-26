from enum import Enum


class Blinker(Enum):
    LEFT = 'left'
    RIGHT = 'right'
    HAZARD = 'hazard'


class Velocity(Enum):
    INCREASE = 'increase'
    DECREASE = 'decrease'
