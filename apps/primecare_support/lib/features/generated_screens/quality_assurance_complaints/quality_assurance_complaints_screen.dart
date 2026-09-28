import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_complaints_header_section.dart';
import 'sections/quality_assurance_complaints_content_summary_section.dart';
import 'sections/quality_assurance_complaints_primary_content_section.dart';
import 'sections/quality_assurance_complaints_action_bar_section.dart';

class QualityAssuranceComplaintsScreen extends StatelessWidget {
  const QualityAssuranceComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_complaints',
      title: 'Quality Assurance Complaints',
      child: Column(
        children: const [
          const QualityAssuranceComplaintsHeaderSection(),
          const QualityAssuranceComplaintsContentSummarySection(),
          const QualityAssuranceComplaintsPrimaryContentSection(),
          const QualityAssuranceComplaintsActionBarSection(),
        ],
      ),
    );
  }
}
