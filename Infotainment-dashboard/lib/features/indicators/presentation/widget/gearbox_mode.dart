import 'package:flutter/material.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';

class GearboxMode extends StatelessWidget {
  const GearboxMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('P', style: context.textStyle.gearSelectorInactive),
            const SizedBox(width: 30),
            Text('R', style: context.textStyle.gearSelectorInactive),
            const SizedBox(width: 30),
            Text('N', style: context.textStyle.gearSelectorInactive),
            const SizedBox(width: 30),
            Text('D', style: context.textStyle.gearSelectorActive),
            const SizedBox(width: 30),
            Text('S', style: context.textStyle.gearSelectorInactive),
          ],
        ),
      ),
    );
  }
}
