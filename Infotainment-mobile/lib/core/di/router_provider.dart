import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infotainment_mobile_app/common/presentation/screen/home_screen.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/screen/basic_controls_screen.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/screen/chat_screen.dart';
import 'package:infotainment_mobile_app/features/settings/presentation/screen/settings_screen.dart';

enum AppRoutePath {
  home(name: 'home', path: '/'),
  basicControls(name: 'basic_controls', path: 'basic_controls'),
  settings(name: 'settings', path: 'settings'),
  chat(name: 'chat', path: 'chat');

  const AppRoutePath({required this.name, required this.path});

  final String name;
  final String path;
}

final _globalNavigationKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'root'),
);

final routerProvider = Provider<GoRouter>(
  (ref) {
    final rootKey = ref.watch(_globalNavigationKeyProvider);
    return GoRouter(
      initialLocation: AppRoutePath.home.path,
      navigatorKey: rootKey,
      routes: [
        GoRoute(
          name: AppRoutePath.home.name,
          path: AppRoutePath.home.path,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              name: AppRoutePath.basicControls.name,
              path: AppRoutePath.basicControls.path,
              builder: (context, state) => const BasicControlsScreen(),
            ),
            GoRoute(
              name: AppRoutePath.chat.name,
              path: AppRoutePath.chat.path,
              builder: (context, state) => const ChatScreen(),
            ),
            GoRoute(
              name: AppRoutePath.settings.name,
              path: AppRoutePath.settings.path,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    );
  },
);
