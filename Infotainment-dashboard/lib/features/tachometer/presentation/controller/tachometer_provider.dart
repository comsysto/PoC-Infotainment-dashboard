import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/features/tachometer/presentation/model/tachometer_telemetry_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final _websocketProvider = Provider<WebSocketChannel>((ref) {
  final uri = Uri.parse('ws://10.0.2.2:6365');
  final channel = WebSocketChannel.connect(uri);
  ref.onDispose(() => channel.sink.close());
  return channel;
});

final tachometerProvider = StreamProvider<TachometerTelemetryModel>((ref) {
  final channel = ref.watch(_websocketProvider);
  return channel.stream.map((event) {
    final json = jsonDecode(event);
    return TachometerTelemetryModel.fromJson(json);
  });
});
