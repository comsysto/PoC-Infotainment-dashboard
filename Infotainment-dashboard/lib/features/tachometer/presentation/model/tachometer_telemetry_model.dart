class TachometerTelemetryModel {
  final int speed;
  final int rpm;

  const TachometerTelemetryModel({required this.speed, required this.rpm});

  factory TachometerTelemetryModel.fromJson(Map<String, dynamic> json) {
    return TachometerTelemetryModel(
      speed: json['speed'],
      rpm: json['mph'],
    );
  }
}
