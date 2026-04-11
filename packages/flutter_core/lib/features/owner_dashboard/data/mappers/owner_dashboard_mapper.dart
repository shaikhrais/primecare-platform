import '../../domain/models/owner_dashboard_view_model.dart';
import '../dtos/owner_dashboard_dto.dart';

class OwnerDashboardMapper {
  static OwnerDashboardViewModel fromApi(OwnerDashboardDto dto) {
    return OwnerDashboardViewModel(kpis: dto.rawKpis.map((k) => OwnerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static OwnerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return OwnerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
