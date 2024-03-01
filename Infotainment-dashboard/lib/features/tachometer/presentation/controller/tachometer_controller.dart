import 'package:infotainment/features/common/domain/entity/telemetry_data.dart';
import 'package:infotainment/features/common/domain/repository/telemetry_repository.dart';

class TelemetryController {
  final TelemetryRepository _telemetryRepository;

  const TelemetryController(this._telemetryRepository);

  Stream<TelemetryData> listen() => _telemetryRepository.listen();
}
