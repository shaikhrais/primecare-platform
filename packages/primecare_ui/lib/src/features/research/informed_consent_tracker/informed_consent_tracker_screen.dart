import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/informed_consent_tracker_header_section.dart';
import 'sections/informed_consent_tracker_form_body_section.dart';
import 'sections/informed_consent_tracker_validation_messages_section.dart';
import 'sections/informed_consent_tracker_action_bar_section.dart';

class InformedConsentTrackerScreen extends StatelessWidget {
  const InformedConsentTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'informed_consent_tracker',
      title: 'Informed Consent Tracker',
      child: Column(
        children: const [
          const InformedConsentTrackerHeaderSection(),
          const InformedConsentTrackerFormBodySection(),
          const InformedConsentTrackerValidationMessagesSection(),
          const InformedConsentTrackerActionBarSection(),
        ],
      ),
    );
  }
}
