import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_finance_snapshot_header_section.dart';
import 'sections/franchise_owner_finance_snapshot_content_summary_section.dart';
import 'sections/franchise_owner_finance_snapshot_primary_content_section.dart';
import 'sections/franchise_owner_finance_snapshot_action_bar_section.dart';

class FranchiseOwnerFinanceSnapshotScreen extends StatelessWidget {
  const FranchiseOwnerFinanceSnapshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_finance_snapshot',
      title: 'FranchiseOwnerFinanceSnapshotScreen',
      child: Column(
        children: const [
          const FranchiseOwnerFinanceSnapshotHeaderSection(),
          const FranchiseOwnerFinanceSnapshotContentSummarySection(),
          const FranchiseOwnerFinanceSnapshotPrimaryContentSection(),
          const FranchiseOwnerFinanceSnapshotActionBarSection(),
        ],
      ),
    );
  }
}
