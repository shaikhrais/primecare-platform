import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_franchise_overview_header_section.dart';
import 'sections/ceo_franchise_overview_filter_bar_section.dart';
import 'sections/ceo_franchise_overview_data_table_section.dart';
import 'sections/ceo_franchise_overview_pagination_section.dart';
import 'sections/ceo_franchise_overview_action_bar_section.dart';

class CeoFranchiseOverviewScreen extends StatelessWidget {
  const CeoFranchiseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_franchise_overview',
      title: 'Ceo Franchise Overview',
      child: Column(
        children: const [
          const CeoFranchiseOverviewHeaderSection(),
          const CeoFranchiseOverviewFilterBarSection(),
          const CeoFranchiseOverviewDataTableSection(),
          const CeoFranchiseOverviewPaginationSection(),
          const CeoFranchiseOverviewActionBarSection(),
        ],
      ),
    );
  }
}
