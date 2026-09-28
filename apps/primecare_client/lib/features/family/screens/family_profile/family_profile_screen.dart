import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_profile_header_section.dart';
import 'sections/family_profile_identity_summary_section.dart';
import 'sections/family_profile_details_form_section.dart';
import 'sections/family_profile_preferences_or_documents_section.dart';
import 'sections/family_profile_action_bar_section.dart';

class FamilyProfileScreen extends StatelessWidget {
  const FamilyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_profile',
      title: 'Family Profile',
      child: Column(
        children: const [
          const FamilyProfileHeaderSection(),
          const FamilyProfileIdentitySummarySection(),
          const FamilyProfileDetailsFormSection(),
          const FamilyProfilePreferencesOrDocumentsSection(),
          const FamilyProfileActionBarSection(),
        ],
      ),
    );
  }
}
