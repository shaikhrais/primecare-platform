import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/staffing_overview_header_section.dart';
import 'sections/staffing_overview_filter_bar_section.dart';
import 'sections/staffing_overview_data_table_section.dart';
import 'sections/staffing_overview_pagination_section.dart';
import 'sections/staffing_overview_action_bar_section.dart';

class StaffingOverviewScreen extends StatelessWidget {
  const StaffingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'staffing_overview',
      title: 'StaffingOverviewScreen',
      child: Column(
        children: const [
          const StaffingOverviewHeaderSection(),
          const StaffingOverviewFilterBarSection(),
          const StaffingOverviewDataTableSection(),
          const StaffingOverviewPaginationSection(),
          const StaffingOverviewActionBarSection(),
        ],
      ),
    );
  }
}
