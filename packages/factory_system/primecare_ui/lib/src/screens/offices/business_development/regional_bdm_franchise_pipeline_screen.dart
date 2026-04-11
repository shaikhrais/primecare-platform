import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/components/layouts/provider_layout.dart';
import 'package:primecare_ui/src/components/primecare_stat_card.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionalBdmFranchisePipelineScreen extends ConsumerWidget {
  const RegionalBdmFranchisePipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Regional Bdm Franchise Pipeline',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: regionalBdmFranchisePipelineDataProvider('all'),
      );
}
