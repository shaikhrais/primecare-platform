import '../../domain/models/training_coordinator_dashboard_view_model.dart';
import '../dtos/training_coordinator_dashboard_dto.dart';

class TrainingCoordinatorDashboardMapper {
  static TrainingCoordinatorDashboardViewModel toViewModel(TrainingCoordinatorDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return TrainingCoordinatorDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return TrainingCoordinatorKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return TrainingCoordinatorDashboardViewModel(kpis: kpis);
  }

  static List<TrainingCoordinatorKpi> _mockKpis() {
    return [
      const TrainingCoordinatorKpi(title: 'Active Metrics', value: '120', trend: '+5%', status: 'Operational'),
      const TrainingCoordinatorKpi(title: 'Efficiency', value: '98%', trend: '+2%', status: 'Operational'),
      const TrainingCoordinatorKpi(title: 'Reports pending', value: '5', trend: '-2', status: 'Warning'),
      const TrainingCoordinatorKpi(title: 'System Health', value: '100%', trend: 'Stable', status: 'Operational'),
    ];
  }
}
