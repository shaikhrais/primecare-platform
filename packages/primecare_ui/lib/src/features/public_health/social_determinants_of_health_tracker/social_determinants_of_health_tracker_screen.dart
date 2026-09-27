import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/social_determinants_of_health_tracker_header_section.dart';
import 'sections/social_determinants_of_health_tracker_content_summary_section.dart';
import 'sections/social_determinants_of_health_tracker_primary_content_section.dart';
import 'sections/social_determinants_of_health_tracker_action_bar_section.dart';

class SocialDeterminantsOfHealthTrackerScreen extends StatelessWidget {
  const SocialDeterminantsOfHealthTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'social_determinants_of_health_tracker',
      title: 'Social Determinants Of Health Tracker',
      child: Column(
        children: const [
          const SocialDeterminantsOfHealthTrackerHeaderSection(),
          const SocialDeterminantsOfHealthTrackerContentSummarySection(),
          const SocialDeterminantsOfHealthTrackerPrimaryContentSection(),
          const SocialDeterminantsOfHealthTrackerActionBarSection(),
        ],
      ),
    );
  }
}
