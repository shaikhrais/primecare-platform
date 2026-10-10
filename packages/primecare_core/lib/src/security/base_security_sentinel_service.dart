import 'dart:async';
import 'package:primecare_models/primecare_models.dart';

/// Shared event dispatch and retention; adapters supply severity logging.
abstract class BaseSecuritySentinelService {
  void logError(String message);
  void logWarning(String message);
  void logInfo(String message);

  final _eventController = StreamController<SecurityEvent>.broadcast();
  Stream<SecurityEvent> get eventStream => _eventController.stream;

  final List<SecurityEvent> _eventLog = [];
  List<SecurityEvent> get eventLog => List.unmodifiable(_eventLog);

  /// Reports a new security event.
  void reportEvent(SecurityEvent event) {
    _eventLog.add(event);
    _eventController.add(event);

    // Log based on severity
    if (event.severity == SecurityEventSeverity.critical) {
      logError('CRITICAL SECURITY EVENT: ${event.description}');
    } else if (event.severity == SecurityEventSeverity.warning) {
      logWarning('Security Warning: ${event.description}');
    } else {
      logInfo('Security Event: ${event.description}');
    }

    // Limit log size to prevent memory leaks
    if (_eventLog.length > 500) {
      _eventLog.removeAt(0);
    }
  }

  /// Convenience method for reporting common events.
  void reportMetricViolation(String metric, String message) {
    reportEvent(
      SecurityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: 'METRIC_VIOLATION',
        description: 'Violation in $metric: $message',
        severity: SecurityEventSeverity.warning,
      ),
    );
  }

  void reportIntegrityFailure(String check) {
    reportEvent(
      SecurityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: 'INTEGRITY_FAILURE',
        description: 'Environment integrity check failed: $check',
        severity: SecurityEventSeverity.critical,
      ),
    );
  }

  /// Reports a failed MFA attempt.
  void reportMfaFailure(String method, String reason) {
    reportEvent(
      SecurityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: 'MFA_FAILURE',
        description: 'MFA failure ($method): $reason',
        severity: SecurityEventSeverity.warning,
      ),
    );
  }

  /// Reports a violation related to trusted devices (e.g. unknown device).
  void reportTrustedDeviceViolation(String deviceId) {
    reportEvent(
      SecurityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: 'TRUSTED_DEVICE_VIOLATION',
        description: 'Access attempt from untrusted device: $deviceId',
        severity: SecurityEventSeverity.warning,
      ),
    );
  }

  /// Reports an unauthorized access attempt to sensitive data.
  void reportUnauthorizedAccess(String resource) {
    reportEvent(
      SecurityEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: 'UNAUTHORIZED_ACCESS',
        description: 'Unauthorized access attempt to: $resource',
        severity: SecurityEventSeverity.critical,
      ),
    );
  }
}
