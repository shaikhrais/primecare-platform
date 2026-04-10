import '../../domain/models/scheduler_dashboard_view_model.dart';
import '../dtos/scheduler_dashboard_dto.dart';

class SchedulerDashboardMapper {
  static SchedulerDashboardViewModel fromApi(SchedulerDashboardDto dto) {
    return SchedulerDashboardViewModel(kpis: dto.rawKpis);
  }

  static SchedulerDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const SchedulerDashboardViewModel();
  }
}
