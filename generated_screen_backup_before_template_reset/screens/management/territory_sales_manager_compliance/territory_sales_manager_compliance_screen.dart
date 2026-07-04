import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_compliance_header_section.dart';
import 'sections/territory_sales_manager_compliance_content_summary_section.dart';
import 'sections/territory_sales_manager_compliance_primary_content_section.dart';
import 'sections/territory_sales_manager_compliance_action_bar_section.dart';

class TerritorySalesManagerComplianceScreen extends StatelessWidget {
  const TerritorySalesManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_compliance',
      title: 'TerritorySalesManagerComplianceScreen',
      child: Column(
        children: const [
          const TerritorySalesManagerComplianceHeaderSection(),
          const TerritorySalesManagerComplianceContentSummarySection(),
          const TerritorySalesManagerCompliancePrimaryContentSection(),
          const TerritorySalesManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}
