import 'package:flutter/material.dart';

class VehicleIndicators extends StatelessWidget {
  const VehicleIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/high-beam.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/low-beam.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/fog-light-front.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/fog-light-rear.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/check-engine.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/oil.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/battery.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/engine-coolant.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/brake-warning.png',
          height: 50,
        ),
        Image.asset(
          'assets/icons/doors.png',
          height: 50,
        ),
      ],
    );
  }
}