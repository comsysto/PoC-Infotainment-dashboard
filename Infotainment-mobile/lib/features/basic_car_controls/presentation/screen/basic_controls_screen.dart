import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/indicator_switch.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BasicControlsScreen extends HookConsumerWidget {
  const BasicControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mercedes crni, brzi'),
        actions: [],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: MultiSliver(
              children: [
                IndicatorSwitch(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
