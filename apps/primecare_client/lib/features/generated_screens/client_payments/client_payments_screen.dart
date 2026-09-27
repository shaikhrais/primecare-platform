import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_payments_header_section.dart';
import 'sections/client_payments_content_summary_section.dart';
import 'sections/client_payments_primary_content_section.dart';
import 'sections/client_payments_action_bar_section.dart';

class ClientPaymentsScreen extends StatelessWidget {
  const ClientPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_payments',
      title: 'Client Payments',
      child: Column(
        children: const [
          const ClientPaymentsHeaderSection(),
          const ClientPaymentsContentSummarySection(),
          const ClientPaymentsPrimaryContentSection(),
          const ClientPaymentsActionBarSection(),
        ],
      ),
    );
  }
}
