import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/regional_manager_usa_dashboard_view_model.dart';
import '../dtos/regional_manager_usa_dashboard_dto.dart';

class RegionalManagerUsaDashboardMapper {
  static RegionalManagerUsaDashboardViewModel toViewModel(
    RegionalManagerUsaDashboardDto dto,
  ) {
    if (dto.rawKpis.isEmpty) {
      return RegionalManagerUsaDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: _mockKpis())]);
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return UniversalKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return RegionalManagerUsaDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: kpis)]);
  }

  static List<UniversalKpi> _mockKpis() {
    return [
      const UniversalKpi(
        title: 'USA Revenue (Q1)',
        value: '\$24.1M',
        trend: '+8%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Active Facilities (US)',
        value: '112',
        trend: '+5',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Regional Staff (US)',
        value: '2,300',
        trend: '+2%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Open Cases (US)',
        value: '540',
        trend: '-2%',
        status: 'Operational',
      ),
    ];
  }
}
