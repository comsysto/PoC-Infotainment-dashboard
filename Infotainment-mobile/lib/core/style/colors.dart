//Light pallete
import 'package:flutter/material.dart';

const gradientBeginColorLight = Color(0xFF393939);
const gradientEndColorLight = Color(0xFF000000);
const primaryColorLight = Color(0xFF0078D6);
const errorColorLight = Color(0xFF8B181B);
const shadowColorLight = Color(0x26000000);

//Dark pallete
const gradientBeginColorDark = Color(0xFF393939);
const gradientEndColorDark = Color(0xFF000000);
const primaryColorDark = Color(0xFF0078D6);
const errorColorDark = Color(0xFF8B181B);
const shadowColorDark = Color(0x26000000);

class AppColors extends ThemeExtension<AppColors> {
  final Color? gradientBeginColor;
  final Color? gradientEndColor;
  final Color? primaryColor;
  final Color? errorColor;
  final Color? shadowColor;

  const AppColors({
    required this.gradientBeginColor,
    required this.gradientEndColor,
    required this.primaryColor,
    required this.errorColor,
    required this.shadowColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    final Color? gradientBeginColor,
    final Color? gradientEndColor,
    final Color? primaryColor,
    final Color? errorColor,
    final Color? shadowColor,
  }) =>
      AppColors(
        gradientBeginColor: gradientBeginColor ?? this.gradientBeginColor,
        gradientEndColor: gradientEndColor ?? this.gradientEndColor,
        primaryColor: primaryColor ?? this.primaryColor,
        errorColor: errorColor ?? this.errorColor,
        shadowColor: shadowColor ?? this.shadowColor,
      );

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      gradientBeginColor: Color.lerp(gradientBeginColor, other.gradientBeginColor, t),
      gradientEndColor: Color.lerp(gradientEndColor, other.gradientEndColor, t),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
    );
  }
}