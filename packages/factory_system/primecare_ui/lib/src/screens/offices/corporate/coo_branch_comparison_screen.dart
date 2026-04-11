import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CooBranchComparisonScreen extends ConsumerWidget {
  const CooBranchComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Coo Branch Comparison',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: cooDashboardDataProvider('coo_branch_comparison'),
      );
}
