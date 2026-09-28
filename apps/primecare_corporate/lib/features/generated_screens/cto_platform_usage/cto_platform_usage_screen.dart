import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_platform_usage_header_section.dart';
import 'sections/cto_platform_usage_form_body_section.dart';
import 'sections/cto_platform_usage_validation_messages_section.dart';
import 'sections/cto_platform_usage_action_bar_section.dart';

class CtoPlatformUsageScreen extends StatelessWidget {
  const CtoPlatformUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_platform_usage',
      title: 'Cto Platform Usage',
      child: Column(
        children: const [
          const CtoPlatformUsageHeaderSection(),
          const CtoPlatformUsageFormBodySection(),
          const CtoPlatformUsageValidationMessagesSection(),
          const CtoPlatformUsageActionBarSection(),
        ],
      ),
    );
  }
}
