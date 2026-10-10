import 'package:primecare_models/primecare_models.dart';
import '../network/base_api_transport.dart';
import '../network/base_transport_repository.dart';
import 'base_execution_gate_service.dart';
import 'base_business_workflow.dart';

abstract class BaseReportServiceWorkflow<
  R extends BaseTransportRepository<BaseApiTransport>,
  T extends BaseExecutionGateService
>
    extends BaseBusinessWorkflow<R, T> {
  BaseReportServiceWorkflow(super.repository, super.telemetry, super.endpoints);

  Future<Result<ReportData>> getReport(String reportId) async {
    return guard<ReportData>(
      () async {
        final endpoint = '/api/reports/$reportId';
        final response = await repository.get(endpoint);

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
