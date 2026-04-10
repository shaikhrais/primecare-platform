import '../../domain/models/ceo_dashboard_view_model.dart';
import '../dtos/ceo_dashboard_dto.dart';

class CeoDashboardMapper {
  static CeoDashboardViewModel fromApi(CeoDashboardDto dto) {
    return CeoDashboardViewModel(
      kpis: [
        CeoKpi(
          title: 'YTD Revenue',
          value: '\$${dto.ytdRevenue.toStringAsFixed(2)}',
          trend: '+12%', // This could optionally be returned from the API
          status: 'positive',
        ),
        CeoKpi(
          title: 'Total Facilities',
          value: dto.totalFacilities.toString(),
          trend: '+2',
          status: 'operational',
        ),
        CeoKpi(
          title: 'Active Staff',
          value: dto.activeStaff.toString(),
          trend: '+5%',
          status: 'operational',
        ),
        CeoKpi(
          title: 'Critical Alerts',
          value: dto.criticalAlerts.toString(),
          trend: '-1',
          status: dto.criticalAlerts > 0 ? 'critical' : 'positive',
        ),
      ],
      recentActivity: dto.rawActivities.map((a) {
        return CeoActivity(
          title: a['title']?.toString() ?? '',
          subtitle: a['subtitle']?.toString() ?? '',
          timestamp: a['timestamp']?.toString() ?? '',
        );
      }).toList(),
    );
  }

  static CeoDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return CeoDashboardViewModel(
      kpis: (mock['kpis'] as List<dynamic>?)?.map((k) {
        return CeoKpi(
          title: k['title']?.toString() ?? '',
          value: k['value']?.toString() ?? '',
          trend: k['trend']?.toString() ?? '',
          status: k['status']?.toString() ?? 'operational',
        );
      }).toList() ?? [],
      recentActivity: (mock['recentActivity'] as List<dynamic>?)?.map((a) {
        return CeoActivity(
            title: a['title']?.toString() ?? '',
            subtitle: a['subtitle']?.toString() ?? '',
            timestamp: a['timestamp']?.toString() ?? '',
        );
      }).toList() ?? [],
    );
  }
}
