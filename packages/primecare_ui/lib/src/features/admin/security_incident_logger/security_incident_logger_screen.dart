import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/security_incident_logger_header_section.dart';
import 'sections/security_incident_logger_filter_bar_section.dart';
import 'sections/security_incident_logger_data_table_section.dart';
import 'sections/security_incident_logger_pagination_section.dart';
import 'sections/security_incident_logger_action_bar_section.dart';

class SecurityIncidentLoggerScreen extends StatelessWidget {
  const SecurityIncidentLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'security_incident_logger',
      title: 'Security Incident Logger',
      child: Column(
        children: const [
          const SecurityIncidentLoggerHeaderSection(),
          const SecurityIncidentLoggerFilterBarSection(),
          const SecurityIncidentLoggerDataTableSection(),
          const SecurityIncidentLoggerPaginationSection(),
          const SecurityIncidentLoggerActionBarSection(),
        ],
      ),
    );
  }
}
