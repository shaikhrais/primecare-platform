// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE

import 'package:flutter_core/flutter_core.dart';

final verificationServiceProvider = Provider<VerificationService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.watch<ExecutionGateService>(executionGateProvider);
  return VerificationService(apiClient, telemetry);
});

final architecturePurposeProvider =
    FutureProvider<Result<Map<String, dynamic>>>((ref) async {
      final service = ref.watch(verificationServiceProvider);
      return await service.getArchitecturePurposeReport();
    });

final databaseReportProvider = FutureProvider<Result<Map<String, dynamic>>>((
  ref,
) async {
  final service = ref.watch(verificationServiceProvider);
  return await service.getDatabaseReport();
});
