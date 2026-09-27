import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_admin_invoices_header_section.dart';
import 'sections/billing_admin_invoices_content_summary_section.dart';
import 'sections/billing_admin_invoices_primary_content_section.dart';
import 'sections/billing_admin_invoices_action_bar_section.dart';

class BillingAdminInvoicesScreen extends StatelessWidget {
  const BillingAdminInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_admin_invoices',
      title: 'Billing Admin Invoices',
      child: Column(
        children: const [
          const BillingAdminInvoicesHeaderSection(),
          const BillingAdminInvoicesContentSummarySection(),
          const BillingAdminInvoicesPrimaryContentSection(),
          const BillingAdminInvoicesActionBarSection(),
        ],
      ),
    );
  }
}
