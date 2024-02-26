import logging
import socket
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
        # start thread
        self.start()

    def send(self, data: str):
        if not self._client:
            raise Exception(f"SocketServer: Server hasn't yet established connection with client!")
        self._client.send(data.encode())
        logging.info(f"SocketServer: Data sent: {data}")

    def get_port(self):
        return self._socket.getsockname()[1]

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
