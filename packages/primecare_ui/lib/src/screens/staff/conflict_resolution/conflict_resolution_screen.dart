import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'conflict_resolution_screen_controller.dart';
import 'sections/conflict_resolution_header_section.dart';
import 'sections/conflict_resolution_content_summary_section.dart';
import 'sections/conflict_resolution_primary_content_section.dart';
import 'sections/conflict_resolution_action_bar_section.dart';


class ConflictResolutionScreen extends ConsumerWidget {
  const ConflictResolutionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(conflict_resolutionControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ConflictResolution'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(conflict_resolutionControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('conflict_resolution_loading'), child: Semantics(label: 'conflict_resolution_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('conflict_resolution_screen'),
                    child: Column(
                      children: [
                        ConflictResolutionHeaderSection(data: state.data),
                        ConflictResolutionContentSummarySection(data: state.data),
                        ConflictResolutionPrimaryContentSection(data: state.data),
                        ConflictResolutionActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
