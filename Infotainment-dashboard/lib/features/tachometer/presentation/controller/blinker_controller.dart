import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blinkerController = ChangeNotifierProvider<BlinkerController>((ref) => BlinkerController());

class BlinkerController extends ChangeNotifier {
  bool isLeftOn = false;
  bool isRightOn = false;

  void toggleLeftBlinker() {
    isLeftOn = !isLeftOn;
    notifyListeners();
  }

  void toggleRightBlinker() {
    isRightOn = !isRightOn;
    notifyListeners();
  }
}