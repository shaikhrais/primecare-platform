import 'package:primecare_models/src/models/report_models.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';
import 'package:primecare_guarded_service/primecare_guarded_service.dart';

mixin ReportServiceImplementation on BaseGuardedService {
  Future<({int? statusCode, dynamic data})> readReport(String endpoint);

  Future<Result<ReportData>> getReport(String reportId) async {
    return guard<ReportData>(
      () async {
        final endpoint = '/api/reports/$reportId';
        final response = await readReport(endpoint);

        if (response.statusCode == 200) {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Report fetched successfully: $reportId',
            metadata: {'reportId': reportId},
          );
          return ReportData.fromJson(response.data as Map<String, dynamic>);
        }

        telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Report fetch returned empty (Status: ${response.statusCode})',
          metadata: {'reportId': reportId},
        );

        return ReportData.empty(
          id: reportId,
          title: 'Report Load Failure (${response.statusCode})',
          isOffline: true,
        );
      },
      onError: (Object e, StackTrace st) {
        telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Failed to fetch report: $reportId',
          error: e,
          stackTrace: st,
          metadata: {'reportId': reportId},
        );
        // Resilient fallback: Return an empty shell
        return ReportData.empty(id: reportId, isOffline: true);
      },
    );
  }
}
