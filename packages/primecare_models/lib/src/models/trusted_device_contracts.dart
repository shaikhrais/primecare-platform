import 'device_fingerprint.dart';

/// Define the trust levels for a device.
enum TrustLevel { untrusted, temporary, trusted, revoked }

/// Interface for managing trusted devices across the platform.
abstract class ITrustedDeviceService {
  Future<TrustLevel> getTrustLevel();
  Future<DeviceFingerprint> getCurrentFingerprint();
  Future<void> registerCurrentDevice();
  Future<void> revokeTrust();
}
