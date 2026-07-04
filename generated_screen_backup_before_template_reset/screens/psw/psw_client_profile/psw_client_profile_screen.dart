import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_client_profile_header_section.dart';
import 'sections/psw_client_profile_identity_summary_section.dart';
import 'sections/psw_client_profile_details_form_section.dart';
import 'sections/psw_client_profile_preferences_or_documents_section.dart';
import 'sections/psw_client_profile_action_bar_section.dart';

class PswClientProfileScreen extends StatelessWidget {
  const PswClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_client_profile',
      title: 'Psw Client Profile',
      child: Column(
        children: const [
          const PswClientProfileHeaderSection(),
          const PswClientProfileIdentitySummarySection(),
          const PswClientProfileDetailsFormSection(),
          const PswClientProfilePreferencesOrDocumentsSection(),
          const PswClientProfileActionBarSection(),
        ],
      ),
    );
  }
}
