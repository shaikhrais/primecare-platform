import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_campaigns_header_section.dart';
import 'sections/head_of_marketing_campaigns_content_summary_section.dart';
import 'sections/head_of_marketing_campaigns_primary_content_section.dart';
import 'sections/head_of_marketing_campaigns_action_bar_section.dart';

class HeadOfMarketingCampaignsScreen extends StatelessWidget {
  const HeadOfMarketingCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_campaigns',
      title: 'Head Of Marketing Campaigns',
      child: Column(
        children: const [
          const HeadOfMarketingCampaignsHeaderSection(),
          const HeadOfMarketingCampaignsContentSummarySection(),
          const HeadOfMarketingCampaignsPrimaryContentSection(),
          const HeadOfMarketingCampaignsActionBarSection(),
        ],
      ),
    );
  }
}
