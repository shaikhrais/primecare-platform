import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/security_audit_header_section.dart';
import 'sections/security_audit_content_summary_section.dart';
import 'sections/security_audit_primary_content_section.dart';
import 'sections/security_audit_action_bar_section.dart';

class SecurityAuditScreen extends StatelessWidget {
  const SecurityAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'security_audit',
      title: 'SecurityAuditScreen',
      child: Column(
        children: const [
          const SecurityAuditHeaderSection(),
          const SecurityAuditContentSummarySection(),
          const SecurityAuditPrimaryContentSection(),
          const SecurityAuditActionBarSection(),
        ],
      ),
    );
  }
}
