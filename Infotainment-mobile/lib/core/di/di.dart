import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/common/data/datasource/api/telemetry_data_client.dart';
import 'package:infotainment_mobile_app/common/data/repository/telemetry_repository_impl.dart';
import 'package:infotainment_mobile_app/common/domain/entity/telemetry_data.dart';
import 'package:infotainment_mobile_app/common/domain/repository/telemetry_repository.dart';
import 'package:infotainment_mobile_app/common/presentation/controller/network_config_notifier.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/controller/blinker_controller.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/controller/telemetry_controller.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

/* DATASOURCE */
final networkConfigProvider = NotifierProvider<NetworkConfigNotifier, String>(
  () => NetworkConfigNotifier(),
);

final telemetryDataClientProvider = Provider<TelemetryDataClient>(
  (ref) {
    final ipAddress = ref.watch(networkConfigProvider);
    return TelemetryDataClient(ipAddress);
  },
);

/* REPOSITORY */
final telemetryRepositoryProvider = Provider<TelemetryRepository>(
  (ref) => TelemetryRepositoryImpl(ref.watch(telemetryDataClientProvider)),
);

/* CONTROLLER */
final telemetryProvider = StreamProvider<TelemetryData>(
  (ref) => TelemetryController(ref.watch(telemetryRepositoryProvider)).listen(),
);

final commandChannelProvider = StreamProvider<dynamic>(
  (ref) => TelemetryController(ref.watch(telemetryRepositoryProvider)).listenCommandChannel(),
);

final telemetryControllerProvider = Provider<TelemetryController>(
  (ref) => TelemetryController(ref.watch(telemetryRepositoryProvider)),
);

final blinkerControllerProvider = StateNotifierProvider<BlinkerController, BlinkerEnum?>(
  (ref) => BlinkerController(ref.watch(telemetryRepositoryProvider)),
);
