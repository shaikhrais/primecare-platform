import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/audit_header_section.dart';
import 'sections/audit_content_summary_section.dart';
import 'sections/audit_primary_content_section.dart';
import 'sections/audit_action_bar_section.dart';

class AuditScreen extends StatelessWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'audit',
      title: 'ScreenAuditScreen',
      child: Column(
        children: const [
          const AuditHeaderSection(),
          const AuditContentSummarySection(),
          const AuditPrimaryContentSection(),
          const AuditActionBarSection(),
        ],
      ),
    );
  }
}

typedef ScreenAuditScreen = AuditScreen;
