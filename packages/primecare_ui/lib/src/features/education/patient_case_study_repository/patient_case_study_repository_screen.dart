import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_case_study_repository_header_section.dart';
import 'sections/patient_case_study_repository_content_summary_section.dart';
import 'sections/patient_case_study_repository_primary_content_section.dart';
import 'sections/patient_case_study_repository_action_bar_section.dart';

class PatientCaseStudyRepositoryScreen extends StatelessWidget {
  const PatientCaseStudyRepositoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_case_study_repository',
      title: 'Patient Case Study Repository',
      child: Column(
        children: const [
          const PatientCaseStudyRepositoryHeaderSection(),
          const PatientCaseStudyRepositoryContentSummarySection(),
          const PatientCaseStudyRepositoryPrimaryContentSection(),
          const PatientCaseStudyRepositoryActionBarSection(),
        ],
      ),
    );
  }
}
