import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/widget/blinker_controls.dart';

final blinkerControllerProvider = StateNotifierProvider<BlinkerController, BlinkerEnum?>(
  (ref) => BlinkerController(),
);

class BlinkerController extends StateNotifier<BlinkerEnum?> {
  BlinkerController() : super(null);

  void setBlinker(final BlinkerEnum blinker) => state = state == blinker ? null : blinker;
}
