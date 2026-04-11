import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalmarketingmanagerLocalMarketingManagerBudgetScreenStitch extends ConsumerWidget {
  const LocalmarketingmanagerLocalMarketingManagerBudgetScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.local_marketing_manager.screens.mkt_916.title',
        subtitle: 'marketing.roles.local_marketing_manager.screens.mkt_916.subtitle',
        provider: commonFeatureDataProvider('mkt_916'),
      );
}
