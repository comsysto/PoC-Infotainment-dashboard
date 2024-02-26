import 'package:flutter/material.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';

class DayWeatherInfo extends StatelessWidget {
  const DayWeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('20°C in Zagreb', style: context.textStyle.standard),
        const SizedBox(width: 30),
        Text('13:24', style: context.textStyle.standard),
      ],
    );
  }
}