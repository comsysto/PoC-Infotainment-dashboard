import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onPressed;

  const OptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: context.colorOptionCardBackground,
          borderRadius: BorderRadiusDirectional.circular(5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: context.colorShadow,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textOptionCardTitle),
                Text(
                  description,
                  style: context.textOptionCardDescription.copyWith(
                    color: context.colorOptionHighlight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
