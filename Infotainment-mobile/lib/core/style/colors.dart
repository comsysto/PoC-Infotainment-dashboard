//Light pallete
import 'package:flutter/material.dart';

const gradientBeginColorLight = Color(0xFF393939);
const gradientEndColorLight = Color(0xFF000000);
const primaryColorLight = Color(0xFF0078D6);
const successColorLight = Color(0xFF00DC16);
const errorColorLight = Color(0xFF8B181B);
const shadowColorLight = Color(0x26000000);
const personalBubbleColorLight = Color(0xFFF5F5F5);
const mechanicBubbleColorLight = primaryColorLight;
const formAnswerColorLight = Color(0xFF595959);

//Dark pallete
const gradientBeginColorDark = Color(0xFF393939);
const gradientEndColorDark = Color(0xFF000000);
const primaryColorDark = Color(0xFF0078D6);
const successColorDark = Color(0xFF00DC16);
const errorColorDark = Color(0xFF8B181B);
const shadowColorDark = Color(0x26000000);
const personalBubbleColorDark = Color(0xFFF5F5F5);
const mechanicBuubleColorDark = primaryColorDark;
const formAnswerColorDark = Color(0xFF595959);

class AppColors extends ThemeExtension<AppColors> {
  final Color? gradientBeginColor;
  final Color? gradientEndColor;
  final Color? primaryColor;
  final Color? successColor;
  final Color? errorColor;
  final Color? shadowColor;
  final Color? personalBubbleColor;
  final Color? mechanicBubbleColor;
  final Color? formAnswerColor;

  const AppColors({
    required this.gradientBeginColor,
    required this.gradientEndColor,
    required this.primaryColor,
    required this.successColor,
    required this.errorColor,
    required this.shadowColor,
    required this.personalBubbleColor,
    required this.mechanicBubbleColor,
    required this.formAnswerColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    final Color? gradientBeginColor,
    final Color? gradientEndColor,
    final Color? primaryColor,
    final Color? successColor,
    final Color? errorColor,
    final Color? shadowColor,
    final Color? personalBubbleColor,
    final Color? mechanicBubbleColor,
    final Color? formAnswerColor,
    final Color? blinkerColor,
  }) =>
      AppColors(
        gradientBeginColor: gradientBeginColor ?? this.gradientBeginColor,
        gradientEndColor: gradientEndColor ?? this.gradientEndColor,
        primaryColor: primaryColor ?? this.primaryColor,
        successColor: successColor ?? this.successColor,
        errorColor: errorColor ?? this.errorColor,
        shadowColor: shadowColor ?? this.shadowColor,
        personalBubbleColor: personalBubbleColor ?? this.personalBubbleColor,
        mechanicBubbleColor: mechanicBubbleColor ?? this.mechanicBubbleColor,
        formAnswerColor: formAnswerColor ?? this.formAnswerColor,
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
      successColor: Color.lerp(successColor, other.successColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      personalBubbleColor: Color.lerp(personalBubbleColor, other.personalBubbleColor, t),
      mechanicBubbleColor: Color.lerp(mechanicBubbleColor, other.mechanicBubbleColor, t),
      formAnswerColor: Color.lerp(formAnswerColor, other.formAnswerColor, t),
    );
  }
}
