import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/screen/basic_controls_screen.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/screen/chat_screen.dart';
import 'package:infotainment_mobile_app/features/settings/presentation/screen/settings_screen.dart';

class HomeScreen extends HookConsumerWidget {
  final _options = const [BasicControlsScreen(), ChatScreen(), SettingsScreen()];
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _options[selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (index) => selectedIndex.value = index,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: context.colorGradientEnd,
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        destinations: const [
          _AppNavigationDestination(
            assetName: 'assets/icons/controls.svg',
            label: 'Home',
          ),
          _AppNavigationDestination(
            assetName: 'assets/icons/chat.svg',
            label: 'Chat',
          ),
          _AppNavigationDestination(
            assetName: 'assets/icons/settings.svg',
            label: 'Home',
          ),
        ],
      ),
    );
  }
}

class _AppNavigationDestination extends HookWidget {
  final String assetName;
  final String label;

  const _AppNavigationDestination({
    required this.assetName,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(
          context.colorGradientBegin,
          BlendMode.srcIn,
        ),
      ),
      label: label,
      selectedIcon: SvgPicture.asset(
        assetName,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
