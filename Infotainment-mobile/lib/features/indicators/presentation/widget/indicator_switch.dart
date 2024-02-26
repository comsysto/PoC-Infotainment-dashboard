import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/features/indicators/domain/indicator_enum.dart';

class IndicatorSwitch extends HookConsumerWidget {
  const IndicatorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndicator = useState<IndicatorEnum?>(null);
    return Container();
  }
}
