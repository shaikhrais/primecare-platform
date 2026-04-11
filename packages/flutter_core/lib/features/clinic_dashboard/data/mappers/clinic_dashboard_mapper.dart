import '../../domain/models/clinic_dashboard_view_model.dart';
import '../dtos/clinic_dashboard_dto.dart';

class ClinicDashboardMapper {
  static ClinicDashboardViewModel fromApi(ClinicDashboardDto dto) {
    return ClinicDashboardViewModel(kpis: dto.rawKpis.map((k) => ClinicDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static ClinicDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return ClinicDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
