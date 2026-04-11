import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalmarketingmanagerLocalMarketingManagerReportsScreenStitch extends ConsumerWidget {
  const LocalmarketingmanagerLocalMarketingManagerReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.local_marketing_manager.screens.mkt_917.title',
        subtitle: 'marketing.roles.local_marketing_manager.screens.mkt_917.subtitle',
        provider: commonFeatureDataProvider('mkt_917'),
      );
}
