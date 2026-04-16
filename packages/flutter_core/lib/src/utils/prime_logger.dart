import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// A structured logging utility for PrimeCare and Clinical Intelligence.
class PrimeLogger {
  static void info(String message, {String? tag}) {
    _log('INFO', message, tag: tag);
  }

  static void warning(String message, {String? tag}) {
    _log('WARN', message, tag: tag);
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _log('ERROR', message, error: error, stackTrace: stackTrace, tag: tag);
  }

  /// Specialized logging for Clinical Intelligence operations.
  static void clinical(String message, {String? tag}) {
    _log('CLINICAL', message, tag: tag);
  }

  static void _log(
    String level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    final fullTag = tag != null
        ? 'PrimeCare [$level] ($tag)'
        : 'PrimeCare [$level]';

    if (kDebugMode) {
      dev.log(message, name: fullTag, error: error, stackTrace: stackTrace);
    }

    // In the future, this can be integrated with Sentry or Firebase Crashlytics.
  }
}
