import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionalManagerUsaDashboardScreen extends ConsumerWidget {
  const RegionalManagerUsaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'businessDevelopment.regionalManagerUsa.dashboard.title',
        subtitle: 'businessDevelopment.regionalManagerUsa.dashboard.subtitle',
        provider: regionalManagerUsaDashboardDataProvider('regional_manager_usa'),
      );
}
