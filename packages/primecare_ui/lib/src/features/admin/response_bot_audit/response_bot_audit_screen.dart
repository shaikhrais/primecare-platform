import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/response_bot_audit_header_section.dart';
import 'sections/response_bot_audit_content_summary_section.dart';
import 'sections/response_bot_audit_primary_content_section.dart';
import 'sections/response_bot_audit_action_bar_section.dart';

class ResponseBotAuditScreen extends StatelessWidget {
  const ResponseBotAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'response_bot_audit',
      title: 'Response Bot Audit',
      child: Column(
        children: const [
          const ResponseBotAuditHeaderSection(),
          const ResponseBotAuditContentSummarySection(),
          const ResponseBotAuditPrimaryContentSection(),
          const ResponseBotAuditActionBarSection(),
        ],
      ),
    );
  }
}
