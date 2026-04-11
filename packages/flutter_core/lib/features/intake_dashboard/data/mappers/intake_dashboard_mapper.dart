import '../../domain/models/intake_dashboard_view_model.dart';
import '../dtos/intake_dashboard_dto.dart';

class IntakeDashboardMapper {
  static IntakeDashboardViewModel toViewModel(IntakeDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return IntakeDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return IntakeKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return IntakeDashboardViewModel(kpis: kpis);
  }

  static List<IntakeKpi> _mockKpis() {
    return [
      const IntakeKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const IntakeKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const IntakeKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const IntakeKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
