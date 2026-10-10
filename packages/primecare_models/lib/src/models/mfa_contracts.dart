/// Represents different MFA methods.
enum MfaMethod { totp, sms, email, biometric }

/// Status of an MFA challenge.
enum MfaStatus { notStarted, pending, verified, failed, expired }

/// Data object for an MFA Challenge.
class MfaChallenge {
  final String challengeId;
  final MfaMethod method;
  final DateTime expiresAt;
  final String? destination; // e.g. obfuscated email or phone number

  MfaChallenge({
    required this.challengeId,
    required this.method,
    required this.expiresAt,
    this.destination,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

/// Interface for Multi-Factor Authentication.
abstract class IMfaService {
  Future<MfaChallenge> initiateChallenge(MfaMethod method);
  Future<MfaStatus> verifyChallenge(String challengeId, String code);
  Future<bool> authenticateWithBiometrics(String reason);
  Future<bool> canUseBiometrics();
}
