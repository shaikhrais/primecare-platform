import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_payments_header_section.dart';
import 'sections/admin_payments_content_summary_section.dart';
import 'sections/admin_payments_primary_content_section.dart';
import 'sections/admin_payments_action_bar_section.dart';

class AdminPaymentsScreen extends StatelessWidget {
  const AdminPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_payments',
      title: 'Admin Payments',
      child: Column(
        children: const [
          const AdminPaymentsHeaderSection(),
          const AdminPaymentsContentSummarySection(),
          const AdminPaymentsPrimaryContentSection(),
          const AdminPaymentsActionBarSection(),
        ],
      ),
    );
  }
}
