import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_bus_dev_compliance_header_section.dart';
import 'sections/head_of_bus_dev_compliance_content_summary_section.dart';
import 'sections/head_of_bus_dev_compliance_primary_content_section.dart';
import 'sections/head_of_bus_dev_compliance_action_bar_section.dart';

class HeadOfBusDevComplianceScreen extends StatelessWidget {
  const HeadOfBusDevComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_bus_dev_compliance',
      title: 'HeadOfBusDevComplianceScreen',
      child: Column(
        children: const [
          const HeadOfBusDevComplianceHeaderSection(),
          const HeadOfBusDevComplianceContentSummarySection(),
          const HeadOfBusDevCompliancePrimaryContentSection(),
          const HeadOfBusDevComplianceActionBarSection(),
        ],
      ),
    );
  }
}
