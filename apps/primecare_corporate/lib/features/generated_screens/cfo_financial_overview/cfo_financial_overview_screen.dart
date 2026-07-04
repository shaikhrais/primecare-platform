import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_financial_overview_header_section.dart';
import 'sections/cfo_financial_overview_filter_bar_section.dart';
import 'sections/cfo_financial_overview_data_table_section.dart';
import 'sections/cfo_financial_overview_pagination_section.dart';
import 'sections/cfo_financial_overview_action_bar_section.dart';

class CfoFinancialOverviewScreen extends StatelessWidget {
  const CfoFinancialOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_financial_overview',
      title: 'Cfo Financial Overview',
      child: Column(
        children: const [
          const CfoFinancialOverviewHeaderSection(),
          const CfoFinancialOverviewFilterBarSection(),
          const CfoFinancialOverviewDataTableSection(),
          const CfoFinancialOverviewPaginationSection(),
          const CfoFinancialOverviewActionBarSection(),
        ],
      ),
    );
  }
}
