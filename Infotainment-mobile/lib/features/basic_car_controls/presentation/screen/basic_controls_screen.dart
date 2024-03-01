import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/telemetry_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BasicControlsScreen extends HookConsumerWidget {
  const BasicControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryIcon = useMemoized(
      () {
        return const Icon(
          Icons.battery_2_bar,
          size: 40,
          color: Colors.red,
        );
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/mercedes_logo.png',
              height: 40,
            ),
            const SizedBox(width: 24),
            Text(
              'E350d 4Matic',
              style: context.textTitle,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: MultiSliver(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 16),
                  child: Image.asset(
                    'assets/images/mercedes_e350d.png',
                    height: 140,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: 1 / 2 * math.pi,
                          child: batteryIcon,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '23%',
                          style: context.textBody,
                        ),
                      ],
                    ),
                    const SizedBox(width: 28),
                    SvgPicture.asset(
                      'assets/icons/check_engine_light.svg',
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.red,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: TelemetryCard(
                    title: 'Current speed',
                    value: '0',
                    type: TelemetryType.speed,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TelemetryCard(
                    title: 'Current RPM',
                    value: '0',
                    type: TelemetryType.rpm,
                  ),
                ),
                const BlinkerControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
