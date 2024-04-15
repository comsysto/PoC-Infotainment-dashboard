import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotainment/core/di.dart';
import 'package:infotainment/core/style/theme.dart';
import 'package:infotainment/core/util/custom_logger.dart';
import 'package:infotainment/features/common/presentation/screen/main_tacho_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  await _loadUtils();
  runApp(const ProviderScope(child: MainApp()));
}

Future<void> _loadUtils() async {
  await CustomLogger.instance.init();
  ipAddress = await rootBundle.loadString('assets/connection_infotainment.txt');
  ipAddressMobile = await rootBundle.loadString('assets/connection_mobile.txt');
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
