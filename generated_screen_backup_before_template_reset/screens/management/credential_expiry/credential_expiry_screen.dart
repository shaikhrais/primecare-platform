import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/credential_expiry_header_section.dart';
import 'sections/credential_expiry_content_summary_section.dart';
import 'sections/credential_expiry_primary_content_section.dart';
import 'sections/credential_expiry_action_bar_section.dart';

class CredentialExpiryScreen extends StatelessWidget {
  const CredentialExpiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'credential_expiry',
      title: 'CredentialExpiryScreen',
      child: Column(
        children: const [
          const CredentialExpiryHeaderSection(),
          const CredentialExpiryContentSummarySection(),
          const CredentialExpiryPrimaryContentSection(),
          const CredentialExpiryActionBarSection(),
        ],
      ),
    );
  }
}
