import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'care_updates_screen_controller.dart';
import 'sections/care_updates_header_section.dart';
import 'sections/care_updates_content_summary_section.dart';
import 'sections/care_updates_primary_content_section.dart';
import 'sections/care_updates_action_bar_section.dart';


class CareUpdatesScreen extends ConsumerWidget {
  const CareUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(care_updatesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CareUpdates'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(care_updatesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('care_updates_loading'), child: Semantics(label: 'care_updates_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('care_updates_screen'),
                    child: Column(
                      children: [
                        CareUpdatesHeaderSection(data: state.data),
                        CareUpdatesContentSummarySection(data: state.data),
                        CareUpdatesPrimaryContentSection(data: state.data),
                        CareUpdatesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
