import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

final blinkerController =
    StateNotifierProvider<BlinkerController, BlinkerEnum?>((ref) => BlinkerController());

class BlinkerController extends StateNotifier<BlinkerEnum?> {
  BlinkerController() : super(null);

  void setBlinker(BlinkerEnum blinker) {
    if (state == blinker) {
      state = null;
      return;
    }
    state = blinker;
  }
}
