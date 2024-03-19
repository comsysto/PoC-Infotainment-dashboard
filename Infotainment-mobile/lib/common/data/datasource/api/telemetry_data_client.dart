import 'dart:developer';

import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/throttle_controls.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TelemetryDataClient {
  final String address;
  late WebSocketChannel telemetryChannel;
  late WebSocketChannel commandChannel;

  TelemetryDataClient(this.address) {
    openCommandSocket();
  }

  Stream<dynamic> listen() {
    final uri = Uri.parse('ws://$address/mercedes/carMock/update');
    telemetryChannel = WebSocketChannel.connect(uri);

    return telemetryChannel.stream;
  }

  Stream<dynamic> listenCommandChannel() => commandChannel.stream;

  void openCommandSocket() {
    final uri = Uri.parse('ws://$address/mercedes/carMock/command');
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
    } else {
      commandChannel.sink.add(
        '''{
          "commands": {
            "blinker": null,
            "velocity": null
          }
        }''',
      );
    }
  }

  void disconnect() => telemetryChannel.sink.close();
}
