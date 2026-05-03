import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';

/// [Controller] - Unified Corporate Intelligence Manager
/// Manages high-level executive data across all corporate roles (CEO, CFO, etc.)
class CorporateDashboardController extends IntegratedDashboardManager {
  @override
  String get storageKey => 'corporate_dashboard';

  @override
  Future<IntelligenceDashboardModel> fetchRemote(String role) async {
    final response = await ref.read(apiClientProvider).get('/dashboard-metrics');
    final data = response.data as Map<String, dynamic>;
    
    // Auto-map resilience/legacy keys to precision IntelligenceDashboardModel keys
    final metricsRaw = data['metrics'] ?? data['kpis'];
    final insightsRaw = data['insights'] ?? _getRoleSpecificInsights(role).map((e) => e.toJson()).toList();
    final timelineRaw = data['timeline'] ?? data['recentActivity'];
    final trendsRaw = data['trends'] ?? data['charts'];
    
    return IntelligenceDashboardModel.fromJson({
      'metrics': metricsRaw,
      'insights': insightsRaw,
      'timeline': timelineRaw,
      'trends': trendsRaw,
      'isOfflineFallback': data['isOfflineFallback'],
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }

  List<KpiMetric> _getRoleSpecificMetrics(String role) {
    switch (role.toUpperCase()) {
      case 'CEO':
        return [
          KpiMetric(title: 'Strategic Growth', value: '$84.2M', status: 'success', subtitle: '+14.8% YoY'),
          KpiMetric(title: 'Global NPS', value: '78', status: 'success', subtitle: '+3.0 vs LY'),
          KpiMetric(title: 'Market Cap', value: '$1.2B', status: 'positive', subtitle: 'Strong Growth'),
        ];
      case 'CFO':
        return [
          KpiMetric(title: 'Net Margin', value: '24.2%', status: 'success', subtitle: 'Above Target'),
          KpiMetric(title: 'OpEx Ratio', value: '18.4%', status: 'positive', subtitle: 'Efficient'),
          KpiMetric(title: 'Cash Reserve', value: '$42M', status: 'success', subtitle: 'Liquid'),
        ];
      default:
        return [
          KpiMetric(title: 'Operations', value: 'Optimal', status: 'success', subtitle: 'All Systems'),
        ];
    }
  }

  List<DashboardInsight> _getRoleSpecificInsights(String role) {
    return [
      DashboardInsight(
        title: '${role.toUpperCase()} Strategic Insight',
        description: 'Optimization potential of 12% detected in regional workflows.',
        type: 'growth',
        impact: InsightImpact.growth,
      ),
      DashboardInsight(
        title: 'Network Resilience',
        description: 'Current platform stability is at 99.99%.',
        type: 'success',
        impact: InsightImpact.positive,
      ),
    ];
  }
}

/// The global provider for Corporate Intelligence.
final corporateDashboardControllerProvider = 
    AsyncNotifierProvider.family<CorporateDashboardController, Result<IntelligenceDashboardModel>, String>(
  () => CorporateDashboardController(),
);
