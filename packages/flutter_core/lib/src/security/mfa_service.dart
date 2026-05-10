import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import '../security/security_sentinel_service.dart';

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

/// Global provider for MFA operations.
final mfaServiceProvider = Provider<IMfaService>((ref) {
  return MfaService();
});

class MfaService implements IMfaService {
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  Future<MfaChallenge> initiateChallenge(MfaMethod method) async {
    return MfaChallenge(
      challengeId: 'CHAL-${DateTime.now().millisecondsSinceEpoch}',
      method: method,
      expiresAt: DateTime.now().add(const Duration(minutes: 5)),
      destination: method == MfaMethod.email ? 'u***r@primecare.ca' : null,
    );
  }

  @override
  Future<MfaStatus> verifyChallenge(String challengeId, String code) async {
    // Basic verification for mock methods
    if (code == '123456') return MfaStatus.verified;

    SecuritySentinelService().reportMfaFailure('CODE', 'Invalid code entered');
    return MfaStatus.failed;
  }

  @override
  Future<bool> canUseBiometrics() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  @override
  Future<bool> authenticateWithBiometrics(String reason) async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'PrimeCare Security',
          ),
          IOSAuthMessages(cancelButton: 'No thanks'),
        ],
      );

      if (didAuthenticate) {
        SecuritySentinelService().reportMetricViolation(
          'MFA_SUCCESS',
          'Biometric authentication successful',
        );
      } else {
        SecuritySentinelService().reportMfaFailure(
          'BIOMETRIC',
          'Authentication canceled or failed',
        );
      }

      return didAuthenticate;
    } catch (e) {
      SecuritySentinelService().reportMfaFailure('BIOMETRIC', 'Error: $e');
      return false;
    }
  }
}
