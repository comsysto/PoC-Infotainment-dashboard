import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/di.dart';
import 'package:infotainment/core/style/theme.dart';
import 'package:infotainment/features/common/presentation/screen/main_tacho_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  
  ipAddress = await rootBundle.loadString('assets/connection.txt');
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainTachoScreen(),
    );
  }
}
