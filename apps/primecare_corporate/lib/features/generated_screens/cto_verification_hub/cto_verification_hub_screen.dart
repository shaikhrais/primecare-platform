import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_verification_hub_header_section.dart';
import 'sections/cto_verification_hub_content_summary_section.dart';
import 'sections/cto_verification_hub_primary_content_section.dart';
import 'sections/cto_verification_hub_action_bar_section.dart';

class CtoVerificationHubScreen extends StatelessWidget {
  const CtoVerificationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_verification_hub',
      title: 'Cto Verification Hub',
      child: Column(
        children: const [
          const CtoVerificationHubHeaderSection(),
          const CtoVerificationHubContentSummarySection(),
          const CtoVerificationHubPrimaryContentSection(),
          const CtoVerificationHubActionBarSection(),
        ],
      ),
    );
  }
}
