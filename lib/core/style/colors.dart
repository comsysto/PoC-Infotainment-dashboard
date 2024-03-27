import 'package:flutter/material.dart';

const backgroundColorBegin = Color(0xFF393939);
const backgroundColorEnd = Color(0xFF000000);
const textColor = Color(0xFFF5F5F5);
const labelColor = Color(0xFFB1B3BC);
const cardBackground = Color.fromARGB(125, 74, 74, 76);

class AppColors extends ThemeExtension<AppColors> {
  final Color backgroundBegin;
  final Color backgroundEnd;
  final Color text;
  final Color cardBackground;

  const AppColors({
    required this.backgroundBegin,
    required this.backgroundEnd,
    required this.text,
    required this.cardBackground,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    final Color? backgroundBegin,
    final Color? backgroundEnd,
    final Color? text,
    final Color? cardBackground,
  }) =>
      AppColors(
        backgroundBegin: backgroundBegin ?? this.backgroundBegin,
        backgroundEnd: backgroundEnd ?? this.backgroundEnd,
        text: text ?? this.text,
        cardBackground: cardBackground ?? this.cardBackground,
      );

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      backgroundBegin: Color.lerp(backgroundBegin, other.backgroundBegin, t)!,
      backgroundEnd: Color.lerp(backgroundEnd, other.backgroundEnd, t)!,
      text: Color.lerp(text, other.text, t)!,
      cardBackground: Color.lerp(cardBackground, other.text, t)!,
    );
  }
}
