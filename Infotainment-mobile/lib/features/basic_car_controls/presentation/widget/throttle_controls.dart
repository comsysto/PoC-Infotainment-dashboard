import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/common/presentation/widgets/action_button.dart';
import 'package:infotainment_mobile_app/core/di/di.dart';

class ThrottleControls extends HookConsumerWidget {
  const ThrottleControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ActionButton(
              onPressed: () {
                ref.read(telemetryControllerProvider).decreaseVelocity();
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                constraints: const BoxConstraints(
                  maxHeight: 96,
                ),
                child: SvgPicture.asset(
                  'assets/icons/brake_pedal.svg',
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ActionButton(
              onPressed: () {
                ref.read(telemetryControllerProvider).increaseVelocity();
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 96,
                ),
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/icons/gas_pedal.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum VelocityEnum {
  increase,
  decrease,
}
