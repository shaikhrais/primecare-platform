// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../../config/resilience_config.dart';

/// Mechanical problem solver that attempts to clear application errors
/// by resetting state in a loop before giving up.
///
/// This implements the "Self-Healing Loop" requested to minimize downtime.
class SystemRecoveryManager {
  static int _healCount = 0;
  static DateTime? _lastHealAttempt;

  /// Returns true if an auto-heal attempt was initiated.
  /// Returns false if max attempts reached or velocity too high.
  static bool attemptAutoHeal(VoidCallback? onReset) {
    if (!ResilienceConfig.enableAutoHealing) return false;

    final now = DateTime.now();

    // Safety Valve: If we are crashing more than once every 5 seconds,
    // it's a structural logic bug, not a state glitch. Stop the loop.
    if (_lastHealAttempt != null) {
      final diff = now.difference(_lastHealAttempt!);
      if (diff.inSeconds < 5) {
        debugPrint(
          'PRIMECARE_HEALER: Crash velocity too high. Stopping mechanical loop.',
        );
        return false;
      }
    }

    if (_healCount < ResilienceConfig.maxAutoResets) {
      _healCount++;
      _lastHealAttempt = now;

      debugPrint(
        'PRIMECARE_HEALER: 🛠️ Mechanical fix attempt #$_healCount initiated...',
      );

      // We use a small delay to allow the stack to clear before triggering reset
      Future.delayed(const Duration(milliseconds: 500), () {
        if (onReset != null) {
          onReset();
        }
      });

      return true;
    }

    debugPrint(
      'PRIMECARE_HEALER: ⚠️ Max mechanical attempts reached. Requiring agent intervention.',
    );
    return false;
  }

  /// Call this when the app reaches a stable state (e.g. Dashboard loaded).
  /// This resets the counter so the next random crash can be auto-healed.
  static void markStable() {
    if (_healCount > 0) {
      debugPrint(
        'PRIMECARE_HEALER: ✅ System stable. Resetting mechanical fix counter.',
      );
      _healCount = 0;
      _lastHealAttempt = null;
    }
  }

  /// Current count of sequential crashes.
  static int get healCount => _healCount;
}
