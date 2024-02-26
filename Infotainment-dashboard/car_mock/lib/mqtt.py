import json
import logging

from awscrt import io, mqtt
from awsiot import mqtt_connection_builder


class MqttClient:
    _client: mqtt.Connection
    _endpoint: str
    _client_id: str

    def __init__(self, endpoint: str, client_id: str, cert: str, private_key: str, root_cert: str):
        self._endpoint = endpoint
        self._client_id = client_id
        elg = io.EventLoopGroup(1)
        hr = io.DefaultHostResolver(elg)
        cb = io.ClientBootstrap(elg, hr)
        self._client = mqtt_connection_builder.mtls_from_path(
            endpoint=endpoint,
            cert_filepath=cert,
            pri_key_filepath=private_key,
            client_bootstrap=cb,
            ca_filepath=root_cert,
            client_id=client_id,
            clean_session=False,
            keep_alive_secs=6
        )
        logging.info(f"MQTT: Connecting to '{self._endpoint}' with client ID '{self._client_id}'...")
        future = self._client.connect()
        # waits until a result is available
        future.result()
        logging.info('MQTT: Connected')

    def subscribe(self, topic: str, callback):
        future, packet_id = self._client.subscribe(topic=topic, callback=callback, qos=mqtt.QoS.AT_LEAST_ONCE)
        future.result()
        logging.info(f"MQTT: Subscribed: topic '{topic}', callback: {callback.__name__}")

    def publish(self, message, topic: str):
        payload = json.dumps(message)
        self._client.publish(topic=topic, payload=payload, qos=mqtt.QoS.AT_LEAST_ONCE)
        logging.debug(f"MQTT: Published: topic '{topic}', data: {payload}")

    def close(self):
        logging.info(f"MQTT: Disconnecting from '{self._endpoint}' with client ID '{self._client_id}'...")
        future = self._client.disconnect()
        # waits until a result is available
        future.result()
        logging.info('MQTT: Disconnected')
