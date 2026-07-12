import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'vitals_entry_screen_controller.dart';
import 'sections/vitals_entry_header_section.dart';
import 'sections/vitals_entry_content_summary_section.dart';
import 'sections/vitals_entry_primary_content_section.dart';
import 'sections/vitals_entry_action_bar_section.dart';


class VitalsEntryScreen extends ConsumerWidget {
  const VitalsEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vitals_entryControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Vitals Entry'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(vitals_entryControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('vitals_entry_loading'), child: Semantics(label: 'vitals_entry_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('vitals_entry_screen'),
                    child: Column(
                      children: [
                        VitalsEntryHeaderSection(data: state.data),
                        VitalsEntryContentSummarySection(data: state.data),
                        VitalsEntryPrimaryContentSection(data: state.data),
                        VitalsEntryActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
