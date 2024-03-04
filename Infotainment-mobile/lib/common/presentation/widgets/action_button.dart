import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';

class ActionButton extends HookConsumerWidget {
  final VoidCallback onPressed;
  final Widget child;
  const ActionButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: context.colorGradientEnd,
        backgroundColor: context.colorGradientBegin,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
