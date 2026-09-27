import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/consent_management_console_header_section.dart';
import 'sections/consent_management_console_consent_content_section.dart';
import 'sections/consent_management_console_consent_inputs_section.dart';
import 'sections/consent_management_console_action_bar_section.dart';

class ConsentManagementConsoleScreen extends StatelessWidget {
  const ConsentManagementConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'consent_management_console',
      title: 'Consent Management Console',
      child: Column(
        children: const [
          const ConsentManagementConsoleHeaderSection(),
          const ConsentManagementConsoleConsentContentSection(),
          const ConsentManagementConsoleConsentInputsSection(),
          const ConsentManagementConsoleActionBarSection(),
        ],
      ),
    );
  }
}
