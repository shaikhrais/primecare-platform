import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/caregiver_client_profile_header_section.dart';
import 'sections/caregiver_client_profile_identity_summary_section.dart';
import 'sections/caregiver_client_profile_details_form_section.dart';
import 'sections/caregiver_client_profile_preferences_or_documents_section.dart';
import 'sections/caregiver_client_profile_action_bar_section.dart';

class CaregiverClientProfileScreen extends StatelessWidget {
  const CaregiverClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'caregiver_client_profile',
      title: 'CaregiverClientProfileScreen',
      child: Column(
        children: const [
          const CaregiverClientProfileHeaderSection(),
          const CaregiverClientProfileIdentitySummarySection(),
          const CaregiverClientProfileDetailsFormSection(),
          const CaregiverClientProfilePreferencesOrDocumentsSection(),
          const CaregiverClientProfileActionBarSection(),
        ],
      ),
    );
  }
}
