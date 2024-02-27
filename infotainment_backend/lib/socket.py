import socket
import asyncio
import logging
import websockets
from threading import Thread


class SocketClient:
    _socket: socket.socket

    def __init__(self, ip: str, port: int):
        self._socket = socket.socket()
        self._socket.connect((ip, port))

    def send(self, data: str):
        self._socket.send(data.encode())
        logging.info(f"SocketClient: Data sent: {data}")


class SocketServer(Thread):
    _socket: socket.socket
    _client: socket.socket = None

    def __init__(self, ip: str, port: int):
        Thread.__init__(self)
        self._socket = socket.socket()
        self._socket.bind((ip, port))
        logging.info(f"SocketServer: Server started on: '{ip}:{self.get_port()}'")
        # start thread
        self.start()

    def send(self, data: str):
        if self.is_connected():
            self._client.send(data.encode())
            logging.info(f"SocketServer: Data sent: {data}")
        else:
            logging.warning("SocketServer: Server hasn't yet established a connection with the client!")

    def get_port(self):
        return self._socket.getsockname()[1]

    def is_connected(self) -> bool:
        return self._client is not None

    def run(self):
        self._socket.listen(5)
        self._client, address = self._socket.accept()
        try:
            while True:
                # blocking call, 1024 bytes of data
                data = self._client.recv(1024).decode()
                logging.info(f"SocketServer: Data received from '{address}': {data}")
        except KeyboardInterrupt:
            self._client.close()
            self._socket.close()


class WebSocketServer:
    _ip: str
    _port: int
    _connected_websockets = set()

    def __init__(self, ip: str, port: int):
        self._ip = ip
        self._port = port

    async def _handler(self, websocket):
        self._connected_websockets.add(websocket)
        logging.info(f"WebSocketServer: New Client on: {websocket}")
        while True:
            try:
                # wait for message
                message = await websocket.recv()
                logging.info(f"WebSocketServer: Data received from '{self._ip}:{self._port}': {message}")
            except websockets.ConnectionClosed:
                # client disconnected
                self._connected_websockets.remove(websocket)
                logging.info(f"WebSocketServer: Client '{self._ip}:{self._port}' disconnected!")

    async def send(self, data: str) -> bool:
        if self.is_connected():
            # broadcast to all connections
            await asyncio.wait([ws.send(data) for ws in self._connected_websockets])
            logging.info(f"WebSocketServer: Data sent to {len(self._connected_websockets)} sockets: {data}")
            return True
        else:
            logging.warning("WebSocketServer: Server hasn't yet established a connection with the client!")
            return False

    def is_connected(self) -> bool:
        return len(self._connected_websockets) != 0

    async def run(self):
        async with websockets.serve(self._handler, self._ip, self._port):
            logging.info(f"SocketServer: Server started on: '{self._ip}:{self._port}'")
            # run forever
            await asyncio.Future()
