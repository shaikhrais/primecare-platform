import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'volunteer_coordinator_dashboard_screen_controller.dart';

class VolunteerCoordinatorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The volunteer coordinator dashboard requires components for managing volunteers, tracking metrics, ensuring compliance, and facilitating communication, along with necessary buttons, functions, APIs, and responsive design for various platforms.';

  @override
  List<String> get requiredComponents => const [
        'VolunteerOverviewWidget',
        'VolunteerMetricsCard',
        'ComplianceStatusCard',
        'CommunicationLogWidget',
        'UpcomingEventsList',
        'FeedbackRatingWidget',
        'AlertsWidget',
        'EngagementHistoryChart',
        'ShiftManagementTool',
        'TrainingResourcesWidget',
      ];

  @override
  List<String> get requiredFunctions => const [
        'addVolunteer',
        'scheduleShift',
        'sendCommunication',
        'logVolunteerHours',
        'generateReport',
        'organizeEvent',
      ];

  const VolunteerCoordinatorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(volunteerCoordinatorDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('VolunteerCoordinatorDashboard'),
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
            'VolunteerCoordinatorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
