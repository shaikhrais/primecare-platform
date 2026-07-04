import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_approvals_header_section.dart';
import 'sections/clinical_director_approvals_content_summary_section.dart';
import 'sections/clinical_director_approvals_primary_content_section.dart';
import 'sections/clinical_director_approvals_action_bar_section.dart';

class ClinicalDirectorApprovalsScreen extends StatelessWidget {
  const ClinicalDirectorApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_approvals',
      title: 'ClinicalDirectorApprovalsScreen',
      child: Column(
        children: const [
          const ClinicalDirectorApprovalsHeaderSection(),
          const ClinicalDirectorApprovalsContentSummarySection(),
          const ClinicalDirectorApprovalsPrimaryContentSection(),
          const ClinicalDirectorApprovalsActionBarSection(),
        ],
      ),
    );
  }
}
