import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/finance_director_compliance_header_section.dart';
import 'sections/finance_director_compliance_content_summary_section.dart';
import 'sections/finance_director_compliance_primary_content_section.dart';
import 'sections/finance_director_compliance_action_bar_section.dart';

class FinanceDirectorComplianceScreen extends StatelessWidget {
  const FinanceDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'finance_director_compliance',
      title: 'FinanceDirectorComplianceScreen',
      child: Column(
        children: const [
          const FinanceDirectorComplianceHeaderSection(),
          const FinanceDirectorComplianceContentSummarySection(),
          const FinanceDirectorCompliancePrimaryContentSection(),
          const FinanceDirectorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
