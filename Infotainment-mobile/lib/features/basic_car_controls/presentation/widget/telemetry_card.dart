import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';

enum TelemetryType {
  speed(suffix: 'km/h'),
  rpm;

  const TelemetryType({this.suffix});

  final String? suffix;
}

class TelemetryCard extends HookConsumerWidget {
  final String title;
  final String value;
  final TelemetryType type;
  const TelemetryCard({
    super.key,
    required this.title,
    required this.value,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: context.textSubtitle,
            ),
            const Spacer(),
            Text('$value ${type.suffix ?? ''}', style: context.textSubtitle),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
