import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/marketing_manager_campaigns_header_section.dart';
import 'sections/marketing_manager_campaigns_content_summary_section.dart';
import 'sections/marketing_manager_campaigns_primary_content_section.dart';
import 'sections/marketing_manager_campaigns_action_bar_section.dart';

class MarketingManagerCampaignsScreen extends StatelessWidget {
  const MarketingManagerCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'marketing_manager_campaigns',
      title: 'Marketing Manager Campaigns',
      child: Column(
        children: const [
          const MarketingManagerCampaignsHeaderSection(),
          const MarketingManagerCampaignsContentSummarySection(),
          const MarketingManagerCampaignsPrimaryContentSection(),
          const MarketingManagerCampaignsActionBarSection(),
        ],
      ),
    );
  }
}
