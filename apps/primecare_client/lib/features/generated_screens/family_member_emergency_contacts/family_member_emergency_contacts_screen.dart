import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_emergency_contacts_header_section.dart';
import 'sections/family_member_emergency_contacts_content_summary_section.dart';
import 'sections/family_member_emergency_contacts_primary_content_section.dart';
import 'sections/family_member_emergency_contacts_action_bar_section.dart';

class FamilyMemberEmergencyContactsScreen extends StatelessWidget {
  const FamilyMemberEmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_emergency_contacts',
      title: 'Family Member Emergency Contacts',
      child: Column(
        children: const [
          const FamilyMemberEmergencyContactsHeaderSection(),
          const FamilyMemberEmergencyContactsContentSummarySection(),
          const FamilyMemberEmergencyContactsPrimaryContentSection(),
          const FamilyMemberEmergencyContactsActionBarSection(),
        ],
      ),
    );
  }
}
