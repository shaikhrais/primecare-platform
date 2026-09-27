import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_compliance_header_section.dart';
import 'sections/operations_manager_compliance_content_summary_section.dart';
import 'sections/operations_manager_compliance_primary_content_section.dart';
import 'sections/operations_manager_compliance_action_bar_section.dart';

class OperationsManagerComplianceScreen extends StatelessWidget {
  const OperationsManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_compliance',
      title: 'OperationsManagerComplianceScreen',
      child: Column(
        children: const [
          const OperationsManagerComplianceHeaderSection(),
          const OperationsManagerComplianceContentSummarySection(),
          const OperationsManagerCompliancePrimaryContentSection(),
          const OperationsManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
