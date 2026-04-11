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
      complianceTargetValue: dto.complianceScore,
      funnelSteps: _mapFunnel(dto.funnelSteps),
      ganttTasks: _mapGantt(dto.ganttTasks),
    );
  }

  static CooDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return CooDashboardViewModel(
      kpis:
          (mock['kpis'] as List<dynamic>?)?.map((k) {
            return CooKpi(
              title: k['title']?.toString() ?? '',
              value: k['value']?.toString() ?? '',
              trend: k['trend']?.toString() ?? '',
              status: k['status']?.toString() ?? 'operational',
            );
          }).toList() ??
          [],
      complianceTargetValue:
          (mock['complianceTargetValue'] as num?)?.toDouble() ?? 0,
      funnelSteps: _mapFunnel(mock['funnelSteps'] as List<dynamic>?),
      ganttTasks: _mapGantt(mock['ganttTasks'] as List<dynamic>?),
    );
  }

  static List<CooFunnelStep> _mapFunnel(List<dynamic>? rawList) {
    if (rawList == null) return [];
    return rawList.map((e) {
      final map = e as Map<String, dynamic>;
      return CooFunnelStep(
        label: map['label']?.toString() ?? '',
        count: (map['count'] as num?)?.toInt() ?? 0,
      );
    }).toList();
  }

  static List<CooGanttTask> _mapGantt(List<dynamic>? rawList) {
    if (rawList == null) return [];
    return rawList.map((e) {
      final map = e as Map<String, dynamic>;
      return CooGanttTask(
        id: map['id']?.toString() ?? '',
        name: map['name']?.toString() ?? '',
        startTime: DateTime.parse(
          map['startTime']?.toString() ?? DateTime.now().toIso8601String(),
        ),
        endTime: DateTime.parse(
          map['endTime']?.toString() ??
              DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        ),
      );
    }).toList();
  }
}
