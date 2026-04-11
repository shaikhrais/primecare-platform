import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/training_director_dashboard_view_model.dart';
import '../dtos/training_director_dashboard_dto.dart';

class TrainingDirectorDashboardMapper {
  static TrainingDirectorDashboardViewModel toViewModel(
    TrainingDirectorDashboardDto dto,
  ) {
    if (dto.rawKpis.isEmpty) {
      return TrainingDirectorDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: _mockKpis())]);
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return UniversalKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return TrainingDirectorDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: kpis)]);
  }

  static List<UniversalKpi> _mockKpis() {
    return [
      const UniversalKpi(
        title: 'Active Trainees',
        value: '450',
        trend: '+15%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Course Completion Rate',
        value: '85%',
        trend: '+5%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Average Score',
        value: '92%',
        trend: '+2%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Overdue Training',
        value: '18',
        trend: '-10%',
        status: 'Warning',
      ),
    ];
  }
}
