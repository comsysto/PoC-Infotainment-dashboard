import 'package:flutter/material.dart';

const _titleTextStyle = TextStyle(
  fontFamily: 'CorporateABQ',
  fontSize: 32,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

extension CustomTextStyle on TextTheme {
  TextStyle get titleTextStyle => _titleTextStyle;
}
