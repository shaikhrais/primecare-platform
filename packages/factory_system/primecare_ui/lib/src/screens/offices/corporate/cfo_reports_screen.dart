import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CfoReportsScreen extends ConsumerWidget {
  const CfoReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Cfo Reports',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: cfoDashboardDataProvider('cfo_reports'),
      );
}
