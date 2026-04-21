// Layer: 01_INFRASTRUCTURE
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Categories for execution gates tracking platform stability.
enum ExecutionGateCategory {
  auth,
  network,
  storage,
  resilience,
  apiGateway,
  clinical,
  institutional,
  intelligence,
  ui,
  navigationLayer,
  scheduler,
  metricsLayer,
  auraEngine,
  domainApi,
  aura,
  compliance,
  interaction,
}

/// Status of an individual execution gate.
enum ExecutionGateStatus { pass, fail }

/// A single record of an execution gate event.
class ExecutionGate {
  final ExecutionGateCategory category;
  final String message;
  final ExecutionGateStatus status;
  final DateTime timestamp;
  final dynamic error;
  final Map<String, dynamic>? metadata;

  ExecutionGate({
    required this.category,
    required this.message,
    required this.status,
    required this.timestamp,
    this.error,
    this.metadata,
  });

  @override
  String toString() =>
      '${timestamp.toIso8601String()} [${status.name.toUpperCase()}] [${category.name}] $message';
}

/// A centralized service for tracking system-wide execution status and gate triggers.
/// Used for telemetry, debugging, and automated testing validation.
class ExecutionGateService extends ChangeNotifier {
  final List<ExecutionGate> _gates = [];

  /// Returns all gates recorded in the current session.
  List<ExecutionGate> get allGates => List.unmodifiable(_gates);

  /// Records a successful gate passage.
  void passGate(
    ExecutionGateCategory category,
    String message, {
    Map<String, dynamic>? metadata,
  }) {
    _gates.add(
      ExecutionGate(
        category: category,
        message: message,
        status: ExecutionGateStatus.pass,
        timestamp: DateTime.now(),
        metadata: metadata,
      ),
    );
    if (kDebugMode) {
      print('[ExecutionGate] PASS [$category]: $message');
    }
    notifyListeners();
  }

  /// Records a failed gate attempt.
  void failGate(
    ExecutionGateCategory category,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _gates.add(
      ExecutionGate(
        category: category,
        message: message,
        status: ExecutionGateStatus.fail,
        timestamp: DateTime.now(),
        error: error,
        metadata: metadata,
      ),
    );
    if (kDebugMode) {
      print('[ExecutionGate] FAIL [$category]: $message | Error: $error');
    }
    notifyListeners();
  }

  /// Clears the gate history.
  void clearGates() {
    _gates.clear();
    notifyListeners();
  }

  /// Resets the gate history (alias for clearGates).
  void reset() => clearGates();

  /// Generates a human-readable audit report of all current gates.
  String generateAuditReport() {
    if (_gates.isEmpty) return 'No execution gates recorded.';
    final buffer = StringBuffer();
    buffer.writeln('=== PrimeCare Session Audit Report ===');
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Total Gates: ${_gates.length}');
    buffer.writeln('---------------------------------------');
    for (final gate in _gates) {
      buffer.writeln(gate.toString());
      if (gate.error != null) buffer.writeln('  ERROR: ${gate.error}');
      if (gate.metadata != null) buffer.writeln('  META: ${gate.metadata}');
    }
    return buffer.toString();
  }

  /// Placeholder for manual submission logic to a cloud telemetry sink.
  Future<void> manualSubmit() async {
    // In a real implementation, this would POST to a telemetry endpoint.
    await Future<void>.delayed(const Duration(seconds: 1));
    if (kDebugMode) {
      print('Manual audit report submitted successfully.');
    }
  }
}

/// Global provider for the ExecutionGateService.
/// Using ChangeNotifierProvider to support legacy ref.read(executionGateProvider).method() access patterns.
final executionGateProvider = ChangeNotifierProvider<ExecutionGateService>((
  ref,
) {
  return ExecutionGateService();
});
