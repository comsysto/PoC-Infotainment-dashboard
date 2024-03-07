import 'dart:async';
import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  final String address;
  late WebSocketChannel channel;
  late IOSink _logSink;

  TelemetryDataClient(this.address) {
    _initializeLogging();
  }

  void _initializeLogging() {
    File logFile = File('telemetry_data_client.log');
    _logSink = logFile.openWrite(mode: FileMode.append);
  }

  void _log(String message) {
    _logSink.writeln('[${DateTime.now()}] $message');
  }

  Stream<dynamic> listen() {
    _log('Listening on websocket address $address');
    StreamController<dynamic> controller = StreamController<dynamic>();

    void connectWithRetry(int retryCount) {
      try {
        final uri = Uri.parse('ws://$address');
        channel = WebSocketChannel.connect(uri);
        _log('Websocket Connected to: $address');

        // Listen for messages from the WebSocket channel
        channel.stream.listen(
          (message) {
            _log('Received message from websocket: $message');
            controller.add(message);
          },
          onError: (error) {
            _log('onError(): Error receiving message from websocket: $error');
            if (retryCount < 1000) {
              _log('onError(): Retrying to Connect to websocket $address, count: $retryCount');
              Future.delayed(Duration(seconds: 1), () {
                connectWithRetry(retryCount + 1);
              });
            } else {
              _log('onError(): Connection to websocket $address closed.');
              controller.close();
            }
          },
          onDone: () {
            _log('onDone(): Connection to websocket $address closed.');
            controller.close();
          },
          cancelOnError: true,
        );
      } catch (error) {
        _log('Error connecting to socket: $error');
        if (retryCount < 1000) {
          _log('Error: Retrying to Connect to websocket $address, count: $retryCount');
          Future.delayed(Duration(seconds: 1), () {
            connectWithRetry(retryCount + 1);
          });
        } else {
          _log('Error: Connection to websocket $address closed.');
          controller.close();
        }
      }
    }

    connectWithRetry(0);
    return controller.stream;
  }

  void disconnect() {
    channel.sink.close();
    _log('Disconnected from websocket $address.');
    _logSink.close();
  }
}
