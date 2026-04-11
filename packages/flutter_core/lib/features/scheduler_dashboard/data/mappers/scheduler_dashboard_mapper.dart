import '../../domain/models/scheduler_dashboard_view_model.dart';
import '../dtos/scheduler_dashboard_dto.dart';

class SchedulerDashboardMapper {
  static SchedulerDashboardViewModel fromApi(SchedulerDashboardDto dto) {
    return SchedulerDashboardViewModel(kpis: dto.rawKpis.map((k) => SchedulerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static SchedulerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return SchedulerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
