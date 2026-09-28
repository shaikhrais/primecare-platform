import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_outstanding_balances_header_section.dart';
import 'sections/admin_outstanding_balances_content_summary_section.dart';
import 'sections/admin_outstanding_balances_primary_content_section.dart';
import 'sections/admin_outstanding_balances_action_bar_section.dart';

class AdminOutstandingBalancesScreen extends StatelessWidget {
  const AdminOutstandingBalancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_outstanding_balances',
      title: 'Admin Outstanding Balances',
      child: Column(
        children: const [
          const AdminOutstandingBalancesHeaderSection(),
          const AdminOutstandingBalancesContentSummarySection(),
          const AdminOutstandingBalancesPrimaryContentSection(),
          const AdminOutstandingBalancesActionBarSection(),
        ],
      ),
    );
  }
}
