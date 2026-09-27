// Governance - Category: service | Purpose: Define the trust levels for a device. Interface for managing trusted devices across the platform. Concrete implementa...
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../security/device_fingerprint.dart';
import '../security/secure_storage_manager.dart';
import '../security/security_sentinel_service.dart';

/// Define the trust levels for a device.
enum TrustLevel { untrusted, temporary, trusted, revoked }

/// Interface for managing trusted devices across the platform.
abstract class ITrustedDeviceService {
  Future<TrustLevel> getTrustLevel();
  Future<DeviceFingerprint> getCurrentFingerprint();
  Future<void> registerCurrentDevice();
  Future<void> revokeTrust();
}

final trustedDeviceServiceProvider = Provider<ITrustedDeviceService>((ref) {
  return TrustedDeviceService();
});

/// Concrete implementation of TrustedDeviceService using hardware-backed storage.
class TrustedDeviceService implements ITrustedDeviceService {
  final SecureStorageManager _storage = SecureStorageManager.instance;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static const String _trustTokenKey = 'pc_trust_token';
  static const String _deviceIdKey = 'pc_device_id';

  @override
  Future<TrustLevel> getTrustLevel() async {
    final token = await _storage.read(_trustTokenKey);
    final storedDeviceId = await _storage.read(_deviceIdKey);

    if (token == null || storedDeviceId == null) {
      return TrustLevel.untrusted;
    }

    // Verify token consistency with current device
    final currentFingerprint = await getCurrentFingerprint();
    if (storedDeviceId != currentFingerprint.uuid) {
      SecuritySentinelService().reportTrustedDeviceViolation(
        currentFingerprint.uuid,
      );
      return TrustLevel.untrusted;
    }

    return TrustLevel.trusted;
  }

  @override
  Future<DeviceFingerprint> getCurrentFingerprint() async {
    String uuid = 'unknown';
    String model = 'unknown';
    String osVersion = 'unknown';
    String? manufacturer;
    bool isPhysical = true;

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      uuid = androidInfo.id; // Unique hardware ID
      model = androidInfo.model;
      osVersion = androidInfo.version.release;
      manufacturer = androidInfo.manufacturer;
      isPhysical = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      uuid = iosInfo.identifierForVendor ?? 'ios-unknown';
      model = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
      manufacturer = 'Apple';
      isPhysical = iosInfo.isPhysicalDevice;
    }

    return DeviceFingerprint(
      uuid: uuid,
      model: model,
      osVersion: osVersion,
      manufacturer: manufacturer,
      isPhysical: isPhysical,
    );
  }

  @override
  Future<void> registerCurrentDevice() async {
    final fingerprint = await getCurrentFingerprint();

    // In a bank app, this would involve a server-side handshake.
    // For now, we simulate by generating a local trust token.
    final trustToken =
        'TRUST-${fingerprint.toHash()}-${DateTime.now().millisecondsSinceEpoch}';

    await _storage.write(_trustTokenKey, trustToken);
    await _storage.write(_deviceIdKey, fingerprint.uuid);

    SecuritySentinelService().reportMetricViolation(
      'DEVICE_BINDING',
      'Device ${fingerprint.uuid} successfully bound',
    );
  }

  @override
  Future<void> revokeTrust() async {
    await _storage.delete(_trustTokenKey);
    await _storage.delete(_deviceIdKey);
    SecuritySentinelService().reportMetricViolation(
      'DEVICE_UNBINDING',
      'Device trust revoked locally',
    );
  }
}
