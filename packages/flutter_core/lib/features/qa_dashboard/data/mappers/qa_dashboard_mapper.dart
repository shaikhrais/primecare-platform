import '../../domain/models/qa_dashboard_view_model.dart';
import '../dtos/qa_dashboard_dto.dart';

class QaDashboardMapper {
  static QaDashboardViewModel toViewModel(QaDashboardDto dto) {
    if (dto.rawKpis.isEmpty) {
      return QaDashboardViewModel(kpis: _mockKpis());
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return QaKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    return QaDashboardViewModel(kpis: kpis);
  }

  static List<QaKpi> _mockKpis() {
    return [
      const QaKpi(
        title: 'Active Metrics',
        value: '120',
        trend: '+5%',
        status: 'Operational',
      ),
      const QaKpi(
        title: 'Efficiency',
        value: '98%',
        trend: '+2%',
        status: 'Operational',
      ),
      const QaKpi(
        title: 'Reports pending',
        value: '5',
        trend: '-2',
        status: 'Warning',
      ),
      const QaKpi(
        title: 'System Health',
        value: '100%',
        trend: 'Stable',
        status: 'Operational',
      ),
    ];
  }
}
