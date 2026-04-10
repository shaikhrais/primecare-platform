import '../../domain/models/coo_dashboard_view_model.dart';
import '../dtos/coo_dashboard_dto.dart';

class CooDashboardMapper {
  static CooDashboardViewModel fromApi(CooDashboardDto dto) {
    return CooDashboardViewModel(
      kpis: [
        CooKpi(
          title: 'Active Shifts',
          value: dto.activeShifts.toString(),
          trend: '+24',
          status: 'positive',
        ),
        CooKpi(
          title: 'Fulfillment Rate',
          value: '${dto.fulfillmentRate.toStringAsFixed(1)}%',
          trend: '+1.2%',
          status: 'positive',
        ),
        CooKpi(
          title: 'Compliance Score',
          value: '${dto.complianceScore.toStringAsFixed(1)}%',
          trend: '+0.5%',
          status: 'operational',
        ),
        CooKpi(
          title: 'Critical Incidents',
          value: dto.criticalIncidents.toString(),
          trend: '-2',
          status: dto.criticalIncidents > 0 ? 'critical' : 'positive',
        ),
      ],
    );
  }

  static CooDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return CooDashboardViewModel(
      kpis: (mock['kpis'] as List<dynamic>?)?.map((k) {
        return CooKpi(
          title: k['title']?.toString() ?? '',
          value: k['value']?.toString() ?? '',
          trend: k['trend']?.toString() ?? '',
          status: k['status']?.toString() ?? 'operational',
        );
      }).toList() ?? [],
    );
  }
}
