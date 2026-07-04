import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/invoice_management_header_section.dart';
import 'sections/invoice_management_content_summary_section.dart';
import 'sections/invoice_management_primary_content_section.dart';
import 'sections/invoice_management_action_bar_section.dart';

class InvoiceManagementScreen extends StatelessWidget {
  const InvoiceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'invoice_management',
      title: 'InvoiceManagementScreen',
      child: Column(
        children: const [
          const InvoiceManagementHeaderSection(),
          const InvoiceManagementContentSummarySection(),
          const InvoiceManagementPrimaryContentSection(),
          const InvoiceManagementActionBarSection(),
        ],
      ),
    );
  }
}
