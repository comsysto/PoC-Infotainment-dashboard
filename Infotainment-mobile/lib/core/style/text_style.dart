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

extension CustomTextStyle on TextTheme {
  TextStyle get titleTextStyle => _titleTextStyle;
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
  TextStyle get bodyTextStyle => _bodyTextStyle;
}
