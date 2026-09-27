import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/revenue_snapshot_header_section.dart';
import 'sections/revenue_snapshot_content_summary_section.dart';
import 'sections/revenue_snapshot_primary_content_section.dart';
import 'sections/revenue_snapshot_action_bar_section.dart';

class RevenueSnapshotScreen extends StatelessWidget {
  const RevenueSnapshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'revenue_snapshot',
      title: 'RevenueSnapshotScreen',
      child: Column(
        children: const [
          const RevenueSnapshotHeaderSection(),
          const RevenueSnapshotContentSummarySection(),
          const RevenueSnapshotPrimaryContentSection(),
          const RevenueSnapshotActionBarSection(),
        ],
      ),
    );
  }
}
