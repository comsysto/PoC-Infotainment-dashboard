import 'package:collection/collection.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

class TelemetryData {
  final bool dpfWarning;
  final double batteryLevel;
  final int speed;
  final int rpm;
  final BlinkerEnum? blinker;

  const TelemetryData({
    required this.dpfWarning,
    required this.batteryLevel,
    required this.speed,
    required this.rpm,
    required this.blinker,
  });

  factory TelemetryData.fromJson(Map<String, dynamic> json) {
    final telemetryJson = json['telemetry'] as Map<String, dynamic>;
    return TelemetryData(
      dpfWarning: telemetryJson['dpfWarning'] as bool,
      batteryLevel: telemetryJson['battery'] as double,
      speed: (telemetryJson['velocity'] as double?)?.round() ?? 0,
      rpm: (telemetryJson['rpm'] as double?)?.round() ?? 0,
      blinker: telemetryJson['blinker'] != null
          ? BlinkerEnum.values.firstWhereOrNull((e) => e.toString() == telemetryJson['blinker'])
          : null,
    );
  }

  TelemetryData copyWith({
    bool? dpfWarning,
    double? batteryLevel,
    int? speed,
    int? rpm,
    BlinkerEnum? blinker,
  }) {
    return TelemetryData(
      dpfWarning: dpfWarning ?? this.dpfWarning,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      blinker: blinker ?? this.blinker,
    );
  }

  @override
  String toString() =>
      'DPF: $dpfWarning, Battery: $batteryLevel, Speed: $speed, RPM: $rpm, Blinker: $blinker';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TelemetryData &&
        other.dpfWarning == dpfWarning &&
        other.batteryLevel == batteryLevel &&
        other.speed == speed &&
        other.rpm == rpm &&
        other.blinker == blinker;
  }

  @override
  int get hashCode => Object.hash(dpfWarning, batteryLevel, speed, rpm, blinker);
}
