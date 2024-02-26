import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IndicatorSwitch extends HookConsumerWidget {
  const IndicatorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndicator = useState<IndicatorEnum?>(null);
    return Container();
  }
}

enum IndicatorEnum {
  left(icon: 'assets/icons/left-blinker.png'),
  hazard(icon: 'assets/icons/hazard-lights.png'),
  right(icon: 'assets/icons/right-blinker.png');

  const IndicatorEnum({required this.icon});

  final String icon;
}
