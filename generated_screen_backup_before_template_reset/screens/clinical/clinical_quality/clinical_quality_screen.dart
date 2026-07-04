import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_quality_header_section.dart';
import 'sections/clinical_quality_content_summary_section.dart';
import 'sections/clinical_quality_primary_content_section.dart';
import 'sections/clinical_quality_action_bar_section.dart';

class ClinicalQualityScreen extends StatelessWidget {
  const ClinicalQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_quality',
      title: 'ClinicalQualityScreen',
      child: Column(
        children: const [
          const ClinicalQualityHeaderSection(),
          const ClinicalQualityContentSummarySection(),
          const ClinicalQualityPrimaryContentSection(),
          const ClinicalQualityActionBarSection(),
        ],
      ),
    );
  }
}
