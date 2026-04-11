import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CeoDashboardScreen extends ConsumerWidget {
  const CeoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'common.ceo.dashboard.title',
        subtitle: 'common.ceo.dashboard.subtitle',
        provider: ceoDashboardDataProvider('ceo'),
      );
}
