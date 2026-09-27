import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'release_operations_screen_controller.dart';
import 'sections/release_operations_header_section.dart';
import 'sections/release_operations_content_summary_section.dart';
import 'sections/release_operations_primary_content_section.dart';
import 'sections/release_operations_action_bar_section.dart';


class ReleaseOperationsScreen extends ConsumerWidget {
  const ReleaseOperationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(release_operationsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ReleaseOperations'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(release_operationsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('release_operations_loading'), child: Semantics(label: 'release_operations_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('release_operations_screen'),
                    child: Column(
                      children: [
                        ReleaseOperationsHeaderSection(data: state.data),
                        ReleaseOperationsContentSummarySection(data: state.data),
                        ReleaseOperationsPrimaryContentSection(data: state.data),
                        ReleaseOperationsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
