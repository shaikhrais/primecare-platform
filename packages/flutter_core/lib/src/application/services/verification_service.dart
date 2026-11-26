// Host retains the existing authenticated repository and endpoint configuration.
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_verification/verification_service.dart';
import 'base_business_service.dart';

class VerificationService extends BaseBusinessService with VerificationServiceImplementation {
  VerificationService(super.client, super.telemetry);
  @override
  String verificationEndpoint(String key) => ApiConfig.endpoints[key]!;
  @override
  Future<({int? statusCode, dynamic data})> readVerificationReport(String endpoint) async {
    final response = await repository.get(endpoint);
    return (statusCode: response.statusCode, data: response.data);
  }
}
