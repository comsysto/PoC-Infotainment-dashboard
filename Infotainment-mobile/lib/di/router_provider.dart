//todo: izvuci u neki router provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screen/home_screen.dart';

enum AppRoutePath {
  home(name: 'home', path: '/'),
  login(name: 'login', path: '/login'),
  register(name: 'register', path: '/register');

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
      initialLocation: AppRoutePath.home.path,
      navigatorKey: key,
      routes: [
        GoRoute(
          name: AppRoutePath.home.name,
          path: AppRoutePath.home.path,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  },
);
