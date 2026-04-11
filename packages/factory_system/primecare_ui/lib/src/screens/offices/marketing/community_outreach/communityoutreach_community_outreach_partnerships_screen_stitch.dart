import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CommunityoutreachCommunityOutreachPartnershipsScreenStitch extends ConsumerWidget {
  const CommunityoutreachCommunityOutreachPartnershipsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.community_outreach.screens.mkt_921.title',
        subtitle: 'marketing.roles.community_outreach.screens.mkt_921.subtitle',
        provider: commonFeatureDataProvider('mkt_921'),
      );
}
