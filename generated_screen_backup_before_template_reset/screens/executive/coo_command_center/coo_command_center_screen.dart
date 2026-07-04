import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_command_center_header_section.dart';
import 'sections/coo_command_center_content_summary_section.dart';
import 'sections/coo_command_center_primary_content_section.dart';
import 'sections/coo_command_center_action_bar_section.dart';

class CooCommandCenterScreen extends StatelessWidget {
  const CooCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_command_center',
      title: 'CooCommandCenterScreen',
      child: Column(
        children: const [
          const CooCommandCenterHeaderSection(),
          const CooCommandCenterContentSummarySection(),
          const CooCommandCenterPrimaryContentSection(),
          const CooCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
