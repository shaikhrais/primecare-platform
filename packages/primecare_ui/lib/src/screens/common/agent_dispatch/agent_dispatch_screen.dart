import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'agent_dispatch_screen_controller.dart';
import 'sections/agent_dispatch_header_section.dart';
import 'sections/agent_dispatch_content_summary_section.dart';
import 'sections/agent_dispatch_primary_content_section.dart';
import 'sections/agent_dispatch_action_bar_section.dart';


class AgentDispatchScreen extends ConsumerWidget {
  const AgentDispatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(agent_dispatchControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('AgentDispatch'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(agent_dispatchControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('agent_dispatch_loading'), child: Semantics(label: 'agent_dispatch_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('agent_dispatch_screen'),
                    child: Column(
                      children: [
                        AgentDispatchHeaderSection(data: state.data),
                        AgentDispatchContentSummarySection(data: state.data),
                        AgentDispatchPrimaryContentSection(data: state.data),
                        AgentDispatchActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
