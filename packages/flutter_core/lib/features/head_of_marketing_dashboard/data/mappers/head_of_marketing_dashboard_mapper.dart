import '../../domain/models/head_of_marketing_dashboard_view_model.dart';
import '../dtos/head_of_marketing_dashboard_dto.dart';

class HeadOfMarketingDashboardMapper {
  static HeadOfMarketingDashboardViewModel fromApi(
    HeadOfMarketingDashboardDto dto,
  ) {
    return HeadOfMarketingDashboardViewModel(kpis: dto.rawKpis.map((k) => HeadOfMarketingDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static HeadOfMarketingDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return HeadOfMarketingDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
