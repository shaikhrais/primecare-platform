import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vendor_risk_assessor_header_section.dart';
import 'sections/vendor_risk_assessor_content_summary_section.dart';
import 'sections/vendor_risk_assessor_primary_content_section.dart';
import 'sections/vendor_risk_assessor_action_bar_section.dart';

class VendorRiskAssessorScreen extends StatelessWidget {
  const VendorRiskAssessorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vendor_risk_assessor',
      title: 'Vendor Risk Assessor',
      child: Column(
        children: const [
          const VendorRiskAssessorHeaderSection(),
          const VendorRiskAssessorContentSummarySection(),
          const VendorRiskAssessorPrimaryContentSection(),
          const VendorRiskAssessorActionBarSection(),
        ],
      ),
    );
  }
}
