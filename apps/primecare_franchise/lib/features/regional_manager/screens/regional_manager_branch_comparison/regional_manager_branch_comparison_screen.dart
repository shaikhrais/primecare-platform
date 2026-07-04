import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_manager_branch_comparison_header_section.dart';
import 'sections/regional_manager_branch_comparison_content_summary_section.dart';
import 'sections/regional_manager_branch_comparison_primary_content_section.dart';
import 'sections/regional_manager_branch_comparison_action_bar_section.dart';

class RegionalManagerBranchComparisonScreen extends StatelessWidget {
  const RegionalManagerBranchComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_manager_branch_comparison',
      title: 'Regional Manager Branch Comparison',
      child: Column(
        children: const [
          const RegionalManagerBranchComparisonHeaderSection(),
          const RegionalManagerBranchComparisonContentSummarySection(),
          const RegionalManagerBranchComparisonPrimaryContentSection(),
          const RegionalManagerBranchComparisonActionBarSection(),
        ],
      ),
    );
  }
}
