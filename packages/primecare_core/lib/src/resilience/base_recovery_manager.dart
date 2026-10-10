// Governance - Category: service | Purpose: Mechanical problem solver that attempts to clear application errors by resetting state in a loop before giving up. Th...
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_models/primecare_models.dart' show ResilienceConfig;

/// Mechanical problem solver that attempts to clear application errors
/// by resetting state in a loop before giving up.
///
/// This implements the "Self-Healing Loop" requested to minimize downtime.
abstract class BaseRecoveryManager {
  final DateTime Function() _clock;
  BaseRecoveryManager({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  void log(String message);
  int _healCount = 0;
  DateTime? _lastHealAttempt;

  /// Returns true if an auto-heal attempt was initiated.
  /// Returns false if max attempts reached or velocity too high.
  bool attemptAutoHeal(void Function()? onReset) {
    if (!ResilienceConfig.enableAutoHealing) return false;

    final now = _clock();

    // Safety Valve: If we are crashing more than once every 5 seconds,
    // it's a structural logic bug, not a state glitch. Stop the loop.
    if (_lastHealAttempt != null) {
      final diff = now.difference(_lastHealAttempt!);
      if (diff.inSeconds < 5) {
        log(
          'PRIMECARE_HEALER: Crash velocity too high. Stopping mechanical loop.',
        );
        return false;
      }
    }

    if (_healCount < ResilienceConfig.maxAutoResets) {
      _healCount++;
      _lastHealAttempt = now;

      log(
        'PRIMECARE_HEALER: ðŸ› ï¸ Mechanical fix attempt #$_healCount initiated...',
      );

      // We use a small delay to allow the stack to clear before triggering reset
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        if (onReset != null) {
          onReset();
        }
      });

      return true;
    }

    log(
      'PRIMECARE_HEALER: âš ï¸ Max mechanical attempts reached. Requiring agent intervention.',
    );
    return false;
  }

  /// Call this when the app reaches a stable state (e.g. Dashboard loaded).
  /// This resets the counter so the next random crash can be auto-healed.
  void markStable() {
    if (_healCount > 0) {
      log(
        'PRIMECARE_HEALER: âœ… System stable. Resetting mechanical fix counter.',
      );
      _healCount = 0;
      _lastHealAttempt = null;
    }
  }

  /// Current count of sequential crashes.
  int get healCount => _healCount;
}
