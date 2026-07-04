import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_capacity_planner_header_section.dart';
import 'sections/system_capacity_planner_content_summary_section.dart';
import 'sections/system_capacity_planner_primary_content_section.dart';
import 'sections/system_capacity_planner_action_bar_section.dart';

class SystemCapacityPlannerScreen extends StatelessWidget {
  const SystemCapacityPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_capacity_planner',
      title: 'System Capacity Planner',
      child: Column(
        children: const [
          const SystemCapacityPlannerHeaderSection(),
          const SystemCapacityPlannerContentSummarySection(),
          const SystemCapacityPlannerPrimaryContentSection(),
          const SystemCapacityPlannerActionBarSection(),
        ],
      ),
    );
  }
}
