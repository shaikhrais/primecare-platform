// Host composition retains the original authenticated verification service.
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_verification/verification_providers.dart';

final verificationServiceProvider =
  createVerificationServiceProvider<VerificationService, ApiClient>(
    (ref) => ref.watch(apiClientProvider), VerificationService.new);

final architecturePurposeProvider = createVerificationReportProvider(
  verificationServiceProvider, (service) => service.getArchitecturePurposeReport());

final databaseReportProvider = createVerificationReportProvider(
  verificationServiceProvider, (service) => service.getDatabaseReport());
