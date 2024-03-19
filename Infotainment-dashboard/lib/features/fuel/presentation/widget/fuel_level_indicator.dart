import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/di.dart';
import 'package:infotainment/core/style/colors.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';

class FuelLevelIndicator extends ConsumerWidget {
  const FuelLevelIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetry = ref.watch(telemetryProvider);
    return telemetry.when(
      loading: () => Container(),
      error: (error, stackTrace) => const Text('Error'),
      data: (capacity) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${(capacity.batteryLevel).toInt()}%',
            style: context.textStyle.fuelLevel,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 350,
            child: LinearProgressIndicator(
              minHeight: 10,
              value: capacity.batteryLevel,
              borderRadius: BorderRadius.circular(20),
              color: textColor,
              backgroundColor: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
