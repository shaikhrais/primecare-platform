import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/security_hub_header_section.dart';
import 'sections/security_hub_content_summary_section.dart';
import 'sections/security_hub_primary_content_section.dart';
import 'sections/security_hub_action_bar_section.dart';

class SecurityHubScreen extends StatelessWidget {
  const SecurityHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'security_hub',
      title: 'Security Hub',
      child: Column(
        children: const [
          const SecurityHubHeaderSection(),
          const SecurityHubContentSummarySection(),
          const SecurityHubPrimaryContentSection(),
          const SecurityHubActionBarSection(),
        ],
      ),
    );
  }
}
