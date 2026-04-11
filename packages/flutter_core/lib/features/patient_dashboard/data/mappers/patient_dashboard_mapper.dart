import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/patient_dashboard_view_model.dart';
import '../dtos/patient_dashboard_dto.dart';

class PatientDashboardMapper {
  static PatientDashboardViewModel toViewModel(PatientDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return PatientDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: _mockKpis())]);
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return UniversalKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return PatientDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: kpis)]);
  }

  static List<UniversalKpi> _mockKpis() {
    return [
      const UniversalKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const UniversalKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
