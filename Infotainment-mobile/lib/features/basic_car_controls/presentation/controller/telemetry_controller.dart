import 'package:infotainment_mobile_app/common/domain/entity/telemetry_data.dart';
import 'package:infotainment_mobile_app/common/domain/repository/telemetry_repository.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

class TelemetryController {
  final TelemetryRepository _telemetryRepository;

  const TelemetryController(this._telemetryRepository);

  Stream<TelemetryData> listen() => _telemetryRepository.listen();

  Stream<dynamic> listenCommandChannel() => _telemetryRepository.listenCommandChannel();

  void setBlinker(final BlinkerEnum blinker) {
    _telemetryRepository.setBlinker(blinker);
  }

  void increaseVelocity() {
    _telemetryRepository.increaseVelocity();
  }

  void decreaseVelocity() {
    _telemetryRepository.decreaseVelocity();
  }

  void sendEmptyRequest() {
    _telemetryRepository.sendEmptyRequest();
  }
}
