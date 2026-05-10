import 'dart:async';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/prime_logger.dart';

/// [SessionWatchdog] - Monitors user activity and app lifecycle.
/// Enforces biometric re-authentication on resume and auto-logout on idle.
class SessionWatchdog extends WidgetsBindingObserver {
  static final SessionWatchdog instance = SessionWatchdog._internal();
  SessionWatchdog._internal();

  final LocalAuthentication _auth = LocalAuthentication();
  Timer? _idleTimer;
  final int _timeoutSeconds = 300; // 5 minutes bank-standard
  bool _isLocked = false;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    _resetIdleTimer();
  }

  void onUserActivity() {
    _resetIdleTimer();
  }

  void _resetIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(Duration(seconds: _timeoutSeconds), _onIdleTimeout);
  }

  void _onIdleTimeout() {
    PrimeLogger.warning('Session idle timeout reached. Locking app.');
    _isLocked = true;
    // Notify listeners or trigger global lock screen
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isLocked) {
      _requestBiometricUnlock();
    } else if (state == AppLifecycleState.paused) {
      // Immediately mark as locked if sensitive data is visible
      _isLocked = true;
    }
  }

  Future<bool> verifyBiometrics(String reason) async {
    try {
      PrimeLogger.info(
        'Triggering biometric verification for session unlock',
        tag: 'SessionWatchdog',
      );

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Verify identity to unlock clinical session',
        biometricOnly: true,
      );

      if (didAuthenticate) {
        _isLocked = false;
        PrimeLogger.info('Session unlocked successfully', tag: 'SessionWatchdog');
        return true;
      }
      return false;
    } catch (e) {
      PrimeLogger.error(
        'Biometric verification failed',
        tag: 'SessionWatchdog',
        error: e,
      );
      return false;
    }
  }

  Future<bool> _requestBiometricUnlock() async {
    final success = await verifyBiometrics('Please authenticate to resume your session');
    if (success) {
      _isLocked = false;
      _resetIdleTimer();
    }
    return success;
  }
}

/// Provider for SessionWatchdog.
final sessionWatchdogProvider = Provider<SessionWatchdog>((ref) {
  return SessionWatchdog.instance;
});
