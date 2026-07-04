import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_compliance_header_section.dart';
import 'sections/territory_expansion_manager_compliance_content_summary_section.dart';
import 'sections/territory_expansion_manager_compliance_primary_content_section.dart';
import 'sections/territory_expansion_manager_compliance_action_bar_section.dart';

class TerritoryExpansionManagerComplianceScreen extends StatelessWidget {
  const TerritoryExpansionManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_compliance',
      title: 'TerritoryExpansionManagerComplianceScreen',
      child: Column(
        children: const [
          const TerritoryExpansionManagerComplianceHeaderSection(),
          const TerritoryExpansionManagerComplianceContentSummarySection(),
          const TerritoryExpansionManagerCompliancePrimaryContentSection(),
          const TerritoryExpansionManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
