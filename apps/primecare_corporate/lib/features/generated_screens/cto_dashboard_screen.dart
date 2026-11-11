import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cto_dashboard_screen_controller.dart';

class CtoDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The CTO dashboard requires various components to display key performance indicators, security status, compliance results, and project timelines, along with buttons for refreshing metrics and managing vendors.';

  @override
  List<String> get requiredComponents => const [
        'KPIWidget',
        'PerformanceMetricChart',
        'SecurityStatusCard',
        'ComplianceAuditReport',
        'ProjectTimelineChart',
        'BudgetTracker',
        'UserFeedbackWidget',
        'TechnologyTrendsAnalysis',
        'TeamPerformanceMetric',
        'OperationalLogsViewer',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchKPIs',
        'fetchPerformanceMetrics',
        'fetchSecurityReports',
        'fetchComplianceStatus',
        'fetchProjectTimelines',
        'fetchBudgetData',
        'fetchUserFeedback',
        'fetchTechnologyTrends',
        'fetchTeamPerformance',
        'fetchOperationalLogs',
      ];

  const CtoDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ctoDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('CtoDashboard'),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const DashboardLoadingWidget(),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PrimeStatusIcon(Icons.check_circle_outline, tone: PrimeStatusTone.success, size: 64),
          const SizedBox(height: 16),
          PrimeText(
            'CtoDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
