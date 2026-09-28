import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_reconciliation_header_section.dart';
import 'sections/admin_reconciliation_content_summary_section.dart';
import 'sections/admin_reconciliation_primary_content_section.dart';
import 'sections/admin_reconciliation_action_bar_section.dart';

class AdminReconciliationScreen extends StatelessWidget {
  const AdminReconciliationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_reconciliation',
      title: 'Admin Reconciliation',
      child: Column(
        children: const [
          const AdminReconciliationHeaderSection(),
          const AdminReconciliationContentSummarySection(),
          const AdminReconciliationPrimaryContentSection(),
          const AdminReconciliationActionBarSection(),
        ],
      ),
    );
  }
}
