// Legacy composition supplies the original report service and provider identity.
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_reporting/report_providers.dart';

/// Provider for the ReportService instance.
final reportServiceProvider = Provider<ReportService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.read<ExecutionGateService>(executionGateProvider);
  return ReportService(apiClient, telemetry);
});

final reportDataProvider = FutureProvider.family<Result<ReportData>, String>((ref,reportId) {
  final reportService = ref.watch(reportServiceProvider);
  return loadReportData(ref, reportId, () => reportService.getReport(reportId));
});

final auraFinancialForecastProvider =
  Provider<({List<DataPoint> forecast,List<IntelligenceInsight> insights})>((ref) =>
    buildAuraFinancialForecast(ref.watch(reportDataProvider('revenue_log'))));
