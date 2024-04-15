import 'dart:async';

import 'package:infotainment/core/util/custom_logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  final String address;
  final CustomLogger logger;

  late WebSocketChannel channel;
  late StreamController controller;

  TelemetryDataClient(this.address, this.logger);

  Stream<dynamic> listen() {
    logger.debug('About to listen on websocket address: $address');
    controller = StreamController<dynamic>();
    _connectWithRetry(20);
    return controller.stream;
  }

  void _connectWithRetry(int retryCount) {
    try {
      final uri = Uri.parse('ws://$address');
      channel = WebSocketChannel.connect(uri);
      logger.debug('Websocket connected to $address');

      channel.stream.listen(
        (message) {
          logger.debug('Recevied message from websocket: $message');
          controller.add(message);
        },
        onError: (error) {
          logger.error('onError: $error');
          if (retryCount != 0) {
            logger.error('onError: About to retry to connect, remaining attempts: $retryCount');
            Future.delayed(const Duration(seconds: 1), () => _connectWithRetry(retryCount - 1));
          } else {
            logger.error('onError: Connection to websocket $address closed.');
            disconnect();
            controller.close();
            return;
          }
        },
        onDone: () {
          logger.debug('onDone: Websocket is closing...');
          controller.close();
        },
        cancelOnError: true,
      );
    } catch (e) {
      logger.error('Error while connecting to the websocket.');
      if (retryCount != 0) {
        logger.error('Error: About to retry to connect, remaining attempts: $retryCount');
        Future.delayed(const Duration(seconds: 1), () => _connectWithRetry(retryCount - 1));
      } else {
        logger.error('Error: Connection to websocket $address closed.');
        disconnect();
        controller.close();
      }
    }
  }

  void disconnect() {
    channel.sink.close();
    logger.debug('Disconnected from websocket: $address');
  }
}
