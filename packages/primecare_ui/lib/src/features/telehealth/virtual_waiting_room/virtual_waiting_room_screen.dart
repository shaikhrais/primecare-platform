import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/virtual_waiting_room_header_section.dart';
import 'sections/virtual_waiting_room_content_summary_section.dart';
import 'sections/virtual_waiting_room_primary_content_section.dart';
import 'sections/virtual_waiting_room_action_bar_section.dart';

class VirtualWaitingRoomScreen extends StatelessWidget {
  const VirtualWaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'virtual_waiting_room',
      title: 'Virtual Waiting Room',
      child: Column(
        children: const [
          const VirtualWaitingRoomHeaderSection(),
          const VirtualWaitingRoomContentSummarySection(),
          const VirtualWaitingRoomPrimaryContentSection(),
          const VirtualWaitingRoomActionBarSection(),
        ],
      ),
    );
  }
}
