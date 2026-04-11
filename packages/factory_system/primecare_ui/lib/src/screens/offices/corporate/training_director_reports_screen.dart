import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingDirectorReportsScreen extends ConsumerWidget {
  const TrainingDirectorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Training Director Reports',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: trainingDirectorDashboardDataProvider('training_director_reports'),
      );
}
