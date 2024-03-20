import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CustomLogger {
  static final CustomLogger _instance = CustomLogger._privateConstructor();

  static CustomLogger get instance => _instance;

  CustomLogger._privateConstructor();

  late Directory directory;
  late File logFile;

  Future<void> init() async {
    directory = await getApplicationDocumentsDirectory();
    logFile = File(
      '${directory.path}/${_generateFileNameForToday()}-logs.txt',
    );
  }

  void debug(String logToWrite) {
    logFile.writeAsStringSync('\n[${DateTime.now()}] - DEBUG: $logToWrite', mode: FileMode.append);
  }

  void info(String logToWrite) {
    logFile.writeAsStringSync('[${DateTime.now()}] - INFO: $logToWrite', mode: FileMode.append);
  }

  void error(String logToWrite) {
    logFile.writeAsStringSync('[${DateTime.now()}] - ERROR: $logToWrite', mode: FileMode.append);
  }

  String _generateFileNameForToday() => '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
}
