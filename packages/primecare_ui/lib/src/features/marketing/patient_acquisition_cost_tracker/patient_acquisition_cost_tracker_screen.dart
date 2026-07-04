import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_acquisition_cost_tracker_header_section.dart';
import 'sections/patient_acquisition_cost_tracker_content_summary_section.dart';
import 'sections/patient_acquisition_cost_tracker_primary_content_section.dart';
import 'sections/patient_acquisition_cost_tracker_action_bar_section.dart';

class PatientAcquisitionCostTrackerScreen extends StatelessWidget {
  const PatientAcquisitionCostTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_acquisition_cost_tracker',
      title: 'Patient Acquisition Cost Tracker',
      child: Column(
        children: const [
          const PatientAcquisitionCostTrackerHeaderSection(),
          const PatientAcquisitionCostTrackerContentSummarySection(),
          const PatientAcquisitionCostTrackerPrimaryContentSection(),
          const PatientAcquisitionCostTrackerActionBarSection(),
        ],
      ),
    );
  }
}
