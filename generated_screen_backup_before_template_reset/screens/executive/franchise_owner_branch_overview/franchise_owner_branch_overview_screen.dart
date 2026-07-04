import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_branch_overview_header_section.dart';
import 'sections/franchise_owner_branch_overview_filter_bar_section.dart';
import 'sections/franchise_owner_branch_overview_data_table_section.dart';
import 'sections/franchise_owner_branch_overview_pagination_section.dart';
import 'sections/franchise_owner_branch_overview_action_bar_section.dart';

class FranchiseOwnerBranchOverviewScreen extends StatelessWidget {
  const FranchiseOwnerBranchOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_branch_overview',
      title: 'FranchiseOwnerBranchOverviewScreen',
      child: Column(
        children: const [
          const FranchiseOwnerBranchOverviewHeaderSection(),
          const FranchiseOwnerBranchOverviewFilterBarSection(),
          const FranchiseOwnerBranchOverviewDataTableSection(),
          const FranchiseOwnerBranchOverviewPaginationSection(),
          const FranchiseOwnerBranchOverviewActionBarSection(),
        ],
      ),
    );
  }
}
