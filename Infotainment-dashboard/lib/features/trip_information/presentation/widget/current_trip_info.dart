import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment/core/di.dart';
import 'package:infotainment/core/style/style_extensions.dart';
import 'package:infotainment/core/style/text_styles.dart';
import 'package:intl/intl.dart';

class CurrentTripInfo extends HookConsumerWidget {
  const CurrentTripInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripDuration = useState(DateTime(0, 0, 0, 0, 0, 0, 0, 0));
    final telemetryData = ref.watch(telemetryProvider).valueOrNull;

    useEffect(() {
      final timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (telemetryData == null || telemetryData.speed < 1) return;
          tripDuration.value = tripDuration.value.add(const Duration(seconds: 1));
        },
      );
      return timer.cancel;
    }, [telemetryData, tripDuration]);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Current trip', style: context.textStyle.cardTitle)),
          const _TripComputerRow('9.2l/100km', 'Fuel economy'),
          _TripComputerRow(
            DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(tripDuration.value),
            'Duration',
          ),tre
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
