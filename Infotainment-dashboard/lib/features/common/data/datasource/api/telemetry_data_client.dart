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
      final uri = Uri.parse('ws://$address');
      channel = WebSocketChannel.connect(uri);
      channel.stream.listen(
        (data) {
          controller.add(data);
        },
        onError: (error) {
          if (retryCount < 1000) {
            Future.delayed(Duration(seconds: 1), () {
              _log('Retrying to Connect to websocket $address, count: $retryCount');
              connectWithRetry(retryCount + 1);
            });
          } else {
            _log('Connection to websocket $address failed after 1000 retries: $error');
            controller.addError(error);
            controller.close();
          }
        },
        onDone: () {
          _log('Connection to websocket $address closed.');
          controller.close();
        },
        cancelOnError: true,
      );
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
