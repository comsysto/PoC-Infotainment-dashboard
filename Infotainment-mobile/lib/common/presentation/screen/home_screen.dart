import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infotainment_mobile_app/core/di/router_provider.dart';
import 'package:infotainment_mobile_app/core/style/style_extensions.dart';

class HomeScreen extends HookConsumerWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == AppRoutePath.basicControls.path) {
      return 0;
    }
    if (location == AppRoutePath.chat.path) {
      return 1;
    }
    if (location == AppRoutePath.home.path) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutePath.basicControls.path);
        break;
      case 1:
        context.go(AppRoutePath.chat.path);
        break;
      case 2:
        context.go(AppRoutePath.home.path);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
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
