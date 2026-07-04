import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_staff_files_header_section.dart';
import 'sections/hr_director_staff_files_content_summary_section.dart';
import 'sections/hr_director_staff_files_primary_content_section.dart';
import 'sections/hr_director_staff_files_action_bar_section.dart';

class HrDirectorStaffFilesScreen extends StatelessWidget {
  const HrDirectorStaffFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_staff_files',
      title: 'HrDirectorStaffFilesScreen',
      child: Column(
        children: const [
          const HrDirectorStaffFilesHeaderSection(),
          const HrDirectorStaffFilesContentSummarySection(),
          const HrDirectorStaffFilesPrimaryContentSection(),
          const HrDirectorStaffFilesActionBarSection(),
        ],
      ),
    );
  }
}
