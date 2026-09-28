import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_renewals_header_section.dart';
import 'sections/partnership_manager_renewals_form_body_section.dart';
import 'sections/partnership_manager_renewals_validation_messages_section.dart';
import 'sections/partnership_manager_renewals_action_bar_section.dart';

class PartnershipManagerRenewalsScreen extends StatelessWidget {
  const PartnershipManagerRenewalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_renewals',
      title: 'Partnership Manager Renewals',
      child: Column(
        children: const [
          const PartnershipManagerRenewalsHeaderSection(),
          const PartnershipManagerRenewalsFormBodySection(),
          const PartnershipManagerRenewalsValidationMessagesSection(),
          const PartnershipManagerRenewalsActionBarSection(),
        ],
      ),
    );
  }
}
