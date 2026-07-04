import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_claims_header_section.dart';
import 'sections/billing_claims_content_summary_section.dart';
import 'sections/billing_claims_primary_content_section.dart';
import 'sections/billing_claims_action_bar_section.dart';

class BillingClaimsScreen extends StatelessWidget {
  const BillingClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_claims',
      title: 'Billing Claims',
      child: Column(
        children: const [
          const BillingClaimsHeaderSection(),
          const BillingClaimsContentSummarySection(),
          const BillingClaimsPrimaryContentSection(),
          const BillingClaimsActionBarSection(),
        ],
      ),
    );
  }
}
