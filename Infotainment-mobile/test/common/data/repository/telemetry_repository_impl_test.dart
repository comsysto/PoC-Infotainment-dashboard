import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:infotainment_mobile_app/common/data/datasource/api/telemetry_data_client.dart';
import 'package:infotainment_mobile_app/common/data/repository/telemetry_repository_impl.dart';
import 'package:infotainment_mobile_app/common/domain/entity/telemetry_data.dart';
import 'package:infotainment_mobile_app/common/domain/repository/telemetry_repository.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/throttle_controls.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'telemetry_repository_impl_test.mocks.dart';

@GenerateMocks([TelemetryDataClient])
void main() {
  late MockTelemetryDataClient mockTelemetryDataClient;
  late TelemetryRepository telemetryRepository;

  setUp(() {
    mockTelemetryDataClient = MockTelemetryDataClient();
    telemetryRepository = TelemetryRepositoryImpl(mockTelemetryDataClient);
  });

  group('listen for telemetry data updates', () {
    const json = '{"telemetry": {"dpfWarning": true, "battery": 85.145778, "rpm": 353.102911, "velocity": 18.488425}, "controls": {"blinker": "off"}}';
    const TelemetryData telemetry = TelemetryData(
      dpfWarning: true,
      batteryLevel: 85.145778,
      rpm: 353,
      speed: 18,
      blinker: BlinkerEnum.off,
    );

    test(
      'should return stream of telemetry data on success',
      () async {
        // arrange
        when(mockTelemetryDataClient.listen()).thenAnswer((_) => Stream.fromIterable([json]));
        // act
        final result = telemetryRepository.listen();
        // assert
        expect(result, emitsInOrder([telemetry]));
      },
    );
  });

  group('blinker command', () {
    const TelemetryData telemetry = TelemetryData(
      dpfWarning: false,
      batteryLevel: 55.4,
      speed: 120,
      rpm: 2434,
      blinker: null,
    );
    final StreamController controller = StreamController<TelemetryData>();

    test('should successfully send blinker command', () async {
      // arrange
      when(mockTelemetryDataClient.sendCommand(blinkerEnum: BlinkerEnum.left)).thenAnswer((_) {
        controller.add(telemetry);
      });
      // act
      telemetryRepository.setBlinker(BlinkerEnum.left);

      // assert
      verify(mockTelemetryDataClient.sendCommand(blinkerEnum: BlinkerEnum.left)).called(1);
      expectLater(controller.stream, emitsInOrder([telemetry]));
    });
  });

  group('velocity commands', () {
    const command = '''{
          "commands": {
            "blinker": null,
            "velocity": "null"
          }
        }''';
    final StreamController controller = StreamController<String>.broadcast();

    test('should successfully send increase velocity command', () async {
      // arrange
      when(mockTelemetryDataClient.sendCommand(velocityEnum: VelocityEnum.increase))
          .thenAnswer((_) => controller.add(command));
      expectLater(controller.stream, emitsInOrder([command]));
      // act
      telemetryRepository.increaseVelocity();

      // assert
      verify(mockTelemetryDataClient.sendCommand(velocityEnum: VelocityEnum.increase)).called(1);
    });

    test('should successfully send decrease velocity command', () async {
      // arrange
      when(mockTelemetryDataClient.sendCommand(velocityEnum: VelocityEnum.decrease))
          .thenAnswer((_) => controller.add(command));
      expectLater(controller.stream, emitsInOrder([command]));
      // act
      telemetryRepository.decreaseVelocity();

      // assert
      verify(mockTelemetryDataClient.sendCommand(velocityEnum: VelocityEnum.decrease)).called(1);
    });

    test('should successfully send empty command', () async {
      // arrange
      when(mockTelemetryDataClient.sendCommand()).thenAnswer((_) => controller.add(command));
      expectLater(controller.stream, emitsInOrder([command]));
      // act
      telemetryRepository.sendEmptyRequest();

      // assert
      verify(mockTelemetryDataClient.sendCommand()).called(1);
    });
  });
}
