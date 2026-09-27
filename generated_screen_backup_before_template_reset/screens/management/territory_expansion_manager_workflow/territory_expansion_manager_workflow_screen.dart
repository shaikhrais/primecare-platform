import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_workflow_header_section.dart';
import 'sections/territory_expansion_manager_workflow_task_filters_section.dart';
import 'sections/territory_expansion_manager_workflow_task_list_section.dart';
import 'sections/territory_expansion_manager_workflow_task_details_section.dart';
import 'sections/territory_expansion_manager_workflow_action_bar_section.dart';

class TerritoryExpansionManagerWorkflowScreen extends StatelessWidget {
  const TerritoryExpansionManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_workflow',
      title: 'TerritoryExpansionManagerWorkflowScreen',
      child: Column(
        children: const [
          const TerritoryExpansionManagerWorkflowHeaderSection(),
          const TerritoryExpansionManagerWorkflowTaskFiltersSection(),
          const TerritoryExpansionManagerWorkflowTaskListSection(),
          const TerritoryExpansionManagerWorkflowTaskDetailsSection(),
          const TerritoryExpansionManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
