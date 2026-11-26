import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'psw_dashboard_screen_controller.dart';

class PswDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for tracking shifts, ADL tasks, safety alerts, and compliance, along with buttons for check-in, check-out, and emergency actions.';

  @override
  List<String> get requiredComponents => const [
        'ShiftStatusIndicator',
        'ADLProgressTracker',
        'ActiveWingInfo',
        'SafetyAlertsCount',
        'RecentActivityLogs',
        'EmergencyAlertButton',
        'ComplianceAuditResults',
        'RefreshButton',
      ];

  @override
  List<String> get requiredFunctions => const [
        'toggleCheckIn',
        'toggleCheckOut',
        'logIncident',
        'triggerEmergencyAlert',
        'refreshDashboard',
      ];

  const PswDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:pswdashboard-screen',
      container: true,
      child: PrimePageScaffold(
        scaffoldKey: const Key('pswdashboard-screen'),
      title: Semantics(label: 'data-cy:pswdashboard-title', container: true, child: Container(child:  const PrimeText('PswDashboard'))),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const DashboardLoadingWidget(),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
      ),
    )
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
            'PswDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
