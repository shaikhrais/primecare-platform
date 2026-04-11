import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/head_of_marketing_dashboard_view_model.dart';
import '../dtos/head_of_marketing_dashboard_dto.dart';

class HeadOfMarketingDashboardMapper {
  static HeadOfMarketingDashboardViewModel fromApi(
    HeadOfMarketingDashboardDto dto,
  ) {
    final kpis = dto.rawKpis.map((k) => KpiMetric(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList();

    return HeadOfMarketingDashboardViewModel(
      kpis: kpis,
      blueprints: HeadOfMarketingDashboardViewModel.generateBlueprints(DashboardMetrics(
        kpis: kpis,
        recentActivity: [], // Placeholder if DTO doesn't have it
      )),
    );
  }

  static HeadOfMarketingDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return HeadOfMarketingDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
