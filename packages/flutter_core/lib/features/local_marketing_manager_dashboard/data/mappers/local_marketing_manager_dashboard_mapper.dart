import '../../domain/models/local_marketing_manager_dashboard_view_model.dart';
import '../dtos/local_marketing_manager_dashboard_dto.dart';

class LocalMarketingManagerDashboardMapper {
  static LocalMarketingManagerDashboardViewModel fromApi(
    LocalMarketingManagerDashboardDto dto,
  ) {
    return LocalMarketingManagerDashboardViewModel(kpis: dto.rawKpis.map((k) => LocalMarketingManagerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static LocalMarketingManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return LocalMarketingManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
