import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_command_center_header_section.dart';
import 'sections/rn_command_center_content_summary_section.dart';
import 'sections/rn_command_center_primary_content_section.dart';
import 'sections/rn_command_center_action_bar_section.dart';

class RnCommandCenterScreen extends StatelessWidget {
  const RnCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_command_center',
      title: 'RnCommandCenterScreen',
      child: Column(
        children: const [
          const RnCommandCenterHeaderSection(),
          const RnCommandCenterContentSummarySection(),
          const RnCommandCenterPrimaryContentSection(),
          const RnCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
