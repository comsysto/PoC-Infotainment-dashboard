import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  final String address;
  late WebSocketChannel channel;

  TelemetryDataClient(this.address);

  // Stream<dynamic> listen() {
  //   final uri = Uri.parse('ws://$address');
  //   channel = WebSocketChannel.connect(uri);
  //   return channel.stream;
  // }

  Stream<dynamic> listen() {
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
              print('Retrying to Connect to websocket $address, count: $retryCount');
              connectWithRetry(retryCount + 1);
            });
          } else {
            controller.addError(error);
            controller.close();
          }
        },
        onDone: () {
          controller.close();
        },
        cancelOnError: true,
      );
    }

    connectWithRetry(0);

    return controller.stream;
  }


  void disconnect() => channel.sink.close();
}
