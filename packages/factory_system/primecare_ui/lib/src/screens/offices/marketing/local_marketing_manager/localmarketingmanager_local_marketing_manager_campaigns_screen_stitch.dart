import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalmarketingmanagerLocalMarketingManagerCampaignsScreenStitch extends ConsumerWidget {
  const LocalmarketingmanagerLocalMarketingManagerCampaignsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.local_marketing_manager.screens.mkt_912.title',
        subtitle: 'marketing.roles.local_marketing_manager.screens.mkt_912.subtitle',
        provider: commonFeatureDataProvider('mkt_912'),
      );
}
