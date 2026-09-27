import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/gamification_profile_header_section.dart';
import 'sections/gamification_profile_identity_summary_section.dart';
import 'sections/gamification_profile_details_form_section.dart';
import 'sections/gamification_profile_preferences_or_documents_section.dart';
import 'sections/gamification_profile_action_bar_section.dart';

class GamificationProfileScreen extends StatelessWidget {
  const GamificationProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'gamification_profile',
      title: 'Gamification Profile',
      child: Column(
        children: const [
          const GamificationProfileHeaderSection(),
          const GamificationProfileIdentitySummarySection(),
          const GamificationProfileDetailsFormSection(),
          const GamificationProfilePreferencesOrDocumentsSection(),
          const GamificationProfileActionBarSection(),
        ],
      ),
    );
  }
}
