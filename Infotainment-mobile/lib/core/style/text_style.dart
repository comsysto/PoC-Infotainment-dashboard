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
  TextStyle get profileTitleTextStyle => _profileTitleTextStyle;
  TextStyle get optionCardTitleTextStyle => _optionCardTitleTextStyle;
  TextStyle get optionCardDescriptionTextStyle => _optionCardDescriptionTextStyle;
}
