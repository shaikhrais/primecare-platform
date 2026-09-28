import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_daily_notes_header_section.dart';
import 'sections/psw_daily_notes_client_context_section.dart';
import 'sections/psw_daily_notes_notes_form_section.dart';
import 'sections/psw_daily_notes_notes_history_section.dart';
import 'sections/psw_daily_notes_action_bar_section.dart';

class PswDailyNotesScreen extends StatelessWidget {
  const PswDailyNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_daily_notes',
      title: 'Psw Daily Notes',
      child: Column(
        children: const [
          const PswDailyNotesHeaderSection(),
          const PswDailyNotesClientContextSection(),
          const PswDailyNotesNotesFormSection(),
          const PswDailyNotesNotesHistorySection(),
          const PswDailyNotesActionBarSection(),
        ],
      ),
    );
  }
}
