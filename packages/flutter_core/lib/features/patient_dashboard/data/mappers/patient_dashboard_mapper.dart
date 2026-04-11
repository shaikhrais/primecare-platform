import '../../domain/models/patient_dashboard_view_model.dart';
import '../dtos/patient_dashboard_dto.dart';

class PatientDashboardMapper {
  static PatientDashboardViewModel toViewModel(PatientDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return PatientDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return PatientKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return PatientDashboardViewModel(kpis: kpis);
  }

  static List<PatientKpi> _mockKpis() {
    return [
      const PatientKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const PatientKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const PatientKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const PatientKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
