import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: gradientBeginColorLight,
    shadowColor: shadowColorLight,
    extensions: const [
      AppColors(
        gradientBeginColor: gradientBeginColorLight,
        gradientEndColor: gradientEndColorLight,
        primaryColor: primaryColorLight,
        errorColor: errorColorLight,
        shadowColor: shadowColorLight,
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: gradientBeginColorDark,
    shadowColor: shadowColorDark,
    extensions: const [
      AppColors(
        gradientBeginColor: gradientBeginColorDark,
        gradientEndColor: gradientEndColorDark,
        primaryColor: primaryColorDark,
        errorColor: errorColorDark,
        shadowColor: shadowColorDark,
      ),
    ],
  );
}
