import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/architecture_planning_compliance_header_section.dart';
import 'sections/architecture_planning_compliance_content_summary_section.dart';
import 'sections/architecture_planning_compliance_primary_content_section.dart';
import 'sections/architecture_planning_compliance_action_bar_section.dart';

class ArchitecturePlanningComplianceScreen extends StatelessWidget {
  const ArchitecturePlanningComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'architecture_planning_compliance',
      title: 'ArchitecturePlanningComplianceScreen',
      child: Column(
        children: const [
          const ArchitecturePlanningComplianceHeaderSection(),
          const ArchitecturePlanningComplianceContentSummarySection(),
          const ArchitecturePlanningCompliancePrimaryContentSection(),
          const ArchitecturePlanningComplianceActionBarSection(),
        ],
      ),
    );
  }
}
