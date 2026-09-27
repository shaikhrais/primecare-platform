// Governance - Category: service | Purpose: Core implementation file for the Logger platform logic.
import 'package:flutter/foundation.dart';

class AppLogger {
  static void d(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] ${DateTime.now()}: $message');
    }
  }

  static void e(String message, [dynamic error, StackTrace? stack]) {
    debugPrint('[ERROR] ${DateTime.now()}: $message');
    if (error != null) debugPrint('Error: $error');
    if (stack != null) debugPrint('Stack: $stack');
  }

  static void i(String message) {
    debugPrint('[INFO] ${DateTime.now()}: $message');
  }
}
