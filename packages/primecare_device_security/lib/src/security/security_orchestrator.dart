// Governance - Category: service | Purpose: Represents the current security posture of the application. Bank-grade security check: Must be authenticated, trusted...
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mfa_service.dart';
import 'trusted_device_service.dart';
import 'app_integrity_service.dart';
import 'screen_shield_service.dart';
import 'security_sentinel_service.dart';

/// Represents the current security posture of the application.
class SecurityPosture {
  final bool isAuthenticated;
  final bool isDeviceTrusted;
  final MfaStatus mfaStatus;
  final AppIntegrityStatus integrity;

  SecurityPosture({
    required this.isAuthenticated,
    required this.isDeviceTrusted,
    required this.mfaStatus,
    required this.integrity,
  });

  /// Bank-grade security check: Must be authenticated, trusted, MFA-verified, AND in a secure environment.
  bool get isFullySecure =>
      isAuthenticated &&
      isDeviceTrusted &&
      mfaStatus == MfaStatus.verified &&
      integrity.isSecure;
}

/// [SecurityOrchestrator] - The central authority for security decisions across apps.
/// Implements 'Trusted Device' and 'Multi-Factor' verification logic.
class SecurityOrchestrator {
  final ITrustedDeviceService _deviceService;
  final IMfaService _mfaService;
  final AppIntegrityService _integrityService = AppIntegrityService.instance;
  final ScreenShieldService _shieldService = ScreenShieldService();

  SecurityOrchestrator(this._deviceService, this._mfaService);

  /// Evaluates the security posture for the current context.
  Future<SecurityPosture> getPosture() async {
    final trustLevel = await _deviceService.getTrustLevel();
    final integrity = await _integrityService.checkIntegrity();

    // Bank-grade: Automatically enable screen protection if we are in a potentially sensitive state
    if (!integrity.isEmulator) {
      await _shieldService.enableProtection();
    }

    // In a real app, check AuthState from a provider
    const isAuthenticated = true;

    return SecurityPosture(
      isAuthenticated: isAuthenticated,
      isDeviceTrusted: trustLevel == TrustLevel.trusted,
      mfaStatus: MfaStatus.verified, // Placeholder
      integrity: integrity,
    );
  }

  /// Forces a bank-grade security check for sensitive operations.
  Future<void> enforceBankGradeSecurity() async {
    final posture = await getPosture();
    
    if (!posture.integrity.isSecure) {
      SecuritySentinelService().reportIntegrityFailure('COMPROMISED_ENV');
      throw SecurityViolationException('Application integrity check failed. Device may be rooted or compromised.');
    }

    if (!posture.isDeviceTrusted) {
      SecuritySentinelService().reportTrustedDeviceViolation('UNRECOGNIZED');
      throw SecurityViolationException('This device is not trusted. Please complete device binding first.');
    }

    // Trigger biometric challenge for bank-grade operations
    final mfaSuccess = await _mfaService.authenticateWithBiometrics(
      'Please verify your identity to perform this sensitive action.',
    );

    if (!mfaSuccess) {
      SecuritySentinelService().reportMfaFailure('BIOMETRIC', 'User cancelled or failed step-up');
      throw SecurityViolationException('Biometric verification failed.');
    }
  }
}

class SecurityViolationException implements Exception {
  final String message;
  SecurityViolationException(this.message);
  @override
  String toString() => 'SecurityViolationException: $message';
}

final securityOrchestratorProvider = Provider<SecurityOrchestrator>((ref) {
  return SecurityOrchestrator(
    ref.watch(trustedDeviceServiceProvider),
    ref.watch(mfaServiceProvider),
  );
});
