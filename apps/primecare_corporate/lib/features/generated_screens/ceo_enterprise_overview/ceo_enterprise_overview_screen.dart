import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ceo_enterprise_overview_header_section.dart';
import 'sections/ceo_enterprise_overview_filter_bar_section.dart';
import 'sections/ceo_enterprise_overview_data_table_section.dart';
import 'sections/ceo_enterprise_overview_pagination_section.dart';
import 'sections/ceo_enterprise_overview_action_bar_section.dart';

class CeoEnterpriseOverviewScreen extends StatelessWidget {
  const CeoEnterpriseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ceo_enterprise_overview',
      title: 'Ceo Enterprise Overview',
      child: Column(
        children: const [
          const CeoEnterpriseOverviewHeaderSection(),
          const CeoEnterpriseOverviewFilterBarSection(),
          const CeoEnterpriseOverviewDataTableSection(),
          const CeoEnterpriseOverviewPaginationSection(),
          const CeoEnterpriseOverviewActionBarSection(),
        ],
      ),
    );
  }
}
