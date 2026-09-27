import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/staff_progress_header_section.dart';
import 'sections/staff_progress_content_summary_section.dart';
import 'sections/staff_progress_primary_content_section.dart';
import 'sections/staff_progress_action_bar_section.dart';

class StaffProgressScreen extends StatelessWidget {
  const StaffProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'staff_progress',
      title: 'StaffProgressScreen',
      child: Column(
        children: const [
          const StaffProgressHeaderSection(),
          const StaffProgressContentSummarySection(),
          const StaffProgressPrimaryContentSection(),
          const StaffProgressActionBarSection(),
        ],
      ),
    );
  }
}
