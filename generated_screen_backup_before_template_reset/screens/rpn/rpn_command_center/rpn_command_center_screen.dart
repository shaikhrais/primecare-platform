import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_command_center_header_section.dart';
import 'sections/rpn_command_center_content_summary_section.dart';
import 'sections/rpn_command_center_primary_content_section.dart';
import 'sections/rpn_command_center_action_bar_section.dart';

class RpnCommandCenterScreen extends StatelessWidget {
  const RpnCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_command_center',
      title: 'RpnCommandCenterScreen',
      child: Column(
        children: const [
          const RpnCommandCenterHeaderSection(),
          const RpnCommandCenterContentSummarySection(),
          const RpnCommandCenterPrimaryContentSection(),
          const RpnCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
