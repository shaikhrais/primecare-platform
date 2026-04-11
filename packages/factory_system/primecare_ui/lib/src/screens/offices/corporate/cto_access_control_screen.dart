import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CtoAccessControlScreen extends ConsumerWidget {
  const CtoAccessControlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Cto Access Control',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: ctoDashboardDataProvider('cto_access_control'),
      );
}
