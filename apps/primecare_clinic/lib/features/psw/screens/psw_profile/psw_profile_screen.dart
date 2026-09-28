import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_profile_header_section.dart';
import 'sections/psw_profile_identity_summary_section.dart';
import 'sections/psw_profile_details_form_section.dart';
import 'sections/psw_profile_preferences_or_documents_section.dart';
import 'sections/psw_profile_action_bar_section.dart';

class PswProfileScreen extends StatelessWidget {
  const PswProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_profile',
      title: 'Psw Profile',
      child: Column(
        children: const [
          const PswProfileHeaderSection(),
          const PswProfileIdentitySummarySection(),
          const PswProfileDetailsFormSection(),
          const PswProfilePreferencesOrDocumentsSection(),
          const PswProfileActionBarSection(),
        ],
      ),
    );
  }
}
