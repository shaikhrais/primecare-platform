// Layer: 01_INFRASTRUCTURE
import 'verification_service.dart';

import 'package:primecare_ui/primecare_ui.dart';

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
