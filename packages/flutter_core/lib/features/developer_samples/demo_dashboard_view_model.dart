import 'package:flutter_core/flutter_core.dart';

class DemoDashboardViewModel {
  final List<UIComponentBlueprint> blueprints;
  final bool isOfflineFallback;

  DemoDashboardViewModel({
    required this.blueprints,
    this.isOfflineFallback = false,
  });

  /// Factory constructor that follows our Zero-Code standards.
  /// 1. Accept domain data (or primitives).
  /// 2. Orchestrate the visual layout via Blueprints.
  factory DemoDashboardViewModel.assemble({required String userName, required int taskCount}) {
    return DemoDashboardViewModel(
      blueprints: [
        // KPI Grid - Resolution aware (4k = 10 cols, Mobile = 1 col)
        StatGridBlueprint(
          dataPayload: [
            UniversalKpi(title: 'Active Tasks', value: '$taskCount', status: 'operational'),
            UniversalKpi(title: 'Welcome', value: userName, status: 'positive'),
            UniversalKpi(title: 'System Health', value: '100%', status: 'active'),
            UniversalKpi(title: 'Uptime', value: '99.9%', status: 'operational'),
          ],
        ),
        
        // Activity Feed
        ActivityFeedBlueprint(
          dataPayload: [
            {'title': 'System started', 'timestamp': 'Just now'},
            {'title': 'User logged in', 'timestamp': '2 mins ago'},
          ],
        ),
      ],
    );
  }
}
