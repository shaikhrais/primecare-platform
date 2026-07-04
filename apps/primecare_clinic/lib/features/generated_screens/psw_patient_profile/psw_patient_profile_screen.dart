import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_patient_profile_header_section.dart';
import 'sections/psw_patient_profile_identity_summary_section.dart';
import 'sections/psw_patient_profile_details_form_section.dart';
import 'sections/psw_patient_profile_preferences_or_documents_section.dart';
import 'sections/psw_patient_profile_action_bar_section.dart';

class PswPatientProfileScreen extends StatelessWidget {
  const PswPatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_patient_profile',
      title: 'Psw Patient Profile',
      child: Column(
        children: const [
          const PswPatientProfileHeaderSection(),
          const PswPatientProfileIdentitySummarySection(),
          const PswPatientProfileDetailsFormSection(),
          const PswPatientProfilePreferencesOrDocumentsSection(),
          const PswPatientProfileActionBarSection(),
        ],
      ),
    );
  }
}
