import '../../domain/models/support_dashboard_view_model.dart';
import '../dtos/support_dashboard_dto.dart';

class SupportDashboardMapper {
  static SupportDashboardViewModel toViewModel(SupportDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return SupportDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return SupportKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return SupportDashboardViewModel(kpis: kpis);
  }

  static List<SupportKpi> _mockKpis() {
    return [
      const SupportKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const SupportKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const SupportKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const SupportKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
