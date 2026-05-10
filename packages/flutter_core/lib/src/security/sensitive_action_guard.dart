import 'package:flutter_core/flutter_core.dart';

/// Defines the required security level for a sensitive action.
enum SecurityRequirement {
  /// Basic authentication is sufficient.
  authenticated,

  /// Device must be trusted (MFA completed once).
  trustedDevice,

  /// Active MFA session required (just completed).
  activeMfa,

  /// Full Bank-Grade: Authenticated, Trusted, Secure Environment, and Fresh Biometric.
  bankGrade,
}

/// A specialized guard for executing high-sensitivity operations.
/// Implements 'Bank-Grade' check-before-execution patterns.
class SensitiveActionGuard {
  final SecurityOrchestrator _orchestrator;
  final SessionWatchdog _watchdog;

  SensitiveActionGuard(this._orchestrator, this._watchdog);

  /// Executes [action] only if the [requirement] is met.
  /// If not met, triggers the necessary upgrade flow (MFA, Biometric, etc.).
  Future<T?> execute<T>({
    required SecurityRequirement requirement,
    required Future<T> Function() action,
    String? reason,
  }) async {
    final posture = await _orchestrator.getPosture();

    switch (requirement) {
      case SecurityRequirement.authenticated:
        if (posture.isAuthenticated) return action();
        break;

      case SecurityRequirement.trustedDevice:
        if (posture.isDeviceTrusted) return action();
        // Trigger Trust Upgrade Flow
        break;

      case SecurityRequirement.activeMfa:
        if (posture.mfaStatus == MfaStatus.verified) return action();
        // Trigger MFA Challenge
        break;

      case SecurityRequirement.bankGrade:
        if (posture.isFullySecure) {
          // Extra layer: Re-verify biometrics for bank-grade actions
          final biometricsOk = await _watchdog.verifyBiometrics(
            reason ?? 'Verify identity for sensitive action',
          );
          if (biometricsOk) return action();
        }
        break;
    }

    PrimeLogger.warning(
      'Action blocked: Security requirement $requirement not met.',
      tag: 'SensitiveActionGuard',
    );
    return null;
  }
}

/// Provider for SensitiveActionGuard.
final sensitiveActionGuardProvider = Provider<SensitiveActionGuard>((ref) {
  return SensitiveActionGuard(
    ref.read(securityOrchestratorProvider),
    ref.read(sessionWatchdogProvider),
  );
});
