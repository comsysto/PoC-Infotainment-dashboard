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
    if (_fileDoesNotExits()) {
      logFile = File('$directory/${DateTime.now()}-logs.txt');
    }
  }

  void debug(String logToWrite) {
    logFile.writeAsStringSync('[${DateTime.now()}] - DEBUG: $logToWrite', mode: FileMode.append);
  }

  void info(String logToWrite) {
    logFile.writeAsStringSync('[${DateTime.now()}] - INFO: $logToWrite', mode: FileMode.append);
  }

  void error(String logToWrite) {
    logFile.writeAsStringSync('[${DateTime.now()}] - ERROR: $logToWrite', mode: FileMode.append);
  }

  bool _fileDoesNotExits() => !File('$directory/${DateTime.now()}-logs.txt').existsSync();
}
