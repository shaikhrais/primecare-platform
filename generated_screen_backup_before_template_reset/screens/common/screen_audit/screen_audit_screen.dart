import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/screen_audit_header_section.dart';
import 'sections/screen_audit_content_summary_section.dart';
import 'sections/screen_audit_primary_content_section.dart';
import 'sections/screen_audit_action_bar_section.dart';

class ScreenAuditScreen extends StatelessWidget {
  const ScreenAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'screen_audit',
      title: 'Screen Audit',
      child: Column(
        children: const [
          const ScreenAuditHeaderSection(),
          const ScreenAuditContentSummarySection(),
          const ScreenAuditPrimaryContentSection(),
          const ScreenAuditActionBarSection(),
        ],
      ),
    );
  }
}
