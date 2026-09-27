import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_staff_documents_header_section.dart';
import 'sections/hr_hiring_staff_documents_content_summary_section.dart';
import 'sections/hr_hiring_staff_documents_primary_content_section.dart';
import 'sections/hr_hiring_staff_documents_action_bar_section.dart';

class HrHiringStaffDocumentsScreen extends StatelessWidget {
  const HrHiringStaffDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_staff_documents',
      title: 'Hr Hiring Staff Documents',
      child: Column(
        children: const [
          const HrHiringStaffDocumentsHeaderSection(),
          const HrHiringStaffDocumentsContentSummarySection(),
          const HrHiringStaffDocumentsPrimaryContentSection(),
          const HrHiringStaffDocumentsActionBarSection(),
        ],
      ),
    );
  }
}
