class TachometerTelemetryModel {
  final double speed;
  final double rpm;

  const TachometerTelemetryModel({required this.speed, required this.rpm});

  factory TachometerTelemetryModel.fromJson(Map<String, dynamic> json) {
    return TachometerTelemetryModel(
      speed: json['telemetry']['velocity'],
      rpm: json['telemetry']['rpm'],
    );
  }
}
