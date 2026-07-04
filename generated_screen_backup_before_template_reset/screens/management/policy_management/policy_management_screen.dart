import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/policy_management_header_section.dart';
import 'sections/policy_management_content_summary_section.dart';
import 'sections/policy_management_primary_content_section.dart';
import 'sections/policy_management_action_bar_section.dart';

class PolicyManagementScreen extends StatelessWidget {
  const PolicyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'policy_management',
      title: 'PolicyManagementScreen',
      child: Column(
        children: const [
          const PolicyManagementHeaderSection(),
          const PolicyManagementContentSummarySection(),
          const PolicyManagementPrimaryContentSection(),
          const PolicyManagementActionBarSection(),
        ],
      ),
    );
  }
}
