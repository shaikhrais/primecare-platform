import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_staff_files_header_section.dart';
import 'sections/hr_staff_files_content_summary_section.dart';
import 'sections/hr_staff_files_primary_content_section.dart';
import 'sections/hr_staff_files_action_bar_section.dart';

class HrStaffFilesScreen extends StatelessWidget {
  const HrStaffFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_staff_files',
      title: 'Hr Staff Files',
      child: Column(
        children: const [
          const HrStaffFilesHeaderSection(),
          const HrStaffFilesContentSummarySection(),
          const HrStaffFilesPrimaryContentSection(),
          const HrStaffFilesActionBarSection(),
        ],
      ),
    );
  }
}
