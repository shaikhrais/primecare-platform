import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_command_center_header_section.dart';
import 'sections/physiotherapist_command_center_content_summary_section.dart';
import 'sections/physiotherapist_command_center_primary_content_section.dart';
import 'sections/physiotherapist_command_center_action_bar_section.dart';

class PhysiotherapistCommandCenterScreen extends StatelessWidget {
  const PhysiotherapistCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_command_center',
      title: 'PhysiotherapistCommandCenterScreen',
      child: Column(
        children: const [
          const PhysiotherapistCommandCenterHeaderSection(),
          const PhysiotherapistCommandCenterContentSummarySection(),
          const PhysiotherapistCommandCenterPrimaryContentSection(),
          const PhysiotherapistCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}
