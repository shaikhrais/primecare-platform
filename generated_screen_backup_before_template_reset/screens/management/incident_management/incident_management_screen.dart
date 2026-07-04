import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/incident_management_header_section.dart';
import 'sections/incident_management_content_summary_section.dart';
import 'sections/incident_management_primary_content_section.dart';
import 'sections/incident_management_action_bar_section.dart';

class IncidentManagementScreen extends StatelessWidget {
  const IncidentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'incident_management',
      title: 'IncidentManagementScreen',
      child: Column(
        children: const [
          const IncidentManagementHeaderSection(),
          const IncidentManagementContentSummarySection(),
          const IncidentManagementPrimaryContentSection(),
          const IncidentManagementActionBarSection(),
        ],
      ),
    );
  }
}
