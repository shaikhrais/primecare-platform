import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Categories for execution gates tracking platform stability.
enum ExecutionGateCategory {
  auth,
  network,
  storage,
  resilience,
  clinical,
  ui,
  interaction,
}

/// A centralized stream sink for cloud telemetry observability.
class CloudWatchStreamSink {
  static void streamEvent(ExecutionGate gate) {
    if (kDebugMode && gate.status == ExecutionGateStatus.fail) {
      print('[Telemetry] -> ${gate.toString()}');
    }
  }
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

/// A centralized service for tracking system-wide execution status.
class ExecutionGateService extends ChangeNotifier {
  final Ref? _ref;
  final List<ExecutionGate> _gates = [];

  ExecutionGateService([this._ref]);

  List<ExecutionGate> get allGates => List.unmodifiable(_gates);

  void passGate(
    ExecutionGateCategory category,
    String message, {
    Map<String, dynamic>? metadata,
    bool silent = false,
  }) {
    final gate = ExecutionGate(
      category: category,
      message: message,
      status: ExecutionGateStatus.pass,
      timestamp: DateTime.now(),
      metadata: metadata,
    );

    _gates.add(gate);
    CloudWatchStreamSink.streamEvent(gate);

    if (kDebugMode && !silent) {
      print('[Telemetry] PASS [$category]: $message');
    }

    _safeNotify(silent: silent);
  }

  void track(ExecutionGateCategory category, String message) =>
      passGate(category, message);

  void failGate(
    ExecutionGateCategory category,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
    bool silent = false,
  }) {
    final gate = ExecutionGate(
      category: category,
      message: message,
      status: ExecutionGateStatus.fail,
      timestamp: DateTime.now(),
      error: error,
      metadata: metadata,
    );

    _gates.add(gate);
    CloudWatchStreamSink.streamEvent(gate);

    if (kDebugMode) {
      print('[Telemetry] FAIL [$category]: $message | Error: $error');
    }

    _safeNotify(silent: silent);
  }

  void clearGates() {
    _gates.clear();
    _safeNotify();
  }

  String generateAuditReport() {
    if (_gates.isEmpty) return 'No telemetry recorded.';
    final buffer = StringBuffer();
    buffer.writeln('=== PrimeCare Telemetry Report ===');
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Total Events: ${_gates.length}');
    buffer.writeln('---------------------------------------');
    for (final gate in _gates) {
      buffer.writeln(gate.toString());
    }
    return buffer.toString();
  }

  void _safeNotify({bool silent = false}) {
    if (silent) return;

    Future.microtask(() {
      if (hasListeners) {
        notifyListeners();
      }
    });
  }
}

final executionGateProvider = ChangeNotifierProvider<ExecutionGateService>((
  ref,
) {
  return ExecutionGateService(ref);
});
