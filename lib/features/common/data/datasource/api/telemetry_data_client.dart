import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  final String address;
  late WebSocketChannel channel;

  TelemetryDataClient(this.address);

  Stream<dynamic> listen() {
    final uri = Uri.parse('ws://$address');
    channel = WebSocketChannel.connect(uri);
    return channel.stream;
  }

  void disconnect() => channel.sink.close();
}
