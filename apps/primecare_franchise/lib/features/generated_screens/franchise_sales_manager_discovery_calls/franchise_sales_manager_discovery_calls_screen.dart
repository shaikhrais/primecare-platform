import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_discovery_calls_header_section.dart';
import 'sections/franchise_sales_manager_discovery_calls_content_summary_section.dart';
import 'sections/franchise_sales_manager_discovery_calls_primary_content_section.dart';
import 'sections/franchise_sales_manager_discovery_calls_action_bar_section.dart';

class FranchiseSalesManagerDiscoveryCallsScreen extends StatelessWidget {
  const FranchiseSalesManagerDiscoveryCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_discovery_calls',
      title: 'Franchise Sales Manager Discovery Calls',
      child: Column(
        children: const [
          const FranchiseSalesManagerDiscoveryCallsHeaderSection(),
          const FranchiseSalesManagerDiscoveryCallsContentSummarySection(),
          const FranchiseSalesManagerDiscoveryCallsPrimaryContentSection(),
          const FranchiseSalesManagerDiscoveryCallsActionBarSection(),
        ],
      ),
    );
  }
}
