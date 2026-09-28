import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_billing_header_section.dart';
import 'sections/family_billing_content_summary_section.dart';
import 'sections/family_billing_primary_content_section.dart';
import 'sections/family_billing_action_bar_section.dart';

class FamilyBillingScreen extends StatelessWidget {
  const FamilyBillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_billing',
      title: 'Family Billing',
      child: Column(
        children: const [
          const FamilyBillingHeaderSection(),
          const FamilyBillingContentSummarySection(),
          const FamilyBillingPrimaryContentSection(),
          const FamilyBillingActionBarSection(),
        ],
      ),
    );
  }
}
