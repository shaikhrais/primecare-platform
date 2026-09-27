import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'adjustment_notes_screen_controller.dart';
import 'sections/adjustment_notes_header_section.dart';
import 'sections/adjustment_notes_client_context_section.dart';
import 'sections/adjustment_notes_notes_form_section.dart';
import 'sections/adjustment_notes_notes_history_section.dart';
import 'sections/adjustment_notes_action_bar_section.dart';


class AdjustmentNotesScreen extends ConsumerWidget {
  const AdjustmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adjustment_notesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('AdjustmentNotes'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(adjustment_notesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('adjustment_notes_loading'), child: Semantics(label: 'adjustment_notes_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('adjustment_notes_screen'),
                    child: Column(
                      children: [
                        AdjustmentNotesHeaderSection(data: state.data),
                        AdjustmentNotesClientContextSection(data: state.data),
                        AdjustmentNotesNotesFormSection(data: state.data),
                        AdjustmentNotesNotesHistorySection(data: state.data),
                        AdjustmentNotesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
