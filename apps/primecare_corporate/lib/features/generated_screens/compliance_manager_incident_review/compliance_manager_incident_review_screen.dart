import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_incident_review_header_section.dart';
import 'sections/compliance_manager_incident_review_filter_bar_section.dart';
import 'sections/compliance_manager_incident_review_data_table_section.dart';
import 'sections/compliance_manager_incident_review_pagination_section.dart';
import 'sections/compliance_manager_incident_review_action_bar_section.dart';

class ComplianceManagerIncidentReviewScreen extends StatelessWidget {
  const ComplianceManagerIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_incident_review',
      title: 'Compliance Manager Incident Review',
      child: Column(
        children: const [
          const ComplianceManagerIncidentReviewHeaderSection(),
          const ComplianceManagerIncidentReviewFilterBarSection(),
          const ComplianceManagerIncidentReviewDataTableSection(),
          const ComplianceManagerIncidentReviewPaginationSection(),
          const ComplianceManagerIncidentReviewActionBarSection(),
        ],
      ),
    );
  }
}
