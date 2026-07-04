import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_overview_header_section.dart';
import 'sections/franchise_overview_filter_bar_section.dart';
import 'sections/franchise_overview_data_table_section.dart';
import 'sections/franchise_overview_pagination_section.dart';
import 'sections/franchise_overview_action_bar_section.dart';

class FranchiseOverviewScreen extends StatelessWidget {
  const FranchiseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_overview',
      title: 'FranchiseOverviewScreen',
      child: Column(
        children: const [
          const FranchiseOverviewHeaderSection(),
          const FranchiseOverviewFilterBarSection(),
          const FranchiseOverviewDataTableSection(),
          const FranchiseOverviewPaginationSection(),
          const FranchiseOverviewActionBarSection(),
        ],
      ),
    );
  }
}
