import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadofmarketingHeadOfMarketingDashboardScreenStitch extends ConsumerWidget {
  const HeadofmarketingHeadOfMarketingDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.head_of_marketing.screens.mkt_901.title',
        subtitle: 'marketing.roles.head_of_marketing.screens.mkt_901.subtitle',
        provider: commonFeatureDataProvider('mkt_901'),
      );
}
