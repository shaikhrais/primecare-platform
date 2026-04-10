import '../../domain/models/training_director_dashboard_view_model.dart';
import '../dtos/training_director_dashboard_dto.dart';

class TrainingDirectorDashboardMapper {
  static TrainingDirectorDashboardViewModel toViewModel(TrainingDirectorDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return TrainingDirectorDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return TrainingKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return TrainingDirectorDashboardViewModel(kpis: kpis);
  }

  static List<TrainingKpi> _mockKpis() {
    return [
      const TrainingKpi(title: 'Active Trainees', value: '450', trend: '+15%', status: 'Operational'),
      const TrainingKpi(title: 'Course Completion Rate', value: '85%', trend: '+5%', status: 'Operational'),
      const TrainingKpi(title: 'Average Score', value: '92%', trend: '+2%', status: 'Operational'),
      const TrainingKpi(title: 'Overdue Training', value: '18', trend: '-10%', status: 'Warning'),
    ];
  }
}
