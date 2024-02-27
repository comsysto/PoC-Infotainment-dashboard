import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infotainment_mobile_app/common/presentation/screen/home_screen.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/screen/basic_controls_screen.dart';
import 'package:infotainment_mobile_app/features/chat/presentation/screen/chat_screen.dart';
import 'package:infotainment_mobile_app/features/settings/presentation/screen/settings_screen.dart';

enum AppRoutePath {
  home(name: 'home', path: '/'),
  basicControls(name: 'basic_controls', path: '/basic_controls'),
  settings(name: 'settings', path: '/settings'),
  chat(name: 'chat', path: '/chat');

  const AppRoutePath({required this.name, required this.path});

  final String name;
  final String path;
}

final _globalNavigationKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'root'),
);

final _shellNavigationKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'shell'),
);

final routerProvider = Provider<GoRouter>(
  (ref) {
    final rootKey = ref.watch(_globalNavigationKeyProvider);
    final shellKey = ref.watch(_shellNavigationKeyProvider);
    return GoRouter(
      initialLocation: AppRoutePath.basicControls.path,
      navigatorKey: rootKey,
      routes: [
        ShellRoute(
          navigatorKey: shellKey,
          builder: (context, state, child) => HomeScreen(child: child),
          routes: [
            GoRoute(
              name: AppRoutePath.basicControls.name,
              path: AppRoutePath.basicControls.path,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BasicControlsScreen(),
              ),
            ),
            GoRoute(
              name: AppRoutePath.chat.name,
              path: AppRoutePath.chat.path,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ChatScreen(),
              ),
            ),
            GoRoute(
              name: AppRoutePath.home.name,
              path: AppRoutePath.home.path,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  },
);
