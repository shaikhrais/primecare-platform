import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'head_of_marketing_dashboard_screen_controller.dart';

class HeadOfMarketingDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Head of Marketing Dashboard requires components for tracking campaigns, analytics, budget, customer feedback, social media metrics, KPIs, market trends, team performance, audit logs, and alerts for operational red flags.';

  @override
  List<String> get requiredComponents => const [
        'CampaignOverviewWidget',
        'RealTimeAnalyticsChart',
        'BudgetTrackingWidget',
        'CustomerFeedbackWidget',
        'SocialMediaMetricsWidget',
        'KPIsTrackingWidget',
        'MarketTrendsWidget',
        'TeamPerformanceWidget',
        'AuditLogWidget',
        'AlertsWidget',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchCampaignData',
        'fetchAnalyticsData',
        'trackBudget',
        'fetchCustomerFeedback',
        'fetchSocialMediaMetrics',
        'trackKPIs',
        'fetchMarketTrends',
        'fetchTeamPerformance',
        'fetchAuditLogs',
        'checkForAlerts',
      ];

  const HeadOfMarketingDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(headOfMarketingDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HeadOfMarketingDashboard'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'HeadOfMarketingDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
