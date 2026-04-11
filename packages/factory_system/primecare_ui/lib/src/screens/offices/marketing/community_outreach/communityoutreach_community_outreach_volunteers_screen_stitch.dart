import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CommunityoutreachCommunityOutreachVolunteersScreenStitch extends ConsumerWidget {
  const CommunityoutreachCommunityOutreachVolunteersScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'marketing.roles.community_outreach.screens.mkt_922.title',
        subtitle: 'marketing.roles.community_outreach.screens.mkt_922.subtitle',
        provider: commonFeatureDataProvider('mkt_922'),
      );
}
