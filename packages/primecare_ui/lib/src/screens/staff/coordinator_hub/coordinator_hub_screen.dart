import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coordinator_hub_screen_controller.dart';
import 'sections/coordinator_hub_header_section.dart';
import 'sections/coordinator_hub_content_summary_section.dart';
import 'sections/coordinator_hub_primary_content_section.dart';
import 'sections/coordinator_hub_action_bar_section.dart';


class CoordinatorHubScreen extends ConsumerWidget {
  const CoordinatorHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinator_hubControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CoordinatorHub'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coordinator_hubControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coordinator_hub_loading'), child: Semantics(label: 'coordinator_hub_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coordinator_hub_screen'),
                    child: Column(
                      children: [
                        CoordinatorHubHeaderSection(data: state.data),
                        CoordinatorHubContentSummarySection(data: state.data),
                        CoordinatorHubPrimaryContentSection(data: state.data),
                        CoordinatorHubActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
