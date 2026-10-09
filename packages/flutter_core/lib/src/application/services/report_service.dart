import 'package:flutter_core/flutter_core.dart'
    hide ReportData, ReportRow, ReportColumn;
import 'base_business_service.dart';
import '../../domain/models/report_models.dart';

class ReportService extends BaseBusinessService {
  ReportService(super.client, super.telemetry);

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
