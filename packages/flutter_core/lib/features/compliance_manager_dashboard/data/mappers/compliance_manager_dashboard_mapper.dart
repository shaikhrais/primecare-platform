import '../../domain/models/compliance_manager_dashboard_view_model.dart';
import '../dtos/compliance_manager_dashboard_dto.dart';

class ComplianceManagerDashboardMapper {
  static ComplianceManagerDashboardViewModel toViewModel(ComplianceManagerDashboardDto dto) {
    if (dto.rawKpis.isEmpty && dto.rawRecentActivity.isEmpty) {
      return ComplianceManagerDashboardViewModel(
        kpis: _mockKpis(),
        recentActivity: _mockRecentActivity(),
      );
    }

    final kpis = dto.rawKpis.map((kpiMap) {
      return ComplianceKpi(
        title: kpiMap['title']?.toString() ?? 'Metric',
        value: kpiMap['value']?.toString() ?? '0',
        trend: kpiMap['trend']?.toString() ?? '0%',
        status: kpiMap['status']?.toString() ?? 'Unknown',
      );
    }).toList();

    final recentActivity = dto.rawRecentActivity.map((activityMap) {
      return ComplianceActivity(
        title: activityMap['title']?.toString() ?? 'Activity',
        subtitle: activityMap['subtitle']?.toString() ?? 'Description',
        timestamp: activityMap['timestamp']?.toString() ?? 'Just now',
      );
    }).toList();

    return ComplianceManagerDashboardViewModel(
      kpis: kpis.isNotEmpty ? kpis : _mockKpis(),
      recentActivity: recentActivity.isNotEmpty ? recentActivity : _mockRecentActivity(),
    );
  }

  static List<ComplianceKpi> _mockKpis() {
    return [
      const ComplianceKpi(title: 'Open Incidents', value: '12', trend: '-2%', status: 'Warning'),
      const ComplianceKpi(title: 'Audit Pass Rate', value: '98%', trend: '+1%', status: 'Operational'),
      const ComplianceKpi(title: 'Policy Violations', value: '3', trend: '-1', status: 'Warning'),
      const ComplianceKpi(title: 'Upcoming Renewals', value: '45', trend: 'N/A', status: 'Operational'),
    ];
  }

  static List<ComplianceActivity> _mockRecentActivity() {
    return [
      const ComplianceActivity(
        title: 'Policy Update Required',
        subtitle: 'HR Handbook needs revision for Q3',
        timestamp: '2 hours ago',
      ),
      const ComplianceActivity(
        title: 'Audit Passed',
        subtitle: 'Branch 4 passed health & safety audit',
        timestamp: '5 hours ago',
      ),
      const ComplianceActivity(
        title: 'Incident Reported',
        subtitle: 'Minor slip and fall at Branch 12',
        timestamp: '1 day ago',
      ),
    ];
  }
}
