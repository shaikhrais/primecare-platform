import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_treatment_notes_screen_controller.dart';
import 'sections/rmt_treatment_notes_header_section.dart';
import 'sections/rmt_treatment_notes_client_context_section.dart';
import 'sections/rmt_treatment_notes_notes_form_section.dart';
import 'sections/rmt_treatment_notes_notes_history_section.dart';
import 'sections/rmt_treatment_notes_action_bar_section.dart';


class RmtTreatmentNotesScreen extends ConsumerWidget {
  const RmtTreatmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_treatment_notesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtTreatmentNotes'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_treatment_notesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_treatment_notes_loading'), child: Semantics(label: 'rmt_treatment_notes_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_treatment_notes_screen'),
                    child: Column(
                      children: [
                        RmtTreatmentNotesHeaderSection(data: state.data),
                        RmtTreatmentNotesClientContextSection(data: state.data),
                        RmtTreatmentNotesNotesFormSection(data: state.data),
                        RmtTreatmentNotesNotesHistorySection(data: state.data),
                        RmtTreatmentNotesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
