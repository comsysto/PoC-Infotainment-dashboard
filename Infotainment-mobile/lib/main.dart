import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment_mobile_app/core/style/theme.dart';

import 'core/di/router_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.demangleStackTrace = (StackTrace stack) => stack;
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mercedes IoT',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
