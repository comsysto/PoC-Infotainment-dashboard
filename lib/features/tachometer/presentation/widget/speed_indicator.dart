import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/di.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';

class SpeedIndicator extends ConsumerWidget {
  const SpeedIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tachometerTelemetry = ref.watch(telemetryProvider);
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tachometerTelemetry.when(
                data: (telemetry) => Text(
                  '${telemetry.speed}',
                  style: context.textStyle.speedIndicator,
                ),
                error: (error, _) => const Text('Error'),
                loading: () => const Text(''),
              ),
              Text('km/h', style: context.textStyle.tachoLabel),
            ],
          ),
          Positioned(
            bottom: 160,
            left: 87,
            child: Image.asset(
              'assets/images/speed_ornament.png',
              width: 450,
            ),
          ),
        ],
      ),
    );
  }
}
