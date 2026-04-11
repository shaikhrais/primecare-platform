import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionalManagerOntarioDashboard extends ConsumerWidget {
  const RegionalManagerOntarioDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'RegionalManagerOntario Dashboard',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: regionalManagerOntarioDashboardDataProvider('regional_manager_ontario'),
      );
}
