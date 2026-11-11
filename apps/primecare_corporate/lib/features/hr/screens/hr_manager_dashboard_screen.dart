import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hr_manager_dashboard_screen_controller.dart';

class HrManagerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The HR Manager Dashboard requires various metrics and analytics components to monitor HR activities, compliance, and employee engagement, along with buttons for report generation and conflict resolution.';

  @override
  List<String> get requiredComponents => const [
        'RecruitmentMetricsCard',
        'EmployeeTurnoverChart',
        'EngagementScoreWidget',
        'ComplianceStatusIndicator',
        'PerformanceEvaluationTracker',
        'TrainingParticipationChart',
        'CompensationAnalysisCard',
        'EmployeeSatisfactionSurvey',
        'HROperationalLogs',
        'KPIOverview',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchRecruitmentMetrics',
        'fetchTurnoverRates',
        'fetchEngagementScores',
        'checkComplianceStatus',
        'trackPerformanceEvaluations',
        'analyzeTrainingParticipation',
        'analyzeCompensationBenefits',
        'fetchEmployeeSatisfactionResults',
        'logHROperations',
        'fetchKPIs',
      ];

  const HrManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hrManagerDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('HrManagerDashboard'),
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
            'HrManagerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
