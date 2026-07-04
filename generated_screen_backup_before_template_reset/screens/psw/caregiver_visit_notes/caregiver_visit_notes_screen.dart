import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/caregiver_visit_notes_header_section.dart';
import 'sections/caregiver_visit_notes_client_context_section.dart';
import 'sections/caregiver_visit_notes_notes_form_section.dart';
import 'sections/caregiver_visit_notes_notes_history_section.dart';
import 'sections/caregiver_visit_notes_action_bar_section.dart';

class CaregiverVisitNotesScreen extends StatelessWidget {
  const CaregiverVisitNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'caregiver_visit_notes',
      title: 'CaregiverVisitNotesScreen',
      child: Column(
        children: const [
          const CaregiverVisitNotesHeaderSection(),
          const CaregiverVisitNotesClientContextSection(),
          const CaregiverVisitNotesNotesFormSection(),
          const CaregiverVisitNotesNotesHistorySection(),
          const CaregiverVisitNotesActionBarSection(),
        ],
      ),
    );
  }
}
