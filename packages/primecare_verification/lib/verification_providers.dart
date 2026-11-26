// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';

/// Host composition supplies its existing authenticated service constructor.
Provider<S> createVerificationServiceProvider<S, C>(
  C Function(Ref ref) watchClient,
  S Function(C client, ExecutionGateService telemetry) create,
) => Provider<S>((ref) {
  final apiClient = watchClient(ref);
  final telemetry = ref.watch<ExecutionGateService>(executionGateProvider);
  return create(apiClient, telemetry);
});

FutureProvider<Result<Map<String, dynamic>>> createVerificationReportProvider<S>(
  Provider<S> serviceProvider,
  Future<Result<Map<String, dynamic>>> Function(S service) load,
) => FutureProvider<Result<Map<String, dynamic>>>((ref) async {
  final service = ref.watch(serviceProvider);
  return await load(service);
});
