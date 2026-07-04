import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/risk_management_header_section.dart';
import 'sections/risk_management_content_summary_section.dart';
import 'sections/risk_management_primary_content_section.dart';
import 'sections/risk_management_action_bar_section.dart';

class RiskManagementScreen extends StatelessWidget {
  const RiskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'risk_management',
      title: 'RiskManagementScreen',
      child: Column(
        children: const [
          const RiskManagementHeaderSection(),
          const RiskManagementContentSummarySection(),
          const RiskManagementPrimaryContentSection(),
          const RiskManagementActionBarSection(),
        ],
      ),
    );
  }
}
