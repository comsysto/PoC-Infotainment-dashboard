import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/features/tachometer/presentation/controller/blinker_controller.dart';

class KeyboardListenerUtils {
  static void listenForKeyboard(final RawKeyEvent event, final WidgetRef ref) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          ref.read(blinkerController).toggleLeftBlinker();
        case LogicalKeyboardKey.arrowRight:
          ref.read(blinkerController).toggleRightBlinker();
      }
    }
  }
}
