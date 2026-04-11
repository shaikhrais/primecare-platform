import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide intakeDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class IntakeCoordinatorDashboard extends ConsumerWidget {
  const IntakeCoordinatorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'support.intakeCoordinator.dashboard.title',
        subtitle: 'support.intakeCoordinator.dashboard.subtitle',
        provider: intakeDashboardAdapterProvider,
      );
}
