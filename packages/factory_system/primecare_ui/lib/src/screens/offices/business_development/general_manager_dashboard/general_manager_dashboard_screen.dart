import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class GeneralManagerDashboardScreen extends ConsumerWidget {
  const GeneralManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'businessDevelopment.generalManager.dashboard.title',
        subtitle: 'businessDevelopment.generalManager.dashboard.subtitle',
        provider: generalManagerDashboardDataProvider('general_manager'),
      );
}
