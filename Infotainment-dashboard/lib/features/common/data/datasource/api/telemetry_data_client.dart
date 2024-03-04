import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  late WebSocketChannel channel;

  Stream<dynamic> listen() {
    final uri = Uri.parse('ws://10.100.3.72:56034');
    channel = WebSocketChannel.connect(uri);
    return channel.stream;
  }

  void disconnect() => channel.sink.close();
}
