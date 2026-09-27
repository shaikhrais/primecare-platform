import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/staff_utilization_heatmap_header_section.dart';
import 'sections/staff_utilization_heatmap_content_summary_section.dart';
import 'sections/staff_utilization_heatmap_primary_content_section.dart';
import 'sections/staff_utilization_heatmap_action_bar_section.dart';

class StaffUtilizationHeatmapScreen extends StatelessWidget {
  const StaffUtilizationHeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'staff_utilization_heatmap',
      title: 'Staff Utilization Heatmap',
      child: Column(
        children: const [
          const StaffUtilizationHeatmapHeaderSection(),
          const StaffUtilizationHeatmapContentSummarySection(),
          const StaffUtilizationHeatmapPrimaryContentSection(),
          const StaffUtilizationHeatmapActionBarSection(),
        ],
      ),
    );
  }
}
