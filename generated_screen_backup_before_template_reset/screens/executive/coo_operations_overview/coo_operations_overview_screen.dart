import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_operations_overview_header_section.dart';
import 'sections/coo_operations_overview_filter_bar_section.dart';
import 'sections/coo_operations_overview_data_table_section.dart';
import 'sections/coo_operations_overview_pagination_section.dart';
import 'sections/coo_operations_overview_action_bar_section.dart';

class CooOperationsOverviewScreen extends StatelessWidget {
  const CooOperationsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_operations_overview',
      title: 'CooOperationsOverviewScreen',
      child: Column(
        children: const [
          const CooOperationsOverviewHeaderSection(),
          const CooOperationsOverviewFilterBarSection(),
          const CooOperationsOverviewDataTableSection(),
          const CooOperationsOverviewPaginationSection(),
          const CooOperationsOverviewActionBarSection(),
        ],
      ),
    );
  }
}
