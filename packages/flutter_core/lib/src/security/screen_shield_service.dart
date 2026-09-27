// Governance - Category: view | Purpose: Service responsible for bank-grade screen protection. Prevents screenshots, screen recording, and secures the app swi...
import 'package:screen_protector/screen_protector.dart';
import 'package:flutter_core/flutter_core.dart';

/// Service responsible for bank-grade screen protection.
/// Prevents screenshots, screen recording, and secures the app switcher preview.
class ScreenShieldService {
  static final ScreenShieldService _instance = ScreenShieldService._internal();
  factory ScreenShieldService() => _instance;
  ScreenShieldService._internal();

  bool _isProtectionActive = false;
  bool get isProtectionActive => _isProtectionActive;

  /// Enables global screen protection.
  /// This will prevent screenshots and screen recording on the device.
  Future<void> enableProtection() async {
    try {
      await ScreenProtector.protectDataLeakageWithBlur();
      await ScreenProtector.preventScreenshotOn();
      _isProtectionActive = true;
      SecuritySentinelService().reportEvent(
        SecurityEvent(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          timestamp: DateTime.now(),
          type: 'SCREEN_SHIELD_ACTIVE',
          description: 'Bank-grade screenshot protection engaged',
          severity: SecurityEventSeverity.info,
        ),
      );
      PrimeLogger.info(
        'Bank-grade screen protection ENABLED',
        tag: 'ScreenShieldService',
      );
    } catch (e) {
      PrimeLogger.error(
        'Failed to enable screen protection',
        tag: 'ScreenShieldService',
        error: e,
      );
    }
  }

  /// Disables global screen protection.
  Future<void> disableProtection() async {
    try {
      await ScreenProtector.preventScreenshotOff();
      await ScreenProtector.protectDataLeakageOff();
      _isProtectionActive = false;
      PrimeLogger.info(
        'Bank-grade screen protection DISABLED',
        tag: 'ScreenShieldService',
      );
    } catch (e) {
      PrimeLogger.error(
        'Failed to disable screen protection',
        tag: 'ScreenShieldService',
        error: e,
      );
    }
  }

  /// Toggles protection based on environment sensitivity.
  Future<void> setProtection(bool active) async {
    if (active) {
      await enableProtection();
    } else {
      await disableProtection();
    }
  }
}
