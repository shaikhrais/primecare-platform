import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_approvals_header_section.dart';
import 'sections/ceo_approvals_content_summary_section.dart';
import 'sections/ceo_approvals_primary_content_section.dart';
import 'sections/ceo_approvals_action_bar_section.dart';

class CeoApprovalsScreen extends StatelessWidget {
  const CeoApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_approvals',
      title: 'Ceo Approvals',
      child: Column(
        children: const [
          const CeoApprovalsHeaderSection(),
          const CeoApprovalsContentSummarySection(),
          const CeoApprovalsPrimaryContentSection(),
          const CeoApprovalsActionBarSection(),
        ],
      ),
    );
  }
}
