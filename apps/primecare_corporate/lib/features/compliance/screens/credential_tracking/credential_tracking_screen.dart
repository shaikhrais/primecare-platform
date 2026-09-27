import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/credential_tracking_header_section.dart';
import 'sections/credential_tracking_content_summary_section.dart';
import 'sections/credential_tracking_primary_content_section.dart';
import 'sections/credential_tracking_action_bar_section.dart';

class CredentialTrackingScreen extends StatelessWidget {
  const CredentialTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'credential_tracking',
      title: 'Credential Tracking',
      child: Column(
        children: const [
          const CredentialTrackingHeaderSection(),
          const CredentialTrackingContentSummarySection(),
          const CredentialTrackingPrimaryContentSection(),
          const CredentialTrackingActionBarSection(),
        ],
      ),
    );
  }
}
