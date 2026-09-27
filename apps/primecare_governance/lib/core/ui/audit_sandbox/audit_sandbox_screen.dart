import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/audit_sandbox_header_section.dart';
import 'sections/audit_sandbox_content_summary_section.dart';
import 'sections/audit_sandbox_primary_content_section.dart';
import 'sections/audit_sandbox_action_bar_section.dart';

class AuditSandboxScreen extends StatelessWidget {
  const AuditSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'audit_sandbox',
      title: 'Audit Sandbox',
      child: Column(
        children: const [
          const AuditSandboxHeaderSection(),
          const AuditSandboxContentSummarySection(),
          const AuditSandboxPrimaryContentSection(),
          const AuditSandboxActionBarSection(),
        ],
      ),
    );
  }
}
