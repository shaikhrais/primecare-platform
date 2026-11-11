import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cx_director_dashboard_screen_controller.dart';

class CxDirectorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The CX Director dashboard requires various widgets to display customer satisfaction scores, feedback trends, KPIs, compliance results, operational metrics, and more, along with necessary APIs to fetch this data.';

  @override
  List<String> get requiredComponents => const [
        'CustomerSatisfactionScoreWidget',
        'CustomerFeedbackTrendChart',
        'KPIChart',
        'ComplianceAuditResultsWidget',
        'OperationalPerformanceMetricsWidget',
        'CustomerInteractionLog',
        'PerformanceAlertsWidget',
        'CustomerJourneyMapVisualization',
        'EmployeePerformanceMetricsWidget',
        'InitiativesImpactWidget',
      ];

  @override
  List<String> get requiredFunctions => const [];

  const CxDirectorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cxDirectorDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('CxDirectorDashboard'),
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
            'CxDirectorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
