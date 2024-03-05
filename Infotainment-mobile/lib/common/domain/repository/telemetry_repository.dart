import 'package:infotainment_mobile_app/common/domain/entity/telemetry_data.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

abstract interface class TelemetryRepository {
  Stream<TelemetryData> listen();

  Stream<dynamic> listenCommandChannel();

  void setBlinker(final BlinkerEnum blinker);

  void increaseVelocity();

  void decreaseVelocity();

  void sendEmptyRequest();
}
