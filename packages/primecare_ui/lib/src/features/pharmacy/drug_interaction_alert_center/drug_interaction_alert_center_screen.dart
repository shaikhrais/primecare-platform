import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/drug_interaction_alert_center_header_section.dart';
import 'sections/drug_interaction_alert_center_task_filters_section.dart';
import 'sections/drug_interaction_alert_center_task_list_section.dart';
import 'sections/drug_interaction_alert_center_task_details_section.dart';
import 'sections/drug_interaction_alert_center_action_bar_section.dart';

class DrugInteractionAlertCenterScreen extends StatelessWidget {
  const DrugInteractionAlertCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'drug_interaction_alert_center',
      title: 'Drug Interaction Alert Center',
      child: Column(
        children: const [
          const DrugInteractionAlertCenterHeaderSection(),
          const DrugInteractionAlertCenterTaskFiltersSection(),
          const DrugInteractionAlertCenterTaskListSection(),
          const DrugInteractionAlertCenterTaskDetailsSection(),
          const DrugInteractionAlertCenterActionBarSection(),
        ],
      ),
    );
  }
}
