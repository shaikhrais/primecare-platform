import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HeadofmarketingHeadOfMarketingRegionalCampaignsScreenStitch extends ConsumerWidget {
  const HeadofmarketingHeadOfMarketingRegionalCampaignsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.head_of_marketing.screens.mkt_909.title',
        subtitle: 'marketing.roles.head_of_marketing.screens.mkt_909.subtitle',
        provider: commonFeatureDataProvider('mkt_909'),
      );
}
