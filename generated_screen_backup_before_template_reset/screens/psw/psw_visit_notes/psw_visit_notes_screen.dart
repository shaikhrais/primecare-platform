import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_visit_notes_header_section.dart';
import 'sections/psw_visit_notes_client_context_section.dart';
import 'sections/psw_visit_notes_notes_form_section.dart';
import 'sections/psw_visit_notes_notes_history_section.dart';
import 'sections/psw_visit_notes_action_bar_section.dart';

class PswVisitNotesScreen extends StatelessWidget {
  const PswVisitNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_visit_notes',
      title: 'Visit Notes',
      child: Column(
        children: const [
          const PswVisitNotesHeaderSection(),
          const PswVisitNotesClientContextSection(),
          const PswVisitNotesNotesFormSection(),
          const PswVisitNotesNotesHistorySection(),
          const PswVisitNotesActionBarSection(),
        ],
      ),
    );
  }
}
