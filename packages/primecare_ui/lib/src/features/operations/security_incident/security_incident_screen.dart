import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/security_incident_header_section.dart';
import 'sections/security_incident_content_summary_section.dart';
import 'sections/security_incident_primary_content_section.dart';
import 'sections/security_incident_action_bar_section.dart';

class SecurityIncidentScreen extends StatelessWidget {
  const SecurityIncidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'security_incident',
      title: 'Security Incident',
      child: Column(
        children: const [
          const SecurityIncidentHeaderSection(),
          const SecurityIncidentContentSummarySection(),
          const SecurityIncidentPrimaryContentSection(),
          const SecurityIncidentActionBarSection(),
        ],
      ),
    );
  }
}
