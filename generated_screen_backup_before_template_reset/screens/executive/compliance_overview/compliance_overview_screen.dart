import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_overview_header_section.dart';
import 'sections/compliance_overview_filter_bar_section.dart';
import 'sections/compliance_overview_data_table_section.dart';
import 'sections/compliance_overview_pagination_section.dart';
import 'sections/compliance_overview_action_bar_section.dart';

class ComplianceOverviewScreen extends StatelessWidget {
  const ComplianceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_overview',
      title: 'ComplianceOverviewScreen',
      child: Column(
        children: const [
          const ComplianceOverviewHeaderSection(),
          const ComplianceOverviewFilterBarSection(),
          const ComplianceOverviewDataTableSection(),
          const ComplianceOverviewPaginationSection(),
          const ComplianceOverviewActionBarSection(),
        ],
      ),
    );
  }
}
