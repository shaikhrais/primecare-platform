import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';

/// [Controller] - Unified Franchise Intelligence Manager
/// Manages operation-critical data for Franchise Owners.
class FranchiseDashboardController extends IntegratedDashboardManager {
  @override
  String get storageKey => 'franchise_dashboard';

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

/// The global provider for Franchise Intelligence.
final franchiseDashboardControllerProvider = 
    AsyncNotifierProvider.family<FranchiseDashboardController, Result<IntelligenceDashboardModel>, String>(
  () => FranchiseDashboardController(),
);
