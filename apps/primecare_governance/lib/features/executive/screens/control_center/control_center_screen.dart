import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/control_center_header_section.dart';
import 'sections/control_center_content_summary_section.dart';
import 'sections/control_center_primary_content_section.dart';
import 'sections/control_center_action_bar_section.dart';

class ControlCenterScreen extends StatelessWidget {
  const ControlCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'control_center',
      title: 'Control Center',
      child: Column(
        children: const [
          const ControlCenterHeaderSection(),
          const ControlCenterContentSummarySection(),
          const ControlCenterPrimaryContentSection(),
          const ControlCenterActionBarSection(),
        ],
      ),
    );
  }
}
