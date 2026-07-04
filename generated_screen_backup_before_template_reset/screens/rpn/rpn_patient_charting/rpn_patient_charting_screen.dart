import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_patient_charting_header_section.dart';
import 'sections/rpn_patient_charting_content_summary_section.dart';
import 'sections/rpn_patient_charting_primary_content_section.dart';
import 'sections/rpn_patient_charting_action_bar_section.dart';

class RpnPatientChartingScreen extends StatelessWidget {
  const RpnPatientChartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_patient_charting',
      title: 'RpnPatientChartingScreen',
      child: Column(
        children: const [
          const RpnPatientChartingHeaderSection(),
          const RpnPatientChartingContentSummarySection(),
          const RpnPatientChartingPrimaryContentSection(),
          const RpnPatientChartingActionBarSection(),
        ],
      ),
    );
  }
}
