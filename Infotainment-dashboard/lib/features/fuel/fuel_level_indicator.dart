import 'package:flutter/material.dart';
import 'package:infotainment/core/style/colors.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';

class FuelLevelIndicator extends StatelessWidget {
  const FuelLevelIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fuel: 81%', style: context.textStyle.fuelLevel),
        const SizedBox(height: 5),
        SizedBox(
          width: 350,
          child: LinearProgressIndicator(
            minHeight: 10,
            value: 0.7,
            borderRadius: BorderRadius.circular(20),
            color: textColor,
            backgroundColor: Colors.grey,
          ),
        )
      ],
    );
  }
}
