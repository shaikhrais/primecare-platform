import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coordinator_dispatch_map_screen_controller.dart';
import 'sections/coordinator_dispatch_map_header_section.dart';
import 'sections/coordinator_dispatch_map_content_summary_section.dart';
import 'sections/coordinator_dispatch_map_primary_content_section.dart';
import 'sections/coordinator_dispatch_map_action_bar_section.dart';


class CoordinatorDispatchMapScreen extends ConsumerWidget {
  const CoordinatorDispatchMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinator_dispatch_mapControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CoordinatorDispatchMap'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coordinator_dispatch_mapControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coordinator_dispatch_map_loading'), child: Semantics(label: 'coordinator_dispatch_map_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coordinator_dispatch_map_screen'),
                    child: Column(
                      children: [
                        CoordinatorDispatchMapHeaderSection(data: state.data),
                        CoordinatorDispatchMapContentSummarySection(data: state.data),
                        CoordinatorDispatchMapPrimaryContentSection(data: state.data),
                        CoordinatorDispatchMapActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
