import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/staff_management_header_section.dart';
import 'sections/staff_management_content_summary_section.dart';
import 'sections/staff_management_primary_content_section.dart';
import 'sections/staff_management_action_bar_section.dart';

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'staff_management',
      title: 'StaffManagementScreen',
      child: Column(
        children: const [
          const StaffManagementHeaderSection(),
          const StaffManagementContentSummarySection(),
          const StaffManagementPrimaryContentSection(),
          const StaffManagementActionBarSection(),
        ],
      ),
    );
  }
}
