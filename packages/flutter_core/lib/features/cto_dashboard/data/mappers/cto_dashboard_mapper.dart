import '../../domain/models/cto_dashboard_view_model.dart';
import '../dtos/cto_dashboard_dto.dart';

class CtoDashboardMapper {
  static CtoDashboardViewModel fromApi(CtoDashboardDto dto) {
    return CtoDashboardViewModel(
      kpis: [
        CtoKpi(
          title: 'System Uptime',
          value: '${dto.systemUptime.toStringAsFixed(2)}%',
          trend: '+0.01%',
          status: 'positive',
        ),
        CtoKpi(
          title: 'Active Connections',
          value: dto.activeConnections.toString(),
          trend: '+12%',
          status: 'operational',
        ),
        CtoKpi(
          title: 'Error Rate',
          value: '${dto.errorRate.toStringAsFixed(2)}%',
          trend: '-0.1%',
          status: dto.errorRate > 5 ? 'critical' : 'positive',
        ),
        CtoKpi(
          title: 'Avg Latency',
          value: '${dto.avgLatency.toStringAsFixed(0)}ms',
          trend: '-12ms',
          status: dto.avgLatency > 500 ? 'warning' : 'positive',
        ),
      ],
    );
  }

  static CtoDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CtoDashboardViewModel(
      isOfflineFallback: isErrorFallback,
      kpis:
          (mock['kpis'] as List<dynamic>?)?.map((k) {
            return CtoKpi(
              title: k['title']?.toString() ?? '',
              value: k['value']?.toString() ?? '',
              trend: k['trend']?.toString() ?? '',
              status: k['status']?.toString() ?? 'operational',
            );
          }).toList() ??
          [],
    );
  }
}
