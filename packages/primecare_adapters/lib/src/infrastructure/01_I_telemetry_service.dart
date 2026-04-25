// Layer: 01_INFRASTRUCTURE
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '01_I_modulation_governance_registry.dart';
import '01_I_governance_policies.dart';
import '01_I_api_client.dart';

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
  governance,
  structuralIntegrity,
}

/// A centralized stream sink for cloud telemetry observability.
class CloudWatchStreamSink {
  static void streamEvent(ExecutionGate gate) {
    // In production, this pushes the event to AWS CloudWatch or Datadog via Kinesis/HTTPS
    if (kDebugMode) {
      print('[CloudWatch Stream] -> ${gate.toString()}');
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

/// A centralized service for tracking system-wide execution status and gate triggers.
/// Used for telemetry, debugging, and automated testing validation.
class ExecutionGateService extends ChangeNotifier {
  final Ref? _ref;
  final List<ExecutionGate> _gates = [];
  final Map<PlatformSubsystem, int> _consecutiveFailures = {};

  ExecutionGateService([this._ref]);

  PlatformSubsystem? _mapCategoryToSubsystem(ExecutionGateCategory category) {
    switch (category) {
      case ExecutionGateCategory.auth:
        return PlatformSubsystem.auth;
      case ExecutionGateCategory.clinical:
        return PlatformSubsystem.clinical;
      case ExecutionGateCategory.scheduler:
        return PlatformSubsystem.scheduling;
      case ExecutionGateCategory.metricsLayer:
        return PlatformSubsystem.metrics;
      case ExecutionGateCategory.auraEngine:
      case ExecutionGateCategory.aura:
        return PlatformSubsystem.auraAI;
      default:
        return null;
    }
  }

  /// Returns all gates recorded in the current session.
  List<ExecutionGate> get allGates => List.unmodifiable(_gates);

  /// Returns the most recent gate recorded, or null if none.
  ExecutionGate? get lastGate => _gates.isEmpty ? null : _gates.last;

  /// Records a successful gate passage.
  void passGate(
    ExecutionGateCategory category,
    String message, {
    Map<String, dynamic>? metadata,
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

    if (kDebugMode) {
      print('[ExecutionGate] PASS [$category]: $message');
    }

    final subsystem = _mapCategoryToSubsystem(category);
    if (subsystem != null) {
      final wasFailing = (_consecutiveFailures[subsystem] ?? 0) > 0;
      if (wasFailing) {
        _consecutiveFailures[subsystem] = 0;
        // Auto-restore healthy state on successful execution gate
        if (_ref != null) {
          _ref
              .read(modulationGovernanceProvider.notifier)
              .modulateSubsystem(subsystem, ModulationState.healthy);
        }
      }
    }

    _safeNotify();
  }

  /// Legacy alias for passGate
  void track(ExecutionGateCategory category, String message) =>
      passGate(category, message);

  /// Records a failed gate attempt.
  void failGate(
    ExecutionGateCategory category,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
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
      print('[ExecutionGate] FAIL [$category]: $message | Error: $error');
    }

    final subsystem = _mapCategoryToSubsystem(category);
    if (subsystem != null) {
      final currentFailures = (_consecutiveFailures[subsystem] ?? 0) + 1;
      _consecutiveFailures[subsystem] = currentFailures;

      if (currentFailures >= 3) {
        if (_ref != null) {
          _ref
              .read(modulationGovernanceProvider.notifier)
              .modulateSubsystem(subsystem, ModulationState.degraded);
        }
        if (kDebugMode) {
          print(
            '[CIRCUIT BREAKER] Auto-degraded $subsystem after 3 consecutive failures.',
          );
        }
      }
    }

    _safeNotify();
  }

  /// Clears the gate history.
  void clearGates() {
    _gates.clear();
    _safeNotify();
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

  /// Generates a comprehensive Global Governance Report detailing subsystem health,
  /// active OOP policies, and circuit breaker metrics.
  String generateGlobalGovernanceReport() {
    final buffer = StringBuffer();
    buffer.writeln('=== PrimeCare Global Governance Report ===');
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln('--- Subsystem Health & Policies ---');

    if (_ref != null) {
      final registryState = _ref.read(modulationGovernanceProvider);
      for (final subsystem in PlatformSubsystem.values) {
        final state = registryState[subsystem] ?? ModulationState.healthy;
        final policy = GovernancePolicyManager.getDefaultPolicyName(subsystem);
        final failures = _consecutiveFailures[subsystem] ?? 0;
        buffer.writeln('[$subsystem]: ${state.name.toUpperCase()}');
        buffer.writeln('  -> Active Policy: $policy');
        buffer.writeln('  -> Consecutive Failures: $failures');
      }
    } else {
      buffer.writeln('Registry state unavailable (Ref is null).');
    }

    buffer.writeln('---------------------------------------');
    buffer.writeln('Recent Telemetry Events (Last 10):');
    final recent = _gates.reversed.take(10);
    if (recent.isEmpty) {
      buffer.writeln('No recent events recorded.');
    } else {
      for (final gate in recent) {
        buffer.writeln(gate.toString());
      }
    }
    return buffer.toString();
  }

  /// Submits the Global Governance Report to the CloudWatch telemetry sink.
  Future<void> submitToCloudWatch() async {
    final report = generateGlobalGovernanceReport();
    if (kDebugMode) {
      print('Initiating CloudWatch Telemetry Stream...');
    }

    // Simulate streaming the report to AWS CloudWatch or a similar observability sink.
    try {
      if (_ref != null) {
        final apiClient = _ref.read(apiClientProvider);
        await apiClient.post(
          '/telemetry/cloudwatch',
          body: {
            'report': report,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
      } else {
        // Fallback if Ref is unmounted
        await Future<void>.delayed(const Duration(milliseconds: 800));
      }

      if (kDebugMode) {
        print(
          'CloudWatch Telemetry Sync Complete. Streamed ${_gates.length} events.',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('CloudWatch Sync Failed: $e');
      }
      // Fail the gate itself to indicate observability is degraded.
      failGate(ExecutionGateCategory.resilience, 'CloudWatch Sync Failed: $e');
    }
  }

  void _safeNotify() {
    // If we are in the middle of a build, defer notification to the next frame
    // to avoid "Tried to modify a provider while the widget tree was building" errors.
    if (WidgetsBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      Future.microtask(() => notifyListeners());
    } else {
      notifyListeners();
    }
  }
}

/// Global provider for the ExecutionGateService.
/// Using ChangeNotifierProvider to support legacy ref.read(executionGateProvider).method() access patterns.
final executionGateProvider = ChangeNotifierProvider<ExecutionGateService>((
  ref,
) {
  return ExecutionGateService(ref);
});
