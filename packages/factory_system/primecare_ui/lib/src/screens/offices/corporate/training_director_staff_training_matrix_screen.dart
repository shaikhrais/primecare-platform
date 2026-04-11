import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingDirectorStaffTrainingMatrixScreen extends ConsumerWidget {
  const TrainingDirectorStaffTrainingMatrixScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Training Director Staff Training Matrix',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: trainingDirectorDashboardDataProvider('training_director_staff_training_matrix'),
      );
}
