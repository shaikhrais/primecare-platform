import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_staff_coordination_header_section.dart';
import 'sections/operations_manager_staff_coordination_content_summary_section.dart';
import 'sections/operations_manager_staff_coordination_primary_content_section.dart';
import 'sections/operations_manager_staff_coordination_action_bar_section.dart';

class OperationsManagerStaffCoordinationScreen extends StatelessWidget {
  const OperationsManagerStaffCoordinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_staff_coordination',
      title: 'Operations Manager Staff Coordination',
      child: Column(
        children: const [
          const OperationsManagerStaffCoordinationHeaderSection(),
          const OperationsManagerStaffCoordinationContentSummarySection(),
          const OperationsManagerStaffCoordinationPrimaryContentSection(),
          const OperationsManagerStaffCoordinationActionBarSection(),
        ],
      ),
    );
  }
}
