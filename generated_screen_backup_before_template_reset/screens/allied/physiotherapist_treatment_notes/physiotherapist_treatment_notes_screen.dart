import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_treatment_notes_header_section.dart';
import 'sections/physiotherapist_treatment_notes_client_context_section.dart';
import 'sections/physiotherapist_treatment_notes_notes_form_section.dart';
import 'sections/physiotherapist_treatment_notes_notes_history_section.dart';
import 'sections/physiotherapist_treatment_notes_action_bar_section.dart';

class PhysiotherapistTreatmentNotesScreen extends StatelessWidget {
  const PhysiotherapistTreatmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_treatment_notes',
      title: 'PhysiotherapistTreatmentNotesScreen',
      child: Column(
        children: const [
          const PhysiotherapistTreatmentNotesHeaderSection(),
          const PhysiotherapistTreatmentNotesClientContextSection(),
          const PhysiotherapistTreatmentNotesNotesFormSection(),
          const PhysiotherapistTreatmentNotesNotesHistorySection(),
          const PhysiotherapistTreatmentNotesActionBarSection(),
        ],
      ),
    );
  }
}
