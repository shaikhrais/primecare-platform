import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_treatment_notes_header_section.dart';
import 'sections/chiropractor_treatment_notes_client_context_section.dart';
import 'sections/chiropractor_treatment_notes_notes_form_section.dart';
import 'sections/chiropractor_treatment_notes_notes_history_section.dart';
import 'sections/chiropractor_treatment_notes_action_bar_section.dart';

class ChiropractorTreatmentNotesScreen extends StatelessWidget {
  const ChiropractorTreatmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_treatment_notes',
      title: 'ChiropractorTreatmentNotesScreen',
      child: Column(
        children: const [
          const ChiropractorTreatmentNotesHeaderSection(),
          const ChiropractorTreatmentNotesClientContextSection(),
          const ChiropractorTreatmentNotesNotesFormSection(),
          const ChiropractorTreatmentNotesNotesHistorySection(),
          const ChiropractorTreatmentNotesActionBarSection(),
        ],
      ),
    );
  }
}
