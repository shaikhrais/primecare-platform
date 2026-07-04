import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_patient_charting_header_section.dart';
import 'sections/rn_patient_charting_content_summary_section.dart';
import 'sections/rn_patient_charting_primary_content_section.dart';
import 'sections/rn_patient_charting_action_bar_section.dart';

class RnPatientChartingScreen extends StatelessWidget {
  const RnPatientChartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_patient_charting',
      title: 'RnPatientChartingScreen',
      child: Column(
        children: const [
          const RnPatientChartingHeaderSection(),
          const RnPatientChartingContentSummarySection(),
          const RnPatientChartingPrimaryContentSection(),
          const RnPatientChartingActionBarSection(),
        ],
      ),
    );
  }
}
