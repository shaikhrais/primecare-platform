import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/compliance_manager_dashboard_view_model.dart';
import '../dtos/compliance_manager_dashboard_dto.dart';

class ComplianceManagerDashboardMapper {
  static ComplianceManagerDashboardViewModel toViewModel(
    ComplianceManagerDashboardDto dto,
  ) {
    if (dto.rawKpis.isEmpty) return ComplianceManagerDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: _mockKpis())]);

    final kpis = dto.rawKpis.map((kpiMap) {
      return UniversalKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return ComplianceManagerDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: kpis.isNotEmpty ? kpis : _mockKpis()),
      ]
    );
  }

  static List<UniversalKpi> _mockKpis() {
    return [
      const UniversalKpi(
        title: 'Open Incidents',
        value: '12',
        trend: '-2%',
        status: 'Warning',
      ),
      const UniversalKpi(
        title: 'Audit Pass Rate',
        value: '98%',
        trend: '+1%',
        status: 'Operational',
      ),
      const UniversalKpi(
        title: 'Policy Violations',
        value: '3',
        trend: '-1',
        status: 'Warning',
      ),
      const UniversalKpi(
        title: 'Upcoming Renewals',
        value: '45',
        trend: 'N/A',
        status: 'Operational',
      ),
    ];
  }
}
