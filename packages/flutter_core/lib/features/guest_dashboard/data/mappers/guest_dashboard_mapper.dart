import '../../domain/models/guest_dashboard_view_model.dart';
import '../dtos/guest_dashboard_dto.dart';

class GuestDashboardMapper {
  static GuestDashboardViewModel toViewModel(GuestDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return GuestDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return GuestKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return GuestDashboardViewModel(kpis: kpis);
  }

  static List<GuestKpi> _mockKpis() {
    return [
      const GuestKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const GuestKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const GuestKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const GuestKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
