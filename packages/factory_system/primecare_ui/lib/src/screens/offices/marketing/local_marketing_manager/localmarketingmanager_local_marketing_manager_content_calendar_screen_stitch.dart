import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LocalmarketingmanagerLocalMarketingManagerContentCalendarScreenStitch extends ConsumerWidget {
  const LocalmarketingmanagerLocalMarketingManagerContentCalendarScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.local_marketing_manager.screens.mkt_914.title',
        subtitle: 'marketing.roles.local_marketing_manager.screens.mkt_914.subtitle',
        provider: commonFeatureDataProvider('mkt_914'),
      );
}
