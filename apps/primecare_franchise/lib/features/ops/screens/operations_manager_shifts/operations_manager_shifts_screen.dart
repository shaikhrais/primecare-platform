import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_shifts_header_section.dart';
import 'sections/operations_manager_shifts_content_summary_section.dart';
import 'sections/operations_manager_shifts_primary_content_section.dart';
import 'sections/operations_manager_shifts_action_bar_section.dart';

class OperationsManagerShiftsScreen extends StatelessWidget {
  const OperationsManagerShiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_shifts',
      title: 'Operations Manager Shifts',
      child: Column(
        children: const [
          const OperationsManagerShiftsHeaderSection(),
          const OperationsManagerShiftsContentSummarySection(),
          const OperationsManagerShiftsPrimaryContentSection(),
          const OperationsManagerShiftsActionBarSection(),
        ],
      ),
    );
  }
}
