import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/colors.dart';
import 'package:infotainment_mobile_app/core/style/text_style.dart';

extension StyleExtension on BuildContext {
  Color get colorGradientBegin => Theme.of(this).extension<AppColors>()!.gradientBeginColor!;
  Color get colorGradientEnd => Theme.of(this).extension<AppColors>()!.gradientEndColor!;
  Color get colorPrimary => Theme.of(this).extension<AppColors>()!.primaryColor!;
  Color get colorSuccess => Theme.of(this).extension<AppColors>()!.successColor!;
  Color get colorError => Theme.of(this).extension<AppColors>()!.errorColor!;
  Color get colorShadow => Theme.of(this).extension<AppColors>()!.shadowColor!;
  Color get colorPersonalBubble => Theme.of(this).extension<AppColors>()!.personalBubbleColor!;
  Color get colorMechanicBubble => Theme.of(this).extension<AppColors>()!.mechanicBubbleColor!;
  Color get colorFormAnswer => Theme.of(this).extension<AppColors>()!.formAnswerColor!;
  Color get colorOptionCardBackground => Theme.of(this).extension<AppColors>()!.optionCardBackgroundColor!;
  Color get colorOptionHighlight => Theme.of(this).extension<AppColors>()!.optionHighlightColor!;

  TextStyle get textTitle => Theme.of(this).textTheme.titleTextStyle;
  TextStyle get textSubtitle => Theme.of(this).textTheme.subtitleTextStyle;
  TextStyle get textBody => Theme.of(this).textTheme.bodyTextStyle;
  TextStyle get textBubble => Theme.of(this).textTheme.bubbleTextStyle;
  TextStyle get textFeedbackTitle => Theme.of(this).textTheme.feedbackTitleTextStyle;
  TextStyle get textFeedbackText => Theme.of(this).textTheme.feedbackTextTextStyle;
  TextStyle get textActionButton => Theme.of(this).textTheme.actionButtonTextStyle;
  TextStyle get textProfileTitle => Theme.of(this).textTheme.profileTitleTextStyle;
  TextStyle get textOptionCardTitle => Theme.of(this).textTheme.optionCardTitleTextStyle;
  TextStyle get textOptionCardDescription => Theme.of(this).textTheme.optionCardDescriptionTextStyle;
}
