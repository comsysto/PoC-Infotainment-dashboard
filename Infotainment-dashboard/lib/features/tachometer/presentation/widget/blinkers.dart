import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment/features/tachometer/presentation/controller/blinker_controller.dart';

class Blinkers extends HookConsumerWidget {
  const Blinkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leftAnimationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final rightAnimationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    final isLeftVisible = useState(false);
    final isRightVisible = useState(false);

    final isLeftOn = ref.watch(blinkerController.select((provider) => provider.isLeftOn));
    final isRightOn = ref.watch(blinkerController.select((provider) => provider.isRightOn));

    useEffect(() {
      if (isLeftOn) {
        final timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
          isLeftVisible.value = !isLeftVisible.value;
          leftAnimationController.reset();
          isLeftVisible.value
              ? leftAnimationController.forward()
              : leftAnimationController.reverse();
        });
        return () => timer.cancel();
      } else {
        leftAnimationController.reset();
        isLeftVisible.value = false;
      }
      return null;
    }, [isLeftOn]);

    useEffect(() {
      if (isRightOn) {
        final timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
          isRightVisible.value = !isRightVisible.value;
          rightAnimationController.reset();
          isRightVisible.value
              ? rightAnimationController.forward()
              : rightAnimationController.reverse();
        });
        return () => timer.cancel();
      }
      else {
        rightAnimationController.reset();
        isRightVisible.value = false;
      }
      return null;
    }, [isRightOn]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedOpacity(
          opacity: isLeftVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
            'assets/icons/left-blinker.png',
            height: 50,
          ),
        ),
        AnimatedOpacity(
          opacity: isRightVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
            'assets/icons/right-blinker.png',
            height: 50,
          ),
        ),
      ],
    );
  }
}
