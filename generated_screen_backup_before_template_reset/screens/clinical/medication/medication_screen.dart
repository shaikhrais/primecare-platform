import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/medication_header_section.dart';
import 'sections/medication_content_summary_section.dart';
import 'sections/medication_primary_content_section.dart';
import 'sections/medication_action_bar_section.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'medication',
      title: 'MedicationScreen',
      child: Column(
        children: const [
          const MedicationHeaderSection(),
          const MedicationContentSummarySection(),
          const MedicationPrimaryContentSection(),
          const MedicationActionBarSection(),
        ],
      ),
    );
  }
}
