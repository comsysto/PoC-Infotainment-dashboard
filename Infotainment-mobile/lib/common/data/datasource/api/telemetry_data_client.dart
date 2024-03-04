import 'dart:developer';

import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/throttle_controls.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  late WebSocketChannel telemetryChannel;
  late WebSocketChannel commandChannel;

  TelemetryDataClient() {
    openCommandSocket();
  }

  Stream<dynamic> listen() {
    final uri = Uri.parse('ws://10.100.3.72:56035/mercedes/carMock/update');
    telemetryChannel = WebSocketChannel.connect(uri);

    return telemetryChannel.stream;
  }

  void openCommandSocket() {
    final uri = Uri.parse('ws://10.100.3.72:56035/mercedes/carMock/command');
    commandChannel = WebSocketChannel.connect(uri);
  }

  void sendCommand({BlinkerEnum? blinkerEnum, VelocityEnum? velocityEnum}) {
    if (blinkerEnum != null) {
      commandChannel.sink.add(
        '''{
          "commands": {
            "blinker": "${blinkerEnum.name}",
            "velocity": null
          }
        }''',
      );
    } else if (velocityEnum != null) {
      log('Sending velocity command:${velocityEnum.name}');
      commandChannel.sink.add(
        '''{
          "commands": {
            "blinker": null,
            "velocity": "${velocityEnum.name}"
          }
        }''',
      );
    }
  }

  void disconnect() => telemetryChannel.sink.close();
}
