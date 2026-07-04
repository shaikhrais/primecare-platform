import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_staffing_header_section.dart';
import 'sections/coo_staffing_content_summary_section.dart';
import 'sections/coo_staffing_primary_content_section.dart';
import 'sections/coo_staffing_action_bar_section.dart';

class CooStaffingScreen extends StatelessWidget {
  const CooStaffingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_staffing',
      title: 'CooStaffingScreen',
      child: Column(
        children: const [
          const CooStaffingHeaderSection(),
          const CooStaffingContentSummarySection(),
          const CooStaffingPrimaryContentSection(),
          const CooStaffingActionBarSection(),
        ],
      ),
    );
  }
}
