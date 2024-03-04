import 'dart:convert';

import 'package:infotainment/features/common/data/datasource/api/telemetry_data_client.dart';
import 'package:infotainment/features/common/data/datasource/globals.dart';
import 'package:infotainment/features/common/domain/entity/telemetry_data.dart';
import 'package:infotainment/features/common/domain/repository/telemetry_repository.dart';

class TelemetryRepositoryImpl implements TelemetryRepository {
  final TelemetryDataClient _client;

  const TelemetryRepositoryImpl(this._client);

  @override
  Stream<TelemetryData> listen() {
    return _client.listen().map((event) {
      final json = jsonDecode(event);
      final telemetry = TelemetryData.fromJson(json);
      final blinker = readBlinker(telemetry);
      return telemetry.copyWith(blinker: blinker);
    });
  }

  Blinker readBlinker(final TelemetryData telemetry) {
    if (telemetry.blinker != null) {
      blinkerState = telemetry.blinker!;
    }
    return blinkerState;
  }
}
