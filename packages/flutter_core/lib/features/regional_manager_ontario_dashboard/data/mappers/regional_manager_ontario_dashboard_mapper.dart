import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/regional_manager_ontario_dashboard_view_model.dart';
import '../dtos/regional_manager_ontario_dashboard_dto.dart';

class RegionalManagerOntarioDashboardMapper {
  static RegionalManagerOntarioDashboardViewModel toViewModel(
    RegionalManagerOntarioDashboardDto dto,
  ) {
    if (dto.rawKpis.isEmpty) {
      return RegionalManagerOntarioDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: _mockKpis())]);
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return UniversalKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return RegionalManagerOntarioDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: kpis)]);
  }

  static List<UniversalKpi> _mockKpis() {
    return [
      const UniversalKpi(
        title: 'Ontario Revenue (Q1)',
        value: '\$12.5M',
        trend: '+4%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Active Facilities (ON)',
        value: '68',
        trend: '+2',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Regional Staff (ON)',
        value: '1,450',
        trend: '-1%',
        status: 'Warning',
      ),
      const UniversalKpi(
        title: 'Open Cases (ON)',
        value: '315',
        trend: '-5%',
        status: 'Operational',
      ),
    ];
  }
}
