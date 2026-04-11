import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';

class TrainingDirectorDashboardScreen extends ConsumerWidget {
  const TrainingDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Training Director Dashboard',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: trainingDirectorDashboardDataProvider('training_director_dashboard'),
      );
}
