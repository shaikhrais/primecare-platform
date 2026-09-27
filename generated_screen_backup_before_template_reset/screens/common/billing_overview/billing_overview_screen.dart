import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_overview_header_section.dart';
import 'sections/billing_overview_filter_bar_section.dart';
import 'sections/billing_overview_data_table_section.dart';
import 'sections/billing_overview_pagination_section.dart';
import 'sections/billing_overview_action_bar_section.dart';

class BillingOverviewScreen extends StatelessWidget {
  const BillingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_overview',
      title: 'BillingOverviewScreen',
      child: Column(
        children: const [
          const BillingOverviewHeaderSection(),
          const BillingOverviewFilterBarSection(),
          const BillingOverviewDataTableSection(),
          const BillingOverviewPaginationSection(),
          const BillingOverviewActionBarSection(),
        ],
      ),
    );
  }
}
