import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/outreach_campaign_header_section.dart';
import 'sections/outreach_campaign_content_summary_section.dart';
import 'sections/outreach_campaign_primary_content_section.dart';
import 'sections/outreach_campaign_action_bar_section.dart';

class OutreachCampaignScreen extends StatelessWidget {
  const OutreachCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'outreach_campaign',
      title: 'OutreachCampaignScreen',
      child: Column(
        children: const [
          const OutreachCampaignHeaderSection(),
          const OutreachCampaignContentSummarySection(),
          const OutreachCampaignPrimaryContentSection(),
          const OutreachCampaignActionBarSection(),
        ],
      ),
    );
  }
}
