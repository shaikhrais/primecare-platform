import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_credential_expiry_header_section.dart';
import 'sections/hr_director_credential_expiry_content_summary_section.dart';
import 'sections/hr_director_credential_expiry_primary_content_section.dart';
import 'sections/hr_director_credential_expiry_action_bar_section.dart';

class HrDirectorCredentialExpiryScreen extends StatelessWidget {
  const HrDirectorCredentialExpiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_credential_expiry',
      title: 'HrDirectorCredentialExpiryScreen',
      child: Column(
        children: const [
          const HrDirectorCredentialExpiryHeaderSection(),
          const HrDirectorCredentialExpiryContentSummarySection(),
          const HrDirectorCredentialExpiryPrimaryContentSection(),
          const HrDirectorCredentialExpiryActionBarSection(),
        ],
      ),
    );
  }
}
