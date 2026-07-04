import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/medication_administration_header_section.dart';
import 'sections/medication_administration_content_summary_section.dart';
import 'sections/medication_administration_primary_content_section.dart';
import 'sections/medication_administration_action_bar_section.dart';

class MedicationAdministrationScreen extends StatelessWidget {
  const MedicationAdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'medication_administration',
      title: 'MedicationAdministrationScreen',
      child: Column(
        children: const [
          const MedicationAdministrationHeaderSection(),
          const MedicationAdministrationContentSummarySection(),
          const MedicationAdministrationPrimaryContentSection(),
          const MedicationAdministrationActionBarSection(),
        ],
      ),
    );
  }
}
