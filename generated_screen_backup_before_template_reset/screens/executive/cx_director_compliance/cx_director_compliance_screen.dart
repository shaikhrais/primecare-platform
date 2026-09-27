import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cx_director_compliance_header_section.dart';
import 'sections/cx_director_compliance_content_summary_section.dart';
import 'sections/cx_director_compliance_primary_content_section.dart';
import 'sections/cx_director_compliance_action_bar_section.dart';

class CxDirectorComplianceScreen extends StatelessWidget {
  const CxDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cx_director_compliance',
      title: 'CxDirectorComplianceScreen',
      child: Column(
        children: const [
          const CxDirectorComplianceHeaderSection(),
          const CxDirectorComplianceContentSummarySection(),
          const CxDirectorCompliancePrimaryContentSection(),
          const CxDirectorComplianceActionBarSection(),
        ],
      ),
    );
  }
}
