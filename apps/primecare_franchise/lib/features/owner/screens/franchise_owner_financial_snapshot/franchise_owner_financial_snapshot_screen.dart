import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_financial_snapshot_header_section.dart';
import 'sections/franchise_owner_financial_snapshot_content_summary_section.dart';
import 'sections/franchise_owner_financial_snapshot_primary_content_section.dart';
import 'sections/franchise_owner_financial_snapshot_action_bar_section.dart';

class FranchiseOwnerFinancialSnapshotScreen extends StatelessWidget {
  const FranchiseOwnerFinancialSnapshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_financial_snapshot',
      title: 'Franchise Owner Financial Snapshot',
      child: Column(
        children: const [
          const FranchiseOwnerFinancialSnapshotHeaderSection(),
          const FranchiseOwnerFinancialSnapshotContentSummarySection(),
          const FranchiseOwnerFinancialSnapshotPrimaryContentSection(),
          const FranchiseOwnerFinancialSnapshotActionBarSection(),
        ],
      ),
    );
  }
}
