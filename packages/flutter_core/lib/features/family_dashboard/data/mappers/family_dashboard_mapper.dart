import '../../domain/models/family_dashboard_view_model.dart';
import '../dtos/family_dashboard_dto.dart';

class FamilyDashboardMapper {
  static FamilyDashboardViewModel fromApi(FamilyDashboardDto dto) {
    return FamilyDashboardViewModel(kpis: dto.rawKpis.map((k) => FamilyDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static FamilyDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return FamilyDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
