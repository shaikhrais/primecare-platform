import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_brand_assets_header_section.dart';
import 'sections/head_of_marketing_brand_assets_content_summary_section.dart';
import 'sections/head_of_marketing_brand_assets_primary_content_section.dart';
import 'sections/head_of_marketing_brand_assets_action_bar_section.dart';

class HeadOfMarketingBrandAssetsScreen extends StatelessWidget {
  const HeadOfMarketingBrandAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_brand_assets',
      title: 'Head Of Marketing Brand Assets',
      child: Column(
        children: const [
          const HeadOfMarketingBrandAssetsHeaderSection(),
          const HeadOfMarketingBrandAssetsContentSummarySection(),
          const HeadOfMarketingBrandAssetsPrimaryContentSection(),
          const HeadOfMarketingBrandAssetsActionBarSection(),
        ],
      ),
    );
  }
}
