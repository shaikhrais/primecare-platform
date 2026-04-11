import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingDirectorComplianceTrainingScreen extends ConsumerWidget {
  const TrainingDirectorComplianceTrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Training Director Compliance Training',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: trainingDirectorDashboardDataProvider('training_director_compliance_training'),
      );
}
