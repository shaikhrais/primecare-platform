import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import '../security/device_fingerprint.dart';

/// [DeviceManager] - Manages unique device identity and tracking for the PrimeCare platform.
class DeviceManager {
  static final DeviceManager instance = DeviceManager._internal();
  DeviceManager._internal();

  static const String _deviceIdKey = 'primecare_device_uuid';
  String? _cachedDeviceId;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Returns the unique device ID, generating one if it doesn't exist.
  String get deviceId {
    if (_cachedDeviceId != null) return _cachedDeviceId!;
    return 'PLATFORM_MOBILE_UNSPECIFIED'; // Fallback until initialized
  }

  /// Initializes the device identity. Should be called at app startup.
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(_deviceIdKey);

    if (id == null) {
      id = _generateUuid();
      await prefs.setString(_deviceIdKey, id);
    }

    _cachedDeviceId = id;
  }

  /// Captures a multi-dimensional fingerprint of the current device.
  Future<DeviceFingerprint> getFingerprint() async {
    String model = 'Unknown';
    String osVersion = 'Unknown';
    String? manufacturer;
    bool isPhysical = true;

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      model = androidInfo.model;
      osVersion = 'Android ${androidInfo.version.release}';
      manufacturer = androidInfo.manufacturer;
      isPhysical = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
      osVersion = 'iOS ${iosInfo.systemVersion}';
      manufacturer = 'Apple';
      isPhysical = iosInfo.isPhysicalDevice;
    }

    return DeviceFingerprint(
      uuid: deviceId,
      model: model,
      osVersion: osVersion,
      manufacturer: manufacturer,
      isPhysical: isPhysical,
    );
  }

  String _generateUuid() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (1000 + (DateTime.now().microsecond % 9000));
    return 'PC-${Platform.operatingSystem}-$timestamp-$random';
  }
}
