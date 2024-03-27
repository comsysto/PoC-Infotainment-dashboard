import 'package:flutter/material.dart';
import 'package:infotainment/core/style/colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Corporate',
    scaffoldBackgroundColor: backgroundColorBegin,
    extensions: const [
      AppColors(
        backgroundBegin: backgroundColorBegin,
        backgroundEnd: backgroundColorEnd,
        text: textColor,
        cardBackground: cardBackground,
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Corporate',
    scaffoldBackgroundColor: backgroundColorBegin,
    extensions: const [
      AppColors(
        backgroundBegin: backgroundColorBegin,
        backgroundEnd: backgroundColorEnd,
        text: textColor,
        cardBackground: cardBackground,
      ),
    ],
  );
}
