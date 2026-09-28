import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/local_marketing_manager_budget_header_section.dart';
import 'sections/local_marketing_manager_budget_content_summary_section.dart';
import 'sections/local_marketing_manager_budget_primary_content_section.dart';
import 'sections/local_marketing_manager_budget_action_bar_section.dart';

class LocalMarketingManagerBudgetScreen extends StatelessWidget {
  const LocalMarketingManagerBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'local_marketing_manager_budget',
      title: 'Local Marketing Manager Budget',
      child: Column(
        children: const [
          const LocalMarketingManagerBudgetHeaderSection(),
          const LocalMarketingManagerBudgetContentSummarySection(),
          const LocalMarketingManagerBudgetPrimaryContentSection(),
          const LocalMarketingManagerBudgetActionBarSection(),
        ],
      ),
    );
  }
}
