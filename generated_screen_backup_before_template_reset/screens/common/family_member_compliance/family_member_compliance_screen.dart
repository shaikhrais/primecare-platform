import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_compliance_header_section.dart';
import 'sections/family_member_compliance_content_summary_section.dart';
import 'sections/family_member_compliance_primary_content_section.dart';
import 'sections/family_member_compliance_action_bar_section.dart';

class FamilyMemberComplianceScreen extends StatelessWidget {
  const FamilyMemberComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_compliance',
      title: 'FamilyMemberComplianceScreen',
      child: Column(
        children: const [
          const FamilyMemberComplianceHeaderSection(),
          const FamilyMemberComplianceContentSummarySection(),
          const FamilyMemberCompliancePrimaryContentSection(),
          const FamilyMemberComplianceActionBarSection(),
        ],
      ),
    );
  }
}
