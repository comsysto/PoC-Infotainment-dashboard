import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';
import 'package:infotainment/features/tachometer/presentation/controller/tachometer_provider.dart';

class RPMCounter extends ConsumerWidget {
  const RPMCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tachometerTelemetry = ref.watch(tachometerProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        tachometerTelemetry.when(
          data: (telemetry) => Text('${telemetry.rpm}', style: context.textStyle.rpm),
          error: (error, _) => const Text(''),
          loading: () => const Text(''),
        ),
        Text('RPM', style: context.textStyle.tachoLabel),
      ],
    );
  }
}
