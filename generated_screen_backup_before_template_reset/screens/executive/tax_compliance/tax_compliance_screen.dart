import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/tax_compliance_header_section.dart';
import 'sections/tax_compliance_content_summary_section.dart';
import 'sections/tax_compliance_primary_content_section.dart';
import 'sections/tax_compliance_action_bar_section.dart';

class TaxComplianceScreen extends StatelessWidget {
  const TaxComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'tax_compliance',
      title: 'TaxComplianceScreen',
      child: Column(
        children: const [
          const TaxComplianceHeaderSection(),
          const TaxComplianceContentSummarySection(),
          const TaxCompliancePrimaryContentSection(),
          const TaxComplianceActionBarSection(),
        ],
      ),
    );
  }
}
