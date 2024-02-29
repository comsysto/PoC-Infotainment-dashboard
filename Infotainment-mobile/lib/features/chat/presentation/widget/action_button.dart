import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  const ActionButton._({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });

  factory ActionButton.primary({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ActionButton._(
      label: label,
      onPressed: onPressed,
      backgroundColor: context.colorPrimary,
      foregroundColor: Colors.white,
    );
  }

  factory ActionButton.secondary({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ActionButton._(
      label: label,
      onPressed: onPressed,
      backgroundColor: context.colorPersonalBubble,
      foregroundColor: Colors.black,
      borderColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: context.textActionButton,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? context.colorPrimary),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0,
      ),
      child: Text(label),
    );
  }
}

enum ButtonType { primary, secondary }
