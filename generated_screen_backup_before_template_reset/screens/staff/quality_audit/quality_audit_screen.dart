import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_audit_header_section.dart';
import 'sections/quality_audit_content_summary_section.dart';
import 'sections/quality_audit_primary_content_section.dart';
import 'sections/quality_audit_action_bar_section.dart';

class QualityAuditScreen extends StatelessWidget {
  const QualityAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_audit',
      title: 'QualityAuditScreen',
      child: Column(
        children: const [
          const QualityAuditHeaderSection(),
          const QualityAuditContentSummarySection(),
          const QualityAuditPrimaryContentSection(),
          const QualityAuditActionBarSection(),
        ],
      ),
    );
  }
}
