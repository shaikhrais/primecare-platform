import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_billing_header_section.dart';
import 'sections/family_member_billing_content_summary_section.dart';
import 'sections/family_member_billing_primary_content_section.dart';
import 'sections/family_member_billing_action_bar_section.dart';

class FamilyMemberBillingScreen extends StatelessWidget {
  const FamilyMemberBillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_billing',
      title: 'Family Member Billing',
      child: Column(
        children: const [
          const FamilyMemberBillingHeaderSection(),
          const FamilyMemberBillingContentSummarySection(),
          const FamilyMemberBillingPrimaryContentSection(),
          const FamilyMemberBillingActionBarSection(),
        ],
      ),
    );
  }
}
