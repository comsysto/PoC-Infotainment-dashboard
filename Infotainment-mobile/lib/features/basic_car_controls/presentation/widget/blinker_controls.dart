import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/common/presentation/widgets/action_button.dart';
import 'package:infotainment_mobile_app/core/di/di.dart';

class BlinkerControls extends HookConsumerWidget {
  const BlinkerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blinkerState = ref.watch(blinkerControllerProvider);

    final hazardVisibility = useState(false);

    final blinkerVisibility = useState({
      BlinkerEnum.left: false,
      BlinkerEnum.right: false,
    });

    final turnOff = useCallback(
      () {
        hazardVisibility.value = false;
        blinkerVisibility.value = {
          BlinkerEnum.left: false,
          BlinkerEnum.right: false,
        };
      },
      [hazardVisibility, blinkerVisibility, blinkerState],
    );

    final turnOnHazard = useCallback(
      () {
        hazardVisibility.value = !hazardVisibility.value;
        blinkerVisibility.value = {
          BlinkerEnum.left: hazardVisibility.value,
          BlinkerEnum.right: hazardVisibility.value,
        };
      },
      [hazardVisibility, blinkerVisibility, blinkerState],
    );

    final turnOnSingleBlinker = useCallback(
      () {
        blinkerVisibility.value = {
          BlinkerEnum.left: blinkerState == BlinkerEnum.left
              ? !blinkerVisibility.value[BlinkerEnum.left]!
              : false,
          BlinkerEnum.right: blinkerState == BlinkerEnum.right
              ? !blinkerVisibility.value[BlinkerEnum.right]!
              : false,
        };
      },
      [hazardVisibility, blinkerVisibility, blinkerState],
    );

    useEffect(() {
      final timer = Timer.periodic(
        const Duration(milliseconds: 500),
        (_) {
          if (blinkerState == null) {
            turnOff();
          } else if (blinkerState == BlinkerEnum.hazard) {
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
        ...BlinkerEnum.values.where((element) => element != BlinkerEnum.off).mapIndexed(
          (index, blinker) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ActionButton(
                  onPressed: () => ref.read(blinkerControllerProvider.notifier).setBlinker(blinker),
                  child: Opacity(
                    opacity: _getBlinkerOpacity(
                      indicator: blinker,
                      blinkerVisibility: blinkerVisibility.value,
                    ),
                    child: SvgPicture.asset(
                      blinker.icon!,
                      width: 60,
                      height: 40,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  double _getBlinkerOpacity({
    required BlinkerEnum indicator,
    required Map<BlinkerEnum, bool> blinkerVisibility,
  }) {
    if (indicator == BlinkerEnum.hazard) {
      return blinkerVisibility[BlinkerEnum.left]! && blinkerVisibility[BlinkerEnum.right]!
          ? 1.0
          : 0.7;
    }
    return blinkerVisibility[indicator]! ? 1.0 : 0.3;
  }
}

enum BlinkerEnum {
  left(icon: 'assets/icons/left_blinker_on.svg'),
  hazard(icon: 'assets/icons/hazard_lights.svg'),
  right(icon: 'assets/icons/right_blinker_on.svg'),
  off;

  const BlinkerEnum({this.icon});

  final String? icon;
}
