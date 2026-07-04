import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_payments_header_section.dart';
import 'sections/billing_payments_content_summary_section.dart';
import 'sections/billing_payments_primary_content_section.dart';
import 'sections/billing_payments_action_bar_section.dart';

class BillingPaymentsScreen extends StatelessWidget {
  const BillingPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_payments',
      title: 'Billing Payments',
      child: Column(
        children: const [
          const BillingPaymentsHeaderSection(),
          const BillingPaymentsContentSummarySection(),
          const BillingPaymentsPrimaryContentSection(),
          const BillingPaymentsActionBarSection(),
        ],
      ),
    );
  }
}
