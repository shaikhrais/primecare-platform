import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_invoices_header_section.dart';
import 'sections/admin_invoices_content_summary_section.dart';
import 'sections/admin_invoices_primary_content_section.dart';
import 'sections/admin_invoices_action_bar_section.dart';

class AdminInvoicesScreen extends StatelessWidget {
  const AdminInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_invoices',
      title: 'Admin Invoices',
      child: Column(
        children: const [
          const AdminInvoicesHeaderSection(),
          const AdminInvoicesContentSummarySection(),
          const AdminInvoicesPrimaryContentSection(),
          const AdminInvoicesActionBarSection(),
        ],
      ),
    );
  }
}
