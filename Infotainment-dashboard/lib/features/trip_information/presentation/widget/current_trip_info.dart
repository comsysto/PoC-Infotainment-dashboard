import 'package:flutter/material.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';

class CurrentTripInfo extends StatelessWidget {
  const CurrentTripInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: double.maxFinite,
      margin: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Current trip', style: context.textStyle.cardTitle)),
          const _TripComputerRow('9.2l/100km', 'Fuel economy'),
          const _TripComputerRow('0:21:55', 'Duration'),
          const _TripComputerRow('378km', 'Distance', isLast: true),
        ],
      ),
    );
  }
}

class _TripComputerRow extends StatelessWidget {
  final String value;
  final String label;
  final bool isLast;

  const _TripComputerRow(this.value, this.label, {this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Text(value, style: context.textStyle.tripInfoValue),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(label, style: context.textStyle.tripInfoLabel),
          ),
          if (!isLast) const SizedBox(height: 15),
          if (!isLast) const Divider(),
        ],
      ),
    );
  }
}
