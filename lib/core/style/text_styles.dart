import 'package:flutter/material.dart';
import 'package:infotainment/core/style/colors.dart';

const _standard = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w300,
  color: textColor,
);
const _rpm = TextStyle(
  fontSize: 110,
  fontWeight: FontWeight.w300,
  color: textColor,
  height: 1.0,
);
const _tachoLabel = TextStyle(
  fontSize: 42,
  fontWeight: FontWeight.w300,
  color: labelColor,
  height: 1.0,
);
const _speedIndicator = TextStyle(
  fontSize: 180,
  fontWeight: FontWeight.w300,
  color: textColor,
  height: 1.0
);
const _tripInfoValue = TextStyle(
  fontSize: 42,
  fontWeight: FontWeight.w300,
  color: textColor,
  height: 1.0,
);
const _tripInfoLabel = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w300,
  color: labelColor,
  height: 1.0
);
const _cardTitle = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w300,
  color: textColor,
  height: 1.0
);
const _gearSelectorInactive = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.w300,
  color: labelColor,
  height: 1.0
);
const _gearSelectorActive = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.w300,
  color: textColor,
  height: 1.0
);
const _fuelLevel = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w300,
  color: textColor,
  height: 1.0
);

extension CustomTextTheme on TextTheme {
  TextStyle get standard => _standard;
  TextStyle get rpm => _rpm;
  TextStyle get tachoLabel => _tachoLabel;
  TextStyle get speedIndicator => _speedIndicator;
  TextStyle get tripInfoValue => _tripInfoValue;
  TextStyle get tripInfoLabel => _tripInfoLabel;
  TextStyle get cardTitle => _cardTitle;
  TextStyle get gearSelectorInactive => _gearSelectorInactive;
  TextStyle get gearSelectorActive => _gearSelectorActive;
  TextStyle get fuelLevel => _fuelLevel;
}
