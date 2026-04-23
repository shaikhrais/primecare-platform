// Layer: 01_INFRASTRUCTURE
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../config/01_I_resilience_config.dart';
import '01_I_system_recovery_mode.dart';
import '01_I_system_recovery_manager.dart';

/// Production-grade error boundary that captures all unhandled exceptions
/// across three vectors: widget build errors, async errors, and platform errors.
///
/// This prevents the grey screen of death and ensures telemetry is always captured.
class AppErrorBoundary {
  /// Optional callback to reset the application state or reload the platform.
  static VoidCallback? onReset;

  /// Wraps the entire app entrypoint with full error capture.
  ///
  /// Usage in main.dart:
  /// ```dart
  /// void main() {
  ///   AppErrorBoundary.runGuarded(() async {
  ///     WidgetsFlutterBinding.ensureInitialized();
  ///     // other awaits...
  ///     runApp(ProviderScope(child: MyApp()));
  ///   });
  /// }
  /// ```
  static void runGuarded(Future<void> Function() appRunner) async {
    // Vector 1: Widget build/layout/paint errors
    FlutterError.onError = (FlutterErrorDetails details) {
      _reportFlutterError(details);
    };

    // Replace the "Grey Screen of Death" with a branded recovery UI
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Respect the ResilienceConfig toggle
      if (!ResilienceConfig.enableRecoveryModeUI) {
        return ErrorWidget(details.exception);
      }

      // 🛠️ MECHANICAL FIX ATTEMPT
      final didTriggerHeal = SystemRecoveryManager.attemptAutoHeal(onReset);
      if (didTriggerHeal) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SystemHealingPlaceholder(),
        );
      }

      // If auto-healing fails or max attempts reached, show the full diagnostic trail
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: SystemRecoveryMode(
          error: details.exception,
          stackTrace: details.stack,
          onAttemptReset: () {
            if (onReset != null) {
              onReset!();
            }
          },
        ),
      );
    };

    // Vector 2: Platform-level errors (and all unhandled async errors in Flutter 3.3+)
    PlatformDispatcher.instance.onError = (error, stack) {
      _reportPlatformError(error, stack);
      return true; // Prevents app termination
    };

    // Run directly in the root zone to prevent Zone Mismatch assertions
    try {
      await appRunner();
    } catch (error, stackTrace) {
      _reportZoneError(error, stackTrace);
    }
  }

  static void _reportFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint('PRIMECARE_BOUNDARY: Flutter framework error caught');
      debugPrint('  Library: ${details.library}');
      debugPrint('  Context: ${details.context}');
      debugPrint('  Error: ${details.exception}');
    }
    // Note: telemetry submission happens via the ProviderScope's executionGateProvider
    // which may not be available at this level. We log defensively.
    _safeLog('FlutterError', details.exception, details.stack);
  }

  static void _reportPlatformError(Object error, StackTrace stack) {
    if (kDebugMode) {
      debugPrint('PRIMECARE_BOUNDARY: Platform-level error caught');
      debugPrint('  Error: $error');
    }
    _safeLog('PlatformError', error, stack);
  }

  static void _reportZoneError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('PRIMECARE_BOUNDARY: Unhandled async error caught');
      debugPrint('  Error: $error');
      debugPrint('  Stack: $stackTrace');
    }
    _safeLog('ZoneError', error, stackTrace);
  }

  /// Logs errors defensively without depending on any provider.
  /// This ensures we never crash while trying to report a crash.
  static void _safeLog(String vector, Object error, StackTrace? stack) {
    try {
      if (_pendingErrors.length > _maxPendingErrors) {
        _pendingErrors.removeAt(0);
      }
      _pendingErrors.add(
        _BoundaryError(
          vector: vector,
          error: error,
          stackTrace: stack,
          timestamp: DateTime.now(),
        ),
      );
    } catch (_) {
      // Absolute last resort — never crash while logging
    }
  }

  /// Pending errors from boundary catches, available for telemetry drain.
  static final List<_BoundaryError> _pendingErrors = [];
  static const int _maxPendingErrors = 50;

  /// Drains pending boundary errors into the telemetry service.
  /// Call this from a widget that has access to WidgetRef.
  static void drainToTelemetry(ExecutionGateService telemetry) {
    for (final err in _pendingErrors) {
      telemetry.failGate(
        ExecutionGateCategory.resilience,
        'AppBoundary/${err.vector}: ${err.error.runtimeType}',
        error: err.error,
        stackTrace: err.stackTrace,
        metadata: {
          'vector': err.vector,
          'timestamp': err.timestamp.toIso8601String(),
        },
      );
    }
    _pendingErrors.clear();
  }
}

/// A simple, non-crashing placeholder shown during the mechanical fix loop.
class SystemHealingPlaceholder extends StatelessWidget {
  const SystemHealingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
            ),
            const SizedBox(height: 24),
            Text(
              'MECHANICAL FIX IN PROGRESS...',
              style: TextStyle(
                color: Colors.cyanAccent.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Attempting to clear system error #${SystemRecoveryManager.healCount}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoundaryError {
  final String vector;
  final Object error;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  _BoundaryError({
    required this.vector,
    required this.error,
    this.stackTrace,
    required this.timestamp,
  });
}

/// A widget that silently drains boundary errors into telemetry on first build.
/// Place this at the root of your app widget tree (inside ProviderScope).
class BoundaryTelemetryDrain extends ConsumerWidget {
  final Widget child;

  const BoundaryTelemetryDrain({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Drain any errors caught before the provider scope was ready
    final telemetry = ref.read<ExecutionGateService>(executionGateProvider);
    AppErrorBoundary.drainToTelemetry(telemetry);
    return child;
  }
}
