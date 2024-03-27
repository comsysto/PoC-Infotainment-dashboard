import 'package:infotainment/features/common/domain/entity/telemetry_data.dart';

abstract interface class TelemetryRepository {
  Stream<TelemetryData> listen();
}