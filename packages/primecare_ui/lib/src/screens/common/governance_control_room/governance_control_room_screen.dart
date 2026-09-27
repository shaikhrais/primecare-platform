import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'governance_control_room_screen_controller.dart';
import 'sections/governance_control_room_header_section.dart';
import 'sections/governance_control_room_content_summary_section.dart';
import 'sections/governance_control_room_primary_content_section.dart';
import 'sections/governance_control_room_action_bar_section.dart';


class GovernanceControlRoomScreen extends ConsumerWidget {
  const GovernanceControlRoomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(governance_control_roomControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GovernanceControlRoom'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(governance_control_roomControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('governance_control_room_loading'), child: Semantics(label: 'governance_control_room_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('governance_control_room_screen'),
                    child: Column(
                      children: [
                        GovernanceControlRoomHeaderSection(data: state.data),
                        GovernanceControlRoomContentSummarySection(data: state.data),
                        GovernanceControlRoomPrimaryContentSection(data: state.data),
                        GovernanceControlRoomActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
