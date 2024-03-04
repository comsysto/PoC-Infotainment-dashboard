import 'package:flutter/material.dart';
import 'package:infotainment_mobile_app/core/style/colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: gradientEndColorLight,
    shadowColor: shadowColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: gradientEndColorLight,
      elevation: 0,
    ),
    extensions: const [
      AppColors(
        gradientBeginColor: gradientBeginColorLight,
        gradientEndColor: gradientEndColorLight,
        primaryColor: primaryColorLight,
        errorColor: errorColorLight,
        shadowColor: shadowColorLight,
        optionCardBackgroundColor: optionCardBackgroundColorLight,
        optionHighlightColor: optionHighlihtColorLight,
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: gradientBeginColorDark,
    shadowColor: shadowColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: gradientBeginColorLight,
      elevation: 0,
    ),
    extensions: const [
      AppColors(
        gradientBeginColor: gradientBeginColorDark,
        gradientEndColor: gradientEndColorDark,
        primaryColor: primaryColorDark,
        errorColor: errorColorDark,
        shadowColor: shadowColorDark,
        optionCardBackgroundColor: optionCardBackgroundColorDark,
        optionHighlightColor: optionHighlihtColorDark,
      ),
    ],
  );
}
