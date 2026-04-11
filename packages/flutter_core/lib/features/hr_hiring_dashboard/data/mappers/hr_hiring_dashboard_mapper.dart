import '../../domain/models/hr_hiring_dashboard_view_model.dart';
import '../dtos/hr_hiring_dashboard_dto.dart';

class HrHiringDashboardMapper {
  static HrHiringDashboardViewModel fromApi(HrHiringDashboardDto dto) {
    return HrHiringDashboardViewModel(kpis: dto.rawKpis.map((k) => HrHiringDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static HrHiringDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return HrHiringDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
