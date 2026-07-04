import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_staff_quality_header_section.dart';
import 'sections/clinical_director_staff_quality_content_summary_section.dart';
import 'sections/clinical_director_staff_quality_primary_content_section.dart';
import 'sections/clinical_director_staff_quality_action_bar_section.dart';

class ClinicalDirectorStaffQualityScreen extends StatelessWidget {
  const ClinicalDirectorStaffQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_staff_quality',
      title: 'ClinicalDirectorStaffQualityScreen',
      child: Column(
        children: const [
          const ClinicalDirectorStaffQualityHeaderSection(),
          const ClinicalDirectorStaffQualityContentSummarySection(),
          const ClinicalDirectorStaffQualityPrimaryContentSection(),
          const ClinicalDirectorStaffQualityActionBarSection(),
        ],
      ),
    );
  }
}
