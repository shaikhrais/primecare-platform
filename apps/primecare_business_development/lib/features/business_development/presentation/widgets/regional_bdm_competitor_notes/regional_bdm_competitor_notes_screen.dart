import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_competitor_notes_header_section.dart';
import 'sections/regional_bdm_competitor_notes_client_context_section.dart';
import 'sections/regional_bdm_competitor_notes_notes_form_section.dart';
import 'sections/regional_bdm_competitor_notes_notes_history_section.dart';
import 'sections/regional_bdm_competitor_notes_action_bar_section.dart';

class RegionalBdmCompetitorNotesScreen extends StatelessWidget {
  const RegionalBdmCompetitorNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_competitor_notes',
      title: 'Regional Bdm Competitor Notes',
      child: Column(
        children: const [
          const RegionalBdmCompetitorNotesHeaderSection(),
          const RegionalBdmCompetitorNotesClientContextSection(),
          const RegionalBdmCompetitorNotesNotesFormSection(),
          const RegionalBdmCompetitorNotesNotesHistorySection(),
          const RegionalBdmCompetitorNotesActionBarSection(),
        ],
      ),
    );
  }
}
