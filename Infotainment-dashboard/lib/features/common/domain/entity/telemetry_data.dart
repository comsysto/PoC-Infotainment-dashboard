import 'package:collection/collection.dart';

class TelemetryData {
  final bool dpfWarning;
  final double batteryLevel;
  final int speed;
  final int rpm;
  final Blinker? blinker;

  const TelemetryData({
    required this.dpfWarning,
    required this.batteryLevel,
    required this.speed,
    required this.rpm,
    required this.blinker,
  });

  factory TelemetryData.fromJson(Map<String, dynamic> json) {
    return TelemetryData(
      dpfWarning: json['dpf_warning'] as bool,
      batteryLevel: json['battery_level'],
      speed: (json['velocity'] as double).round(),
      rpm: (json['rpm'] as double).round(),
      blinker: Blinker.values.firstWhereOrNull(
        (blinker) => blinker.name == json['blinker'],
      ),
    );
  }

  TelemetryData copyWith({
    bool? dpfWarning,
    double? batteryLevel,
    int? speed,
    int? rpm,
    Blinker? blinker,
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
}

enum Blinker {
  left,
  right,
  hazard,
  off;
}
