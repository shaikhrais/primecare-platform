import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'verification_service.dart';
import 'api_providers.dart';
import 'telemetry_service.dart';
import 'network/result.dart';

final verificationServiceProvider = Provider<VerificationService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.watch(executionGateProvider);
  return VerificationService(apiClient, telemetry);
});

final architecturePurposeProvider = FutureProvider<Result<Map<String, dynamic>>>((ref) async {
  final service = ref.watch(verificationServiceProvider);
  return await service.getArchitecturePurposeReport();
});

final databaseReportProvider = FutureProvider<Result<Map<String, dynamic>>>((ref) async {
  final service = ref.watch(verificationServiceProvider);
  return await service.getDatabaseReport();
});
