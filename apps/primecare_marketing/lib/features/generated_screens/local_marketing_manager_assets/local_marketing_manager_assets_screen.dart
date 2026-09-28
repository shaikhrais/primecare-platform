import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_assets_header_section.dart';
import 'sections/local_marketing_manager_assets_content_summary_section.dart';
import 'sections/local_marketing_manager_assets_primary_content_section.dart';
import 'sections/local_marketing_manager_assets_action_bar_section.dart';

class LocalMarketingManagerAssetsScreen extends StatelessWidget {
  const LocalMarketingManagerAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_assets',
      title: 'Local Marketing Manager Assets',
      child: Column(
        children: const [
          const LocalMarketingManagerAssetsHeaderSection(),
          const LocalMarketingManagerAssetsContentSummarySection(),
          const LocalMarketingManagerAssetsPrimaryContentSection(),
          const LocalMarketingManagerAssetsActionBarSection(),
        ],
      ),
    );
  }
}
