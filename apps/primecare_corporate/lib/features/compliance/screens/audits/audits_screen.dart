import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/audits_header_section.dart';
import 'sections/audits_content_summary_section.dart';
import 'sections/audits_primary_content_section.dart';
import 'sections/audits_action_bar_section.dart';

class AuditsScreen extends StatelessWidget {
  const AuditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'audits',
      title: 'Audits',
      child: Column(
        children: const [
          const AuditsHeaderSection(),
          const AuditsContentSummarySection(),
          const AuditsPrimaryContentSection(),
          const AuditsActionBarSection(),
        ],
      ),
    );
  }
}
