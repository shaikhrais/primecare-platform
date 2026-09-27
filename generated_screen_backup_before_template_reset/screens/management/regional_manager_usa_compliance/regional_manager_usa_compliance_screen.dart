import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_manager_usa_compliance_header_section.dart';
import 'sections/regional_manager_usa_compliance_content_summary_section.dart';
import 'sections/regional_manager_usa_compliance_primary_content_section.dart';
import 'sections/regional_manager_usa_compliance_action_bar_section.dart';

class RegionalManagerUsaComplianceScreen extends StatelessWidget {
  const RegionalManagerUsaComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_manager_usa_compliance',
      title: 'RegionalManagerUsaComplianceScreen',
      child: Column(
        children: const [
          const RegionalManagerUsaComplianceHeaderSection(),
          const RegionalManagerUsaComplianceContentSummarySection(),
          const RegionalManagerUsaCompliancePrimaryContentSection(),
          const RegionalManagerUsaComplianceActionBarSection(),
        ],
      ),
    );
  }
}
