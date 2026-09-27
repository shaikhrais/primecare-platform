import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_profile_header_section.dart';
import 'sections/client_profile_identity_summary_section.dart';
import 'sections/client_profile_details_form_section.dart';
import 'sections/client_profile_preferences_or_documents_section.dart';
import 'sections/client_profile_action_bar_section.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_profile',
      title: 'Client Profile',
      child: Column(
        children: const [
          const ClientProfileHeaderSection(),
          const ClientProfileIdentitySummarySection(),
          const ClientProfileDetailsFormSection(),
          const ClientProfilePreferencesOrDocumentsSection(),
          const ClientProfileActionBarSection(),
        ],
      ),
    );
  }
}
