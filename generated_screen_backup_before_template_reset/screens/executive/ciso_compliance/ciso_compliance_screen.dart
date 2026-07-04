import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ciso_compliance_header_section.dart';
import 'sections/ciso_compliance_content_summary_section.dart';
import 'sections/ciso_compliance_primary_content_section.dart';
import 'sections/ciso_compliance_action_bar_section.dart';

class CisoComplianceScreen extends StatelessWidget {
  const CisoComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ciso_compliance',
      title: 'CisoComplianceScreen',
      child: Column(
        children: const [
          const CisoComplianceHeaderSection(),
          const CisoComplianceContentSummarySection(),
          const CisoCompliancePrimaryContentSection(),
          const CisoComplianceActionBarSection(),
        ],
      ),
    );
  }
}
