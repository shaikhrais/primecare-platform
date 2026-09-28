import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_profile_header_section.dart';
import 'sections/family_member_profile_identity_summary_section.dart';
import 'sections/family_member_profile_details_form_section.dart';
import 'sections/family_member_profile_preferences_or_documents_section.dart';
import 'sections/family_member_profile_action_bar_section.dart';

class FamilyMemberProfileScreen extends StatelessWidget {
  const FamilyMemberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_profile',
      title: 'Family Member Profile',
      child: Column(
        children: const [
          const FamilyMemberProfileHeaderSection(),
          const FamilyMemberProfileIdentitySummarySection(),
          const FamilyMemberProfileDetailsFormSection(),
          const FamilyMemberProfilePreferencesOrDocumentsSection(),
          const FamilyMemberProfileActionBarSection(),
        ],
      ),
    );
  }
}
