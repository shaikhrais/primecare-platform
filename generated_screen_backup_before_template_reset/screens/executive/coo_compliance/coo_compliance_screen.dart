import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_compliance_header_section.dart';
import 'sections/coo_compliance_filter_bar_section.dart';
import 'sections/coo_compliance_data_table_section.dart';
import 'sections/coo_compliance_pagination_section.dart';
import 'sections/coo_compliance_action_bar_section.dart';

class CooComplianceScreen extends StatelessWidget {
  const CooComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_compliance',
      title: 'CooComplianceScreen',
      child: Column(
        children: const [
          const CooComplianceHeaderSection(),
          const CooComplianceFilterBarSection(),
          const CooComplianceDataTableSection(),
          const CooCompliancePaginationSection(),
          const CooComplianceActionBarSection(),
        ],
      ),
    );
  }
}
