// Existing business service and authenticated repository are retained.
import 'package:primecare_reporting/report_service.dart';
import 'base_business_service.dart';

class ReportService extends BaseBusinessService with ReportServiceImplementation {
  ReportService(super.client, super.telemetry);
  @override
  Future<({int? statusCode, dynamic data})> readReport(String endpoint) async {
    final response = await repository.get(endpoint);
    return (statusCode: response.statusCode, data: response.data);
  }
}
