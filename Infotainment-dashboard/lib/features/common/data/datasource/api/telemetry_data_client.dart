import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  late WebSocketChannel channel;

  Stream<dynamic> listen() {
    final uri = Uri.parse('ws://10.0.2.2:56034');
    channel = WebSocketChannel.connect(uri);
    return channel.stream;
  }

  void disconnect() => channel.sink.close();
}
