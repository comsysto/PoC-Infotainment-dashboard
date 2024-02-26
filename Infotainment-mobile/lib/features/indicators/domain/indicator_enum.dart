enum IndicatorEnum {
  left(icon: 'assets/icons/left-blinker.png'),
  hazard(icon: 'assets/icons/hazard-lights.png'),
  right(icon: 'assets/icons/right-blinker.png');

  const IndicatorEnum({required this.icon});

  final String icon;
}
