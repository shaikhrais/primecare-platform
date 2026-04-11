import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CommunityoutreachCommunityOutreachDashboardScreenStitch extends ConsumerWidget {
  const CommunityoutreachCommunityOutreachDashboardScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.community_outreach.screens.mkt_903.title',
        subtitle: 'marketing.roles.community_outreach.screens.mkt_903.subtitle',
        provider: commonFeatureDataProvider('mkt_903'),
      );
}
