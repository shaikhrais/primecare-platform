import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/executive_command_center_header_section.dart';
import 'sections/executive_command_center_content_summary_section.dart';
import 'sections/executive_command_center_primary_content_section.dart';
import 'sections/executive_command_center_action_bar_section.dart';

class ExecutiveCommandCenterScreen extends StatelessWidget {
  const ExecutiveCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'executive_command_center',
      title: 'ExecutiveCommandCenterScreen',
      child: Column(
        children: const [
          const ExecutiveCommandCenterHeaderSection(),
          const ExecutiveCommandCenterContentSummarySection(),
          const ExecutiveCommandCenterPrimaryContentSection(),
          const ExecutiveCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
