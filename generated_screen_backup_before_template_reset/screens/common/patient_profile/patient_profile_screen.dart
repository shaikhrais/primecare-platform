import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_profile_header_section.dart';
import 'sections/patient_profile_identity_summary_section.dart';
import 'sections/patient_profile_details_form_section.dart';
import 'sections/patient_profile_preferences_or_documents_section.dart';
import 'sections/patient_profile_action_bar_section.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_profile',
      title: 'PatientProfileScreen',
      child: Column(
        children: const [
          const PatientProfileHeaderSection(),
          const PatientProfileIdentitySummarySection(),
          const PatientProfileDetailsFormSection(),
          const PatientProfilePreferencesOrDocumentsSection(),
          const PatientProfileActionBarSection(),
        ],
      ),
    );
  }
}
