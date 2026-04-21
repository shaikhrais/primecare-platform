// Layer: 01_INFRASTRUCTURE
import '01_I_verification_service.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

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
