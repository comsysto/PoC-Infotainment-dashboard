import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/util/custom_logger.dart';
import 'package:infotainment/features/common/data/datasource/api/telemetry_data_client.dart';
import 'package:infotainment/features/common/data/repository/telemetry_repository_impl.dart';
import 'package:infotainment/features/common/domain/entity/telemetry_data.dart';
import 'package:infotainment/features/common/domain/repository/telemetry_repository.dart';
import 'package:infotainment/features/common/presentation/controller/telemetry_controller.dart';

/* API CLIENT */
String ipAddress = '10.100.3.90:56034';
String ipAddressMobile = '10.100.3.90:56035';
final telemetryDataClientProvider = Provider<TelemetryDataClient>(
  (ref) => TelemetryDataClient(ipAddress, CustomLogger.instance),
);

/* REPOSITORY */
final telemetryRepositoryProvider = Provider<TelemetryRepository>(
  (ref) => TelemetryRepositoryImpl(ref.watch(telemetryDataClientProvider)),
);

/* CONTROLLER */
final telemetryProvider = StreamProvider<TelemetryData>(
  (ref) => TelemetryController(ref.watch(telemetryRepositoryProvider)).listen(),
);
