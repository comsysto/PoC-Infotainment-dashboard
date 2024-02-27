import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infotainment_mobile_app/features/basic_car_controls/presentation/screen/basic_controls_screen.dart';

enum AppRoutePath {
  basicControls(name: 'basic_controls', path: '/'),
  chat(name: 'chat', path: '/chat');

  const AppRoutePath({required this.name, required this.path});

  final String name;
  final String path;
}

final _globalNavigationKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(),
);

final routerProvider = Provider<GoRouter>(
  (ref) {
    final key = ref.watch(_globalNavigationKeyProvider);
    return GoRouter(
      initialLocation: AppRoutePath.basicControls.path,
      navigatorKey: key,
      routes: [
        GoRoute(
          name: AppRoutePath.basicControls.name,
          path: AppRoutePath.basicControls.path,
          builder: (context, state) => const BasicControlsScreen(),
        ),
      ],
    );
  },
);
