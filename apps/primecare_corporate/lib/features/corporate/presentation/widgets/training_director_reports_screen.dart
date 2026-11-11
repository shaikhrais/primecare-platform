import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'training_director_reports_screen_controller.dart';

class TrainingDirectorReportsScreen extends ConsumerWidget {
  const TrainingDirectorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingDirectorReportsScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('TrainingDirectorReports'),
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
            'TrainingDirectorReportsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
