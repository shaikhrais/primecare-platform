import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_follow_ups_header_section.dart';
import 'sections/franchise_sales_manager_follow_ups_content_summary_section.dart';
import 'sections/franchise_sales_manager_follow_ups_primary_content_section.dart';
import 'sections/franchise_sales_manager_follow_ups_action_bar_section.dart';

class FranchiseSalesManagerFollowUpsScreen extends StatelessWidget {
  const FranchiseSalesManagerFollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_follow_ups',
      title: 'Franchise Sales Manager Follow Ups',
      child: Column(
        children: const [
          const FranchiseSalesManagerFollowUpsHeaderSection(),
          const FranchiseSalesManagerFollowUpsContentSummarySection(),
          const FranchiseSalesManagerFollowUpsPrimaryContentSection(),
          const FranchiseSalesManagerFollowUpsActionBarSection(),
        ],
      ),
    );
  }
}
