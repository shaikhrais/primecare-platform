import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/consent_header_section.dart';
import 'sections/consent_consent_content_section.dart';
import 'sections/consent_consent_inputs_section.dart';
import 'sections/consent_action_bar_section.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'consent',
      title: 'Consent',
      child: Column(
        children: const [
          const ConsentHeaderSection(),
          const ConsentConsentContentSection(),
          const ConsentConsentInputsSection(),
          const ConsentActionBarSection(),
        ],
      ),
    );
  }
}
