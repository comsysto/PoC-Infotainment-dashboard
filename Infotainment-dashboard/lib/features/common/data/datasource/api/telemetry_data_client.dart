import 'dart:async';

import 'package:infotainment/features/common/util/custom_logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  final String address;
  final CustomLogger logger;
  late WebSocketChannel channel;

  TelemetryDataClient(this.address, this.logger);

  Stream<dynamic> listen() {
    logger.debug('Listening on websocket address $address');
    StreamController<dynamic> controller = StreamController<dynamic>();

    void connectWithRetry(int retryCount) {
      try {
        final uri = Uri.parse('ws://$address');
        channel = WebSocketChannel.connect(uri);
        logger.debug('Websocket Connected to: $address');

        channel.stream.listen(
          (message) {
            logger.debug('Received message from websocket: $message');
            controller.add(message);
          },
          onError: (error) {
            logger.error('onError(): Error receiving message from websocket: $error');
            if (retryCount < 1000) {
              logger.error(
                'onError(): Retrying to Connect to websocket $address, count: $retryCount',
              );
              Future.delayed(const Duration(seconds: 1), () => connectWithRetry(retryCount + 1));
            } else {
              logger.error('onError(): Connection to websocket $address closed.');
              controller.close();
            }
          },
          onDone: () {
            logger.debug('onDone(): Connection to websocket $address closed.');
            controller.close();
          },
          cancelOnError: true,
        );
      } catch (error) {
        logger.error('Error connecting to socket: $error');
        if (retryCount < 1000) {
          logger.error('Error: Retrying to Connect to websocket $address, count: $retryCount');
          Future.delayed(const Duration(seconds: 1), () => connectWithRetry(retryCount + 1));
        } else {
          logger.error('Error: Connection to websocket $address closed.');
          controller.close();
        }
      }
    }

    connectWithRetry(0);
    return controller.stream;
  }

  void disconnect() {
    channel.sink.close();
    logger.debug('Disconnected from websocket $address.');
  }
}
