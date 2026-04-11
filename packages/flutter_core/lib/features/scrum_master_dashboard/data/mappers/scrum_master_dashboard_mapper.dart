import '../../domain/models/scrum_master_dashboard_view_model.dart';
import '../dtos/scrum_master_dashboard_dto.dart';

class ScrumMasterDashboardMapper {
  static ScrumMasterDashboardViewModel toViewModel(
    ScrumMasterDashboardDto dto,
  ) {
    if (dto.rawKpis.isEmpty) {
      return ScrumMasterDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return ScrumMasterKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return ScrumMasterDashboardViewModel(kpis: kpis);
  }

  static List<ScrumMasterKpi> _mockKpis() {
    return [
      const ScrumMasterKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const ScrumMasterKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const ScrumMasterKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const ScrumMasterKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
