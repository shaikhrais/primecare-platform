import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/incident_oversight_header_section.dart';
import 'sections/incident_oversight_content_summary_section.dart';
import 'sections/incident_oversight_primary_content_section.dart';
import 'sections/incident_oversight_action_bar_section.dart';

class IncidentOversightScreen extends StatelessWidget {
  const IncidentOversightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'incident_oversight',
      title: 'IncidentOversightScreen',
      child: Column(
        children: const [
          const IncidentOversightHeaderSection(),
          const IncidentOversightContentSummarySection(),
          const IncidentOversightPrimaryContentSection(),
          const IncidentOversightActionBarSection(),
        ],
      ),
    );
  }
}
