import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/colors.dart';
import 'package:infotainment_mobile_app/core/style/text_style.dart';

extension StyleExtension on BuildContext {
  Color get colorGradientBegin => Theme.of(this).extension<AppColors>()!.gradientBeginColor!;
  Color get colorGradientEnd => Theme.of(this).extension<AppColors>()!.gradientEndColor!;
  Color get colorPrimary => Theme.of(this).extension<AppColors>()!.primaryColor!;
  Color get colorError => Theme.of(this).extension<AppColors>()!.errorColor!;
  Color get colorShadow => Theme.of(this).extension<AppColors>()!.shadowColor!;

  TextStyle get textTitle => Theme.of(this).textTheme.titleTextStyle;
  TextStyle get textSubtitle => Theme.of(this).textTheme.subtitleTextStyle;
  TextStyle get textBody => Theme.of(this).textTheme.bodyTextStyle;
}
