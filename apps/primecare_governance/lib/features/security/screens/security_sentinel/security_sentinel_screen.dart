import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/security_sentinel_header_section.dart';
import 'sections/security_sentinel_content_summary_section.dart';
import 'sections/security_sentinel_primary_content_section.dart';
import 'sections/security_sentinel_action_bar_section.dart';

class SecuritySentinelScreen extends StatelessWidget {
  const SecuritySentinelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'security_sentinel',
      title: 'Security Sentinel',
      child: Column(
        children: const [
          const SecuritySentinelHeaderSection(),
          const SecuritySentinelContentSummarySection(),
          const SecuritySentinelPrimaryContentSection(),
          const SecuritySentinelActionBarSection(),
        ],
      ),
    );
  }
}
