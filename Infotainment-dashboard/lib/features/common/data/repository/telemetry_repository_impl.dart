import 'dart:io';
import 'dart:convert';

import 'package:infotainment/features/common/data/datasource/api/telemetry_data_client.dart';
import 'package:infotainment/features/common/data/datasource/globals.dart';
import 'package:infotainment/features/common/domain/entity/telemetry_data.dart';
import 'package:infotainment/features/common/domain/repository/telemetry_repository.dart';

class TelemetryRepositoryImpl implements TelemetryRepository {
  final TelemetryDataClient _client;
  late IOSink _logSink;

  TelemetryRepositoryImpl(this._client) {
    _initializeLogging();
  }

  void _initializeLogging() {
    File logFile = File('telemetry_repository.log');
    _logSink = logFile.openWrite(mode: FileMode.append);
  }

  void _log(String message) {
    _logSink.writeln('[${DateTime.now()}] $message');
  }

  @override
  Stream<TelemetryData> listen() {
    _log('Client starting to listen from websocket!');
    return _client.listen().map((event) {
      final json = jsonDecode(event);
      _log('Received data from websocket: $json');
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
