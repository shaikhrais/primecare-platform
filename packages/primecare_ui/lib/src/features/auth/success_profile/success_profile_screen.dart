import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/success_profile_header_section.dart';
import 'sections/success_profile_identity_summary_section.dart';
import 'sections/success_profile_details_form_section.dart';
import 'sections/success_profile_preferences_or_documents_section.dart';
import 'sections/success_profile_action_bar_section.dart';

class SuccessProfileScreen extends StatelessWidget {
  const SuccessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'success_profile',
      title: 'Success Profile',
      child: Column(
        children: const [
          const SuccessProfileHeaderSection(),
          const SuccessProfileIdentitySummarySection(),
          const SuccessProfileDetailsFormSection(),
          const SuccessProfilePreferencesOrDocumentsSection(),
          const SuccessProfileActionBarSection(),
        ],
      ),
    );
  }
}
