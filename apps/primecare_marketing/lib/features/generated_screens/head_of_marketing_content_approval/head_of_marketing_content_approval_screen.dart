import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_content_approval_header_section.dart';
import 'sections/head_of_marketing_content_approval_content_summary_section.dart';
import 'sections/head_of_marketing_content_approval_primary_content_section.dart';
import 'sections/head_of_marketing_content_approval_action_bar_section.dart';

class HeadOfMarketingContentApprovalScreen extends StatelessWidget {
  const HeadOfMarketingContentApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_content_approval',
      title: 'Head Of Marketing Content Approval',
      child: Column(
        children: const [
          const HeadOfMarketingContentApprovalHeaderSection(),
          const HeadOfMarketingContentApprovalContentSummarySection(),
          const HeadOfMarketingContentApprovalPrimaryContentSection(),
          const HeadOfMarketingContentApprovalActionBarSection(),
        ],
      ),
    );
  }
}
