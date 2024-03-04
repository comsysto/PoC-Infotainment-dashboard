import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment/core/di.dart';
import 'package:infotainment/features/common/domain/entity/telemetry_data.dart';

class Blinkers extends HookConsumerWidget {
  const Blinkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blinkerState = ref.watch(telemetryProvider).asData?.value.blinker ?? Blinker.off;

    final isLeftOn = useState(false);
    final isRightOn = useState(false);
    final isHazardOn = useState(false);

    useEffect(() {
      final timer = Timer.periodic(
        const Duration(milliseconds: 500),
        (_) {
          if (blinkerState == Blinker.left) {
            isLeftOn.value = !isLeftOn.value;
          } else if (blinkerState == Blinker.right) {
            isRightOn.value = !isRightOn.value;
          } else if (blinkerState == Blinker.hazard) {
            isLeftOn.value = false;
            isRightOn.value = false;
            isHazardOn.value = !isHazardOn.value;
          } else if (blinkerState == Blinker.off) {
            isLeftOn.value = false;
            isRightOn.value = false;
            isHazardOn.value = false;
          } else {
            return;
          }
        },
      );
      return () {
        timer.cancel();
      };
    }, [blinkerState, isLeftOn, isRightOn, isHazardOn]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedOpacity(
          opacity: isLeftOn.value || isHazardOn.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Image.asset(
            'assets/icons/left-blinker.png',
            height: 50,
          ),
        ),
        AnimatedOpacity(
          opacity: isRightOn.value || isHazardOn.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Image.asset(
            'assets/icons/right-blinker.png',
            height: 50,
          ),
        ),
      ],
    );
  }
}
