import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/common/domain/repository/telemetry_repository.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

class BlinkerController extends StateNotifier<BlinkerEnum?> {
  final TelemetryRepository _telemetryRepository;
  BlinkerController(this._telemetryRepository) : super(null);

  void setBlinker(final BlinkerEnum blinker) {
    state = state == blinker ? null : blinker;
    _telemetryRepository.setBlinker(state ?? BlinkerEnum.off);
  }
}
