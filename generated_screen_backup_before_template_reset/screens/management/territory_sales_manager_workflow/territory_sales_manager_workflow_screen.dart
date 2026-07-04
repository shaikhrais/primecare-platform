import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_workflow_header_section.dart';
import 'sections/territory_sales_manager_workflow_task_filters_section.dart';
import 'sections/territory_sales_manager_workflow_task_list_section.dart';
import 'sections/territory_sales_manager_workflow_task_details_section.dart';
import 'sections/territory_sales_manager_workflow_action_bar_section.dart';

class TerritorySalesManagerWorkflowScreen extends StatelessWidget {
  const TerritorySalesManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_workflow',
      title: 'TerritorySalesManagerWorkflowScreen',
      child: Column(
        children: const [
          const TerritorySalesManagerWorkflowHeaderSection(),
          const TerritorySalesManagerWorkflowTaskFiltersSection(),
          const TerritorySalesManagerWorkflowTaskListSection(),
          const TerritorySalesManagerWorkflowTaskDetailsSection(),
          const TerritorySalesManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}
