import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/features/indicators/domain/indicator_enum.dart';

class IndicatorSwitch extends HookConsumerWidget {
  const IndicatorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndicator = useState<IndicatorEnum?>(null);
    final indicatorButtonSegments =
        useMemoized<List<ButtonSegment<IndicatorEnum>>>(
      () => IndicatorEnum.values
          .map(
            (e) => ButtonSegment(
              value: e,
              icon: Image.asset(
                e.icon,
                height: 40,
                width: 40,
              ),
            ),
          )
          .toList(),
      [],
    );
    return SegmentedButton<IndicatorEnum?>(
      segments: indicatorButtonSegments,
      emptySelectionAllowed: true,
      multiSelectionEnabled: false,
      onSelectionChanged: (selection) {
        selectedIndicator.value = selection.first;
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.firstOrNull == MaterialState.selected) {
              return Colors.redAccent;
            } else {
              return Colors.black12;
            }
          },
        ),
      ),
      selected: const {null},
    );
  }
}
