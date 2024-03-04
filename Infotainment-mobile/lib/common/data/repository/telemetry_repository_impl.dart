import 'dart:convert';

import 'package:infotainment_mobile_app/common/data/datasource/api/telemetry_data_client.dart';
import 'package:infotainment_mobile_app/common/data/datasource/globals.dart';
import 'package:infotainment_mobile_app/common/domain/entity/telemetry_data.dart';
import 'package:infotainment_mobile_app/common/domain/repository/telemetry_repository.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/throttle_controls.dart';

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

  @override
  void setBlinker(final BlinkerEnum blinker) {
    _client.sendCommand(blinkerEnum: blinker);
  }

  @override
  void increaseVelocity() {
    _client.sendCommand(velocityEnum: VelocityEnum.increase);
  }

  @override
  void decreaseVelocity() {
    _client.sendCommand(velocityEnum: VelocityEnum.decrease);
  }

  BlinkerEnum readBlinker(final TelemetryData telemetry) {
    if (telemetry.blinker != null) {
      blinkerState = telemetry.blinker!;
    }
    return blinkerState;
  }
}