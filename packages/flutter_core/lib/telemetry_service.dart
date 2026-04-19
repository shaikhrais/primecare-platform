import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_providers.dart';
import 'package:flutter/foundation.dart';

/// Represents predefined categories for execution gates.
enum ExecutionGateCategory {
  auth,
  navigationLayer,
  metricsLayer,
  auraEngine,
  aura,
  scheduler,
  ui,
  system,
  network,
  resource,
  domainApi,
  adapters,
}

extension ExecutionGateCategoryExtension on ExecutionGateCategory {
  String get displayName {
    switch (this) {
      case ExecutionGateCategory.auth:
        return 'Auth';
      case ExecutionGateCategory.navigationLayer:
        return 'Navigation Layer';
      case ExecutionGateCategory.metricsLayer:
        return 'Metrics Layer';
      case ExecutionGateCategory.auraEngine:
        return 'Aura Engine';
      case ExecutionGateCategory.aura:
        return 'Aura Insight';
      case ExecutionGateCategory.scheduler:
        return 'Scheduler';
      case ExecutionGateCategory.ui:
        return 'UI/UX';
      case ExecutionGateCategory.system:
        return 'System';
      case ExecutionGateCategory.network:
        return 'Network';
      case ExecutionGateCategory.resource:
        return 'Resource';
      case ExecutionGateCategory.domainApi:
        return 'Domain API';
      case ExecutionGateCategory.adapters:
        return 'Data Adapters';
    }
  }
}

enum ExecutionGateStatus { pass, fail }

/// Represents a single execution gate trace point.
class ExecutionGate {
  final DateTime timestamp;
  final ExecutionGateCategory category;
  final String message;
  final ExecutionGateStatus status;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? metadata;

  ExecutionGate({
    required this.timestamp,
    required this.category,
    required this.message,
    this.status = ExecutionGateStatus.pass,
    this.error,
    this.stackTrace,
    this.metadata,
  });

  @override
  String toString() {
    final statusSymbol = status == ExecutionGateStatus.pass ? '✅' : '❌';
    String base =
        '[${timestamp.toIso8601String()}] $statusSymbol [${category.displayName}] $message';
    if (metadata != null) {
      base += '\n    META: $metadata';
    }
    if (error != null) {
      base += '\n    ERROR: $error';
    }
    if (stackTrace != null) {
      base += '\n    STACK: $stackTrace';
    }
    return base;
  }
}

/// A centralized service to trace execution lifecycles and submit crash reports.
class ExecutionGateService {
  final Ref _ref;
  final List<ExecutionGate> _gates = [];

  /// Maximum number of gate entries to retain in memory.
  /// Prevents OOM on long-running sessions (8+ hour nursing shifts).
  static const int _maxGateEntries = 500;

  ExecutionGateService(this._ref);

  List<ExecutionGate> get allGates => List.unmodifiable(_gates);

  void passGate(
    ExecutionGateCategory category,
    String message, {
    Map<String, dynamic>? metadata,
  }) {
    _recordGate(
      ExecutionGate(
        timestamp: DateTime.now(),
        category: category,
        message: message,
        status: ExecutionGateStatus.pass,
        metadata: metadata,
      ),
    );
  }

  void failGate(
    ExecutionGateCategory category,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    final gate = ExecutionGate(
      timestamp: DateTime.now(),
      category: category,
      message: message,
      status: ExecutionGateStatus.fail,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
    _recordGate(gate);

    // Automatically trigger crash report for critical failures in production-like environments
    _submitCrashReport(gate);
  }

  void _recordGate(ExecutionGate gate) {
    _gates.add(gate);

    // Ring buffer: trim oldest entries when capacity exceeded
    if (_gates.length > _maxGateEntries) {
      _gates.removeRange(0, _gates.length - _maxGateEntries);
    }
  }

  /// Generates the raw plaintext audit session report.
  String generateAuditReport() {
    if (_gates.isEmpty) return 'No execution gates recorded in this session.';
    return _gates.map((g) => g.toString()).join('\n');
  }

  void clearGates() {
    _gates.clear();
  }

  /// Throttle guard: max crash reports per window to prevent recursive flooding
  static const int _maxCrashReportsPerWindow = 3;
  static const Duration _crashReportWindow = Duration(seconds: 60);
  final List<DateTime> _crashReportTimestamps = [];
  bool _isSubmittingCrashReport = false;

  /// Submits the current session audit trail as a crash report to the backend.
  /// Throttled to prevent recursive flooding when the API is down.
  Future<void> _submitCrashReport(ExecutionGate failedGate) async {
    // Guard 1: Prevent re-entrant calls
    if (_isSubmittingCrashReport) return;

    // Guard 2: Throttle — max N reports per window
    final now = DateTime.now();
    _crashReportTimestamps.removeWhere(
      (t) => now.difference(t) > _crashReportWindow,
    );
    if (_crashReportTimestamps.length >= _maxCrashReportsPerWindow) return;

    _isSubmittingCrashReport = true;
    _crashReportTimestamps.add(now);

    try {
      final apiClient = _ref.read(apiClientProvider);
      final report = generateAuditReport();

      final payload = {
        'timestamp': DateTime.now().toIso8601String(),
        'failedGate': {
          'category': failedGate.category.name,
          'message': failedGate.message,
          'error': failedGate.error?.toString(),
        },
        'auditTrail': report,
        'platform': kIsWeb ? 'web' : 'native',
        'isCritical': true,
      };

      await apiClient.post('/telemetry/crash-report', body: payload);

      if (kDebugMode) {
        print('PRIMECARE_TELEMETRY: Crash report submitted successfully.');
      }
    } catch (e, stack) {
      // Silently absorb — do NOT call failGate here to prevent infinite recursion
      if (kDebugMode) {
        print('PRIMECARE_TELEMETRY: Failed to submit crash report: $e');
        print(stack);
      }
    } finally {
      _isSubmittingCrashReport = false;
    }
  }

  /// Public method to manually trigger a report submission.
  Future<void> manualSubmit() async {
    if (_gates.isEmpty) return;
    final lastGate = _gates.last;
    await _submitCrashReport(lastGate);
  }
}

/// Global provider for the ExecutionGateService.
final executionGateProvider = Provider<ExecutionGateService>((ref) {
  return ExecutionGateService(ref);
});
