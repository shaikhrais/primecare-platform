import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_daily_operations_header_section.dart';
import 'sections/operations_manager_daily_operations_content_summary_section.dart';
import 'sections/operations_manager_daily_operations_primary_content_section.dart';
import 'sections/operations_manager_daily_operations_action_bar_section.dart';

class OperationsManagerDailyOperationsScreen extends StatelessWidget {
  const OperationsManagerDailyOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_daily_operations',
      title: 'Operations Manager Daily Operations',
      child: Column(
        children: const [
          const OperationsManagerDailyOperationsHeaderSection(),
          const OperationsManagerDailyOperationsContentSummarySection(),
          const OperationsManagerDailyOperationsPrimaryContentSection(),
          const OperationsManagerDailyOperationsActionBarSection(),
        ],
      ),
    );
  }
}
