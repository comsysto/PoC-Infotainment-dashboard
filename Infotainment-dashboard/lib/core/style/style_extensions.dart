import 'package:flutter/material.dart';
import 'package:infotainment/core/style/colors.dart';

extension StyleExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  TextTheme get textStyle => Theme.of(this).textTheme;
}