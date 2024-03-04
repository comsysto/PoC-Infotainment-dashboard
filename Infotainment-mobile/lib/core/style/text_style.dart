import 'package:flutter/material.dart';

const _titleTextStyle = TextStyle(
  fontFamily: 'CorporateABQ',
  fontSize: 32,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

const _subtitleTextStyle = TextStyle(
  fontFamily: 'CorporateABQ',
  fontSize: 24,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

const _bodyTextStyle = TextStyle(
  fontFamily: 'CorporateABQ',
  fontSize: 16,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

const _bubbleTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 14,
  color: Colors.white,
);

const _feedbackTitleTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 16,
);

const _feedbackTextTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 14,
);

const _actionButtonTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 16,
);

const _profileTitleTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const _optionCardTitleTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const _optionCardDescriptionTextStyle = TextStyle(
  fontFamily: 'MBCorpoSTitle',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.white,
  height: 1.0,
);

extension CustomTextStyle on TextTheme {
  TextStyle get titleTextStyle => _titleTextStyle;
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
  TextStyle get bodyTextStyle => _bodyTextStyle;
  TextStyle get bubbleTextStyle => _bubbleTextStyle;
  TextStyle get feedbackTitleTextStyle => _feedbackTitleTextStyle;
  TextStyle get feedbackTextTextStyle => _feedbackTextTextStyle;
  TextStyle get actionButtonTextStyle => _actionButtonTextStyle;
  TextStyle get profileTitleTextStyle => _profileTitleTextStyle;
  TextStyle get optionCardTitleTextStyle => _optionCardTitleTextStyle;
  TextStyle get optionCardDescriptionTextStyle => _optionCardDescriptionTextStyle;
}
