import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/governance_control_room_header_section.dart';
import 'sections/governance_control_room_content_summary_section.dart';
import 'sections/governance_control_room_primary_content_section.dart';
import 'sections/governance_control_room_action_bar_section.dart';

class GovernanceControlRoomScreen extends StatelessWidget {
  const GovernanceControlRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'governance_control_room',
      title: 'GovernanceControlRoomScreen',
      child: Column(
        children: const [
          const GovernanceControlRoomHeaderSection(),
          const GovernanceControlRoomContentSummarySection(),
          const GovernanceControlRoomPrimaryContentSection(),
          const GovernanceControlRoomActionBarSection(),
        ],
      ),
    );
  }
}
