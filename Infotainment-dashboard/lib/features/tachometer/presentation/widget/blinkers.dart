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
    final blinkerState = ref.watch(telemetryProvider).asData?.value.blinker;

    final hazardVisibility = useState(false);

    final blinkerVisibility = useState({
      Blinker.left: false,
      Blinker.right: false,
    });

    final turnOff = useCallback(
      () {
        hazardVisibility.value = false;
        blinkerVisibility.value = {
          Blinker.left: false,
          Blinker.right: false,
        };
      },
      [hazardVisibility, blinkerVisibility, blinkerState],
    );

    final turnOnHazard = useCallback(
      () {
        hazardVisibility.value = !hazardVisibility.value;
        blinkerVisibility.value = {
          Blinker.left: hazardVisibility.value,
          Blinker.right: hazardVisibility.value,
        };
      },
      [hazardVisibility, blinkerVisibility, blinkerState],
    );

    final turnOnSingleBlinker = useCallback(
      () {
        blinkerVisibility.value = {
          Blinker.left:
              blinkerState == Blinker.left ? !blinkerVisibility.value[Blinker.left]! : false,
          Blinker.right:
              blinkerState == Blinker.right ? !blinkerVisibility.value[Blinker.right]! : false,
        };
      },
      [hazardVisibility, blinkerVisibility, blinkerState],
    );

    useEffect(() {
      final timer = Timer.periodic(
        const Duration(milliseconds: 500),
        (_) {
          if (blinkerState == Blinker.off || blinkerState == null) {
            turnOff();
          }
          if (blinkerState == Blinker.hazard) {
            turnOnHazard();
          } else {
            turnOnSingleBlinker();
          }
        },
      );
      return () => timer.cancel();
    }, [blinkerState, turnOnHazard, turnOnSingleBlinker, turnOff]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedOpacity(
          opacity: _getBlinkerOpacity(
              indicator: Blinker.left, blinkerVisibility: blinkerVisibility.value),
          duration: const Duration(milliseconds: 100),
          child: Image.asset(
            'assets/icons/left-blinker.png',
            height: 50,
          ),
        ),
        AnimatedOpacity(
          opacity: _getBlinkerOpacity(
              indicator: Blinker.right, blinkerVisibility: blinkerVisibility.value),
          duration: const Duration(milliseconds: 100),
          child: Image.asset(
            'assets/icons/right-blinker.png',
            height: 50,
          ),
        ),
      ],
    );
  }

  double _getBlinkerOpacity({
    required Blinker indicator,
    required Map<Blinker, bool> blinkerVisibility,
  }) {
    if (indicator == Blinker.hazard) {
      return blinkerVisibility[Blinker.left]! && blinkerVisibility[Blinker.right]! ? 1.0 : 0.0;
    }
    return blinkerVisibility[indicator]! ? 1.0 : 0.0;
  }
}
