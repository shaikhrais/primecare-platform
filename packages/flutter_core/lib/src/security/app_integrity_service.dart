// Governance - Category: service | Purpose: Defines the integrity status of the application environment.
import 'package:flutter/foundation.dart';
import 'package:safe_device/safe_device.dart';
import 'dart:io';
import '../utils/prime_logger.dart';
import 'security_sentinel_service.dart';

/// Defines the integrity status of the application environment.
class AppIntegrityStatus {
  final bool isRooted;
  final bool isJailbroken;
  final bool isEmulator;
  final bool isDevelopmentMode;
  final bool isTampered;

  const AppIntegrityStatus({
    required this.isRooted,
    required this.isJailbroken,
    required this.isEmulator,
    required this.isDevelopmentMode,
    this.isTampered = false,
  });

  bool get isSecure => !isRooted && !isJailbroken && !isEmulator && !isTampered;

  @override
  String toString() {
    return 'Integrity(Secure: $isSecure, Rooted: $isRooted, Emulator: $isEmulator)';
  }
}

/// [AppIntegrityService] - Implements bank-grade environment verification.
class AppIntegrityService {
  static final AppIntegrityService instance = AppIntegrityService._internal();
  AppIntegrityService._internal();

  /// Performs a deep sweep of the device environment to detect threats.
  Future<AppIntegrityStatus> checkIntegrity() async {
    try {
      bool isRooted = false;
      bool isJailbroken = false;

      if (!kIsWeb) {
        if (Platform.isAndroid) {
          // safe_device detects both Android root and iOS jailbreak state.
          // Using one native detector avoids duplicate Swift package targets
          // when resolving the iOS dependency graph.
          isRooted = await SafeDevice.isJailBroken;
        } else if (Platform.isIOS) {
          isJailbroken = await SafeDevice.isJailBroken;
        }
      }

      bool isEmulator = false;
      bool isDevMode = false;

      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        isEmulator = await SafeDevice.isRealDevice == false;
        isDevMode = await SafeDevice.isDevelopmentModeEnable;
      }

      final status = AppIntegrityStatus(
        isRooted: isRooted,
        isJailbroken: isJailbroken,
        isEmulator: isEmulator,
        isDevelopmentMode: isDevMode,
      );

      PrimeLogger.info('App Integrity Audit: $status', tag: 'AppIntegrity');
      if (status.isRooted)
        SecuritySentinelService().reportIntegrityFailure('ROOTED');
      if (status.isJailbroken)
        SecuritySentinelService().reportIntegrityFailure('JAILBROKEN');
      if (status.isEmulator)
        SecuritySentinelService().reportMetricViolation(
          'DEVICE_TYPE',
          'Emulator detected in production-like audit',
        );

      return status;
    } catch (e) {
      PrimeLogger.error('Integrity check failed', tag: 'AppIntegrity', error: e);
      // Fail-safe: assume insecure if check fails
      return const AppIntegrityStatus(
        isRooted: true,
        isJailbroken: true,
        isEmulator: true,
        isDevelopmentMode: true,
      );
    }
  }
}
