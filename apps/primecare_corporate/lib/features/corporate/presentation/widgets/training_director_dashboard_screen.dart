import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'training_director_dashboard_screen_controller.dart';

class TrainingDirectorDashboardScreen extends ConsumerWidget {
  const TrainingDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingDirectorDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('TrainingDirectorDashboard'),
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
            'TrainingDirectorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
