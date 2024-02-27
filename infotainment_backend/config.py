# certs and keys
CERTIFICATE = "certs/certificate.pem.crt"
PRIVATE_KEY = "certs/private.pem.key"
AMAZON_ROOT_CA_1 = "certs/AmazonRootCA1.pem"

# connection strings
ENDPOINT = "a30vb2xablwvcd-ats.iot.eu-central-1.amazonaws.com"
CLIENT_ID = "iotconsole-8f204108-c1c4-46fb-aa17-26e9bf4fcdbf"

# topics
# - publish
UPDATE_TOPIC = "/mercedes/carMock/update"
# - subscribe
COMMAND_TOPIC = "/mercedes/carMock/command"

# database
VEHICLE_ID_LEN = 16

# vehicle
# - dpf
VEHICLE_DPF_VELOCITY_THRESHOLD = 80
VEHICLE_DPF_LOW_VELOCITY_TIME_THRESHOLD = 5     # [s]
VEHICLE_DPF_HIGH_VELOCITY_TIME_THRESHOLD = 5    # [s]
# - velocity
VEHICLE_VELOCITY_INCREASE_FACTOR = 1.20
VEHICLE_VELOCITY_DECREASE_FACTOR = 0.80
VEHICLE_VELOCITY_MAX = 220
VEHICLE_VELOCITY_MIN = 0
# - rpm
VEHICLE_WHEEL_RADIUS = 0.5
# - battery
VEHICLE_BATTERY_INCREASE_FACTOR = 1.01
VEHICLE_BATTERY_DECREASE_FACTOR = 0.99
VEHICLE_BATTERY_MAX = 100
