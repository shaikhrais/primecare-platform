import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_regional_campaigns_header_section.dart';
import 'sections/head_of_marketing_regional_campaigns_content_summary_section.dart';
import 'sections/head_of_marketing_regional_campaigns_primary_content_section.dart';
import 'sections/head_of_marketing_regional_campaigns_action_bar_section.dart';

class HeadOfMarketingRegionalCampaignsScreen extends StatelessWidget {
  const HeadOfMarketingRegionalCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_regional_campaigns',
      title: 'Head Of Marketing Regional Campaigns',
      child: Column(
        children: const [
          const HeadOfMarketingRegionalCampaignsHeaderSection(),
          const HeadOfMarketingRegionalCampaignsContentSummarySection(),
          const HeadOfMarketingRegionalCampaignsPrimaryContentSection(),
          const HeadOfMarketingRegionalCampaignsActionBarSection(),
        ],
      ),
    );
  }
}
