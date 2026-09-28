import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_staffing_efficiency_header_section.dart';
import 'sections/coo_staffing_efficiency_content_summary_section.dart';
import 'sections/coo_staffing_efficiency_primary_content_section.dart';
import 'sections/coo_staffing_efficiency_action_bar_section.dart';

class CooStaffingEfficiencyScreen extends StatelessWidget {
  const CooStaffingEfficiencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_staffing_efficiency',
      title: 'Coo Staffing Efficiency',
      child: Column(
        children: const [
          const CooStaffingEfficiencyHeaderSection(),
          const CooStaffingEfficiencyContentSummarySection(),
          const CooStaffingEfficiencyPrimaryContentSection(),
          const CooStaffingEfficiencyActionBarSection(),
        ],
      ),
    );
  }
}
