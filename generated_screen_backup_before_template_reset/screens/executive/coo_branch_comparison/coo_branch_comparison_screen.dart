import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_branch_comparison_header_section.dart';
import 'sections/coo_branch_comparison_content_summary_section.dart';
import 'sections/coo_branch_comparison_primary_content_section.dart';
import 'sections/coo_branch_comparison_action_bar_section.dart';

class CooBranchComparisonScreen extends StatelessWidget {
  const CooBranchComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_branch_comparison',
      title: 'CooBranchComparisonScreen',
      child: Column(
        children: const [
          const CooBranchComparisonHeaderSection(),
          const CooBranchComparisonContentSummarySection(),
          const CooBranchComparisonPrimaryContentSection(),
          const CooBranchComparisonActionBarSection(),
        ],
      ),
    );
  }
}
