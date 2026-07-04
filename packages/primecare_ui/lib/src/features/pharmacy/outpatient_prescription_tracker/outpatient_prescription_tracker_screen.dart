import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/outpatient_prescription_tracker_header_section.dart';
import 'sections/outpatient_prescription_tracker_content_summary_section.dart';
import 'sections/outpatient_prescription_tracker_primary_content_section.dart';
import 'sections/outpatient_prescription_tracker_action_bar_section.dart';

class OutpatientPrescriptionTrackerScreen extends StatelessWidget {
  const OutpatientPrescriptionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'outpatient_prescription_tracker',
      title: 'Outpatient Prescription Tracker',
      child: Column(
        children: const [
          const OutpatientPrescriptionTrackerHeaderSection(),
          const OutpatientPrescriptionTrackerContentSummarySection(),
          const OutpatientPrescriptionTrackerPrimaryContentSection(),
          const OutpatientPrescriptionTrackerActionBarSection(),
        ],
      ),
    );
  }
}
