import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment/core/di.dart';

const inactiveColor = Color(0x9C6F6F6F);

class VehicleIndicators extends HookConsumerWidget {
  const VehicleIndicators({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetry = ref.watch(telemetryProvider);

    final previousSpeed = useState(0);
    final isBraking = useState(false);

    return telemetry.when(
      error: (_, trace) => const SizedBox(),
      loading: () => const SizedBox(),
      data: (telemetry) {
        isBraking.value = telemetry.speed < previousSpeed.value;
        previousSpeed.value = telemetry.speed;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/high-beam.png',
              height: 50,
              color: inactiveColor,
            ),
            Image.asset(
              'assets/icons/low-beam.png',
              height: 50,
            ),
            Image.asset(
              'assets/icons/fog-light-front.png',
              height: 50,
              color: inactiveColor,
            ),
            Image.asset(
              'assets/icons/fog-light-rear.png',
              height: 50,
              color: inactiveColor,
            ),
            Image.asset(
              'assets/icons/check-engine.png',
              height: 50,
              color: telemetry.dpfWarning ? null : inactiveColor,
            ),
            Image.asset(
              'assets/icons/oil.png',
              height: 50,
              color: inactiveColor,
            ),
            Image.asset(
              'assets/icons/battery.png',
              height: 50,
              color: telemetry.batteryLevel <= 60 ? null : inactiveColor,
            ),
            Image.asset(
              'assets/icons/engine-coolant.png',
              height: 50,
              color: inactiveColor,
            ),
            Image.asset(
              'assets/icons/brake-warning.png',
              height: 50,
              color: isBraking.value ? null : inactiveColor,
            ),
            Image.asset(
              'assets/icons/doors.png',
              height: 50,
              color: inactiveColor,
            ),
          ],
        );
      },
    );
  }
}
