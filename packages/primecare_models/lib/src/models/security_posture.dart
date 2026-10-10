import 'mfa_contracts.dart';
import 'app_integrity_status.dart';

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
