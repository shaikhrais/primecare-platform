import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_command_center_header_section.dart';
import 'sections/operations_command_center_content_summary_section.dart';
import 'sections/operations_command_center_primary_content_section.dart';
import 'sections/operations_command_center_action_bar_section.dart';

class OperationsCommandCenterScreen extends StatelessWidget {
  const OperationsCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_command_center',
      title: 'OperationsCommandCenterScreen',
      child: Column(
        children: const [
          const OperationsCommandCenterHeaderSection(),
          const OperationsCommandCenterContentSummarySection(),
          const OperationsCommandCenterPrimaryContentSection(),
          const OperationsCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
