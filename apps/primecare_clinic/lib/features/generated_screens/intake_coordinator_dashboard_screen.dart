import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'intake_coordinator_dashboard_screen_controller.dart';

class IntakeCoordinatorDashboardScreen extends ConsumerWidget {
  const IntakeCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intakeCoordinatorDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:intakecoordinatordashboard-screen',
      container: true,
      child: PrimePageScaffold(
        scaffoldKey: const Key('intakecoordinatordashboard-screen'),
      title: Semantics(label: 'data-cy:intakecoordinatordashboard-title', container: true, child: Container(child:  const PrimeText('IntakeCoordinatorDashboard'))),
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
            'IntakeCoordinatorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
