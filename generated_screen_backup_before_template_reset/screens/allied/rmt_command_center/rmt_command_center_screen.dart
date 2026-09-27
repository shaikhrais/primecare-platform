import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_command_center_header_section.dart';
import 'sections/rmt_command_center_content_summary_section.dart';
import 'sections/rmt_command_center_primary_content_section.dart';
import 'sections/rmt_command_center_action_bar_section.dart';

class RmtCommandCenterScreen extends StatelessWidget {
  const RmtCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_command_center',
      title: 'RmtCommandCenterScreen',
      child: Column(
        children: const [
          const RmtCommandCenterHeaderSection(),
          const RmtCommandCenterContentSummarySection(),
          const RmtCommandCenterPrimaryContentSection(),
          const RmtCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
