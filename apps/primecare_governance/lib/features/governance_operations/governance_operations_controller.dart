import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';

/// [Controller] - Unified Governance Intelligence Manager
/// Inherits all sync, persistence, and resilience logic from the base manager.
class GovernanceDashboardController extends IntegratedDashboardManager {
  @override
  String get storageKey => 'governance_dashboard';

  @override
  String get role => 'governance';

  @override
  Future<IntelligenceDashboardModel> fetchRemote(String role) async {
    final response = await ref.read(apiClientProvider).get('/dashboard-metrics');
    final data = response.data as Map<String, dynamic>;
    
    // Auto-map resilience/legacy keys to precision IntelligenceDashboardModel keys
    final metricsRaw = data['metrics'] ?? data['kpis'];
    final insightsRaw = data['insights'];
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
}

/// The global provider for the Governance Intelligence Manager.
final governanceDashboardControllerProvider = 
    AsyncNotifierProvider<GovernanceDashboardController, Result<IntelligenceDashboardModel>>(
  () => GovernanceDashboardController(),
);
