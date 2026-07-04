import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/certification_renewal_alerts_header_section.dart';
import 'sections/certification_renewal_alerts_form_body_section.dart';
import 'sections/certification_renewal_alerts_validation_messages_section.dart';
import 'sections/certification_renewal_alerts_action_bar_section.dart';

class CertificationRenewalAlertsScreen extends StatelessWidget {
  const CertificationRenewalAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'certification_renewal_alerts',
      title: 'Certification Renewal Alerts',
      child: Column(
        children: const [
          const CertificationRenewalAlertsHeaderSection(),
          const CertificationRenewalAlertsFormBodySection(),
          const CertificationRenewalAlertsValidationMessagesSection(),
          const CertificationRenewalAlertsActionBarSection(),
        ],
      ),
    );
  }
}
