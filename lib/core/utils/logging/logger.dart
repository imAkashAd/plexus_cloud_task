import 'package:flutter/foundation.dart';

class AppLoggerHelper {
  AppLoggerHelper._();

  static void debug(String message) {
    debugPrint('[DEBUG] $message');
  }

  static void info(String message) {
    debugPrint('[INFO] $message');
  }

  static void warning(String message) {
    debugPrint('[WARNING] $message');
  }

  static void error(String message, [dynamic error]) {
    debugPrint('[ERROR] $message: $error');
  }
}