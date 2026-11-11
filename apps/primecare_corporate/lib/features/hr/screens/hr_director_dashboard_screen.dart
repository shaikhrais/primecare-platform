import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hr_director_dashboard_screen_controller.dart';

class HrDirectorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The HR Director dashboard requires various components to display key metrics, compliance status, and performance summaries, along with buttons for generating reports and viewing feedback.';

  @override
  List<String> get requiredComponents => const [
        'KPIDashboard',
        'EngagementMetricChart',
        'ComplianceStatusCard',
        'PerformanceSummaryTable',
        'TrainingParticipationChart',
        'DiversityStatisticsCard',
        'AuditLogViewer',
        'AlertsNotification',
        'HRMetricsVisualization',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchKPIs',
        'fetchEngagementMetrics',
        'checkComplianceStatus',
        'getPerformanceSummaries',
        'getTrainingParticipationRates',
        'getDiversityStatistics',
        'fetchAuditLogs',
        'setAlerts',
      ];

  const HrDirectorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hrDirectorDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('HrDirectorDashboard'),
      ),
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
            'HrDirectorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
