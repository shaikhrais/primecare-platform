import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide qaDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class QualityAssuranceDashboard extends ConsumerWidget {
  const QualityAssuranceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'support.qualityAssurance.dashboard.title',
        subtitle: 'support.qualityAssurance.dashboard.subtitle',
        provider: qaDashboardAdapterProvider,
      );
}
