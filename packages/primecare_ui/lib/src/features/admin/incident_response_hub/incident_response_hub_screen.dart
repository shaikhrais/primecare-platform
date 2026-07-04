import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/incident_response_hub_header_section.dart';
import 'sections/incident_response_hub_content_summary_section.dart';
import 'sections/incident_response_hub_primary_content_section.dart';
import 'sections/incident_response_hub_action_bar_section.dart';

class IncidentResponseHubScreen extends StatelessWidget {
  const IncidentResponseHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'incident_response_hub',
      title: 'Incident Response Hub',
      child: Column(
        children: const [
          const IncidentResponseHubHeaderSection(),
          const IncidentResponseHubContentSummarySection(),
          const IncidentResponseHubPrimaryContentSection(),
          const IncidentResponseHubActionBarSection(),
        ],
      ),
    );
  }
}
