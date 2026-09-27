import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_reference_header_section.dart';
import 'sections/clinical_reference_content_summary_section.dart';
import 'sections/clinical_reference_primary_content_section.dart';
import 'sections/clinical_reference_action_bar_section.dart';

class ClinicalReferenceScreen extends StatelessWidget {
  const ClinicalReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_reference',
      title: 'Clinical Reference',
      child: Column(
        children: const [
          const ClinicalReferenceHeaderSection(),
          const ClinicalReferenceContentSummarySection(),
          const ClinicalReferencePrimaryContentSection(),
          const ClinicalReferenceActionBarSection(),
        ],
      ),
    );
  }
}
