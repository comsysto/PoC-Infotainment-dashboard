import ssl
import json
import logging
from ssl import Purpose

# from awscrt import io, mqtt
# from awsiot import mqtt_connection_builder


# class MqttClient:
#     _client: mqtt.Connection
#     _endpoint: str
#     _client_id: str
#
#     def __init__(self, endpoint: str, client_id: str, cert: str, private_key: str, root_cert: str):
#         self._endpoint = endpoint
#         self._client_id = client_id
#         elg = io.EventLoopGroup(1)
#         hr = io.DefaultHostResolver(elg)
#         cb = io.ClientBootstrap(elg, hr)
#         self._client = mqtt_connection_builder.mtls_from_path(
#             endpoint=endpoint,
#             cert_filepath=cert,
#             pri_key_filepath=private_key,
#             client_bootstrap=cb,
#             ca_filepath=root_cert,
#             client_id=client_id,
#             clean_session=False,
#             keep_alive_secs=6
#         )
#         logging.info(f"MQTT: Connecting to '{self._endpoint}' with client ID '{self._client_id}'...")
#         future = self._client.connect()
#         # waits until a result is available
#         future.result()
#         logging.info('MQTT: Connected')
#
#     def subscribe(self, topic: str, callback):
#         future, packet_id = self._client.subscribe(topic=topic, callback=callback, qos=mqtt.QoS.AT_LEAST_ONCE)
#         future.result()
#         logging.info(f"MQTT: Subscribed: topic '{topic}', callback: {callback.__name__}")
#
#     def publish(self, message, topic: str):
#         payload = json.dumps(message)
#         self._client.publish(topic=topic, payload=payload, qos=mqtt.QoS.AT_LEAST_ONCE)
#         logging.debug(f"MQTT: Published: topic '{topic}', data: {payload}")
#
#     def close(self):
#         logging.info(f"MQTT: Disconnecting from '{self._endpoint}' with client ID '{self._client_id}'...")
#         future = self._client.disconnect()
#         # waits until a result is available
#         future.result()
#         logging.info('MQTT: Disconnected')


import aiomqtt
import asyncio

from aiomqtt import ProtocolVersion, TLSParameters

from infotainment_backend.lib.database import DbConnectionHandler
from infotainment_backend.lib.socket import WebSocketServer


class MqttClient:
    _cert: str
    _private_key: str
    _root_cert: str

    _endpoint: str
    _port: int
    _client_id: str

    _client: aiomqtt.Client = None

    def __init__(self, endpoint: str, port: int, client_id: str, cert: str, private_key: str, root_cert: str):
        self._endpoint = endpoint
        self._port = port
        self._client_id = client_id
        # auth credential paths
        self._cert = cert
        self._private_key = private_key
        self._root_cert = root_cert

    @staticmethod
    async def _subscribe(topics: [str], client):
        for topic in topics:
            await client.subscribe(topic)
            logging.info(f"MqttClient: Subscribed: '{topic}'")

    def is_connected(self) -> bool:
        return self._client is not None

    async def publish(self, message: str, topic: str) -> bool:
        if self._client is None:
            return False
        await self._client.publish(topic, payload=message)
        logging.debug(f"MqttClient: Published: topic '{topic}', data: {message}")
        return True

    async def run(self, subscribe_topics: {}, vehicle_id: str, socket: WebSocketServer, db_client: DbConnectionHandler):
        logging.info(f"MQTT: Connecting to '{self._endpoint}:{self._port}'...")
        # create tls params
        tls_params = TLSParameters(
            ca_certs=self._root_cert,
            certfile=self._cert,
            keyfile=self._private_key
        )
        # define client
        async with aiomqtt.Client(
            hostname=self._endpoint,
            port=self._port,
            protocol=ProtocolVersion.V5,
            # identifier=self._client_id,
            tls_params=tls_params
        ) as client:
            # save client
            self._client = client
            logging.info('MQTT: Connected')

            topics = list(subscribe_topics.keys())
            await self._subscribe(topics=topics, client=client)

            # wait messages
            async for message in client.messages:
                topic = message.topic.__str__()
                if topic not in topics:
                    logging.warning(f"MqttClient: Message received on '{topic}' but no callback method defined!")
                    continue

                logging.debug(f"MqttClient: Message received on '{topic}', trigger: {subscribe_topics[topic].__name__}")
                # invoke callback method
                await subscribe_topics[topic](
                    topic=message.topic,
                    payload=message.payload,
                    vehicle_id=vehicle_id,
                    mqtt_client=self,
                    socket=socket,
                    db_client=db_client
                )
