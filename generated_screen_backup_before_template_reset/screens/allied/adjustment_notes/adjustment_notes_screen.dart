import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/adjustment_notes_header_section.dart';
import 'sections/adjustment_notes_client_context_section.dart';
import 'sections/adjustment_notes_notes_form_section.dart';
import 'sections/adjustment_notes_notes_history_section.dart';
import 'sections/adjustment_notes_action_bar_section.dart';

class AdjustmentNotesScreen extends StatelessWidget {
  const AdjustmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'adjustment_notes',
      title: 'AdjustmentNotesScreen',
      child: Column(
        children: const [
          const AdjustmentNotesHeaderSection(),
          const AdjustmentNotesClientContextSection(),
          const AdjustmentNotesNotesFormSection(),
          const AdjustmentNotesNotesHistorySection(),
          const AdjustmentNotesActionBarSection(),
        ],
      ),
    );
  }
}
