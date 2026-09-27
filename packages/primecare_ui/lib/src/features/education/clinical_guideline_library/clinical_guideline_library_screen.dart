import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_guideline_library_header_section.dart';
import 'sections/clinical_guideline_library_content_summary_section.dart';
import 'sections/clinical_guideline_library_primary_content_section.dart';
import 'sections/clinical_guideline_library_action_bar_section.dart';

class ClinicalGuidelineLibraryScreen extends StatelessWidget {
  const ClinicalGuidelineLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_guideline_library',
      title: 'Clinical Guideline Library',
      child: Column(
        children: const [
          const ClinicalGuidelineLibraryHeaderSection(),
          const ClinicalGuidelineLibraryContentSummarySection(),
          const ClinicalGuidelineLibraryPrimaryContentSection(),
          const ClinicalGuidelineLibraryActionBarSection(),
        ],
      ),
    );
  }
}
