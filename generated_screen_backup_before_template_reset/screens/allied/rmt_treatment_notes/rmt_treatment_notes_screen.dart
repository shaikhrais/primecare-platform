import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_treatment_notes_header_section.dart';
import 'sections/rmt_treatment_notes_client_context_section.dart';
import 'sections/rmt_treatment_notes_notes_form_section.dart';
import 'sections/rmt_treatment_notes_notes_history_section.dart';
import 'sections/rmt_treatment_notes_action_bar_section.dart';

class RmtTreatmentNotesScreen extends StatelessWidget {
  const RmtTreatmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_treatment_notes',
      title: 'RmtTreatmentNotesScreen',
      child: Column(
        children: const [
          const RmtTreatmentNotesHeaderSection(),
          const RmtTreatmentNotesClientContextSection(),
          const RmtTreatmentNotesNotesFormSection(),
          const RmtTreatmentNotesNotesHistorySection(),
          const RmtTreatmentNotesActionBarSection(),
        ],
      ),
    );
  }
}
