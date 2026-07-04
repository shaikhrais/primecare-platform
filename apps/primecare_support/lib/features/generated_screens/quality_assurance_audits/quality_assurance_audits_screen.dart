import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_audits_header_section.dart';
import 'sections/quality_assurance_audits_content_summary_section.dart';
import 'sections/quality_assurance_audits_primary_content_section.dart';
import 'sections/quality_assurance_audits_action_bar_section.dart';

class QualityAssuranceAuditsScreen extends StatelessWidget {
  const QualityAssuranceAuditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_audits',
      title: 'Quality Assurance Audits',
      child: Column(
        children: const [
          const QualityAssuranceAuditsHeaderSection(),
          const QualityAssuranceAuditsContentSummarySection(),
          const QualityAssuranceAuditsPrimaryContentSection(),
          const QualityAssuranceAuditsActionBarSection(),
        ],
      ),
    );
  }
}
