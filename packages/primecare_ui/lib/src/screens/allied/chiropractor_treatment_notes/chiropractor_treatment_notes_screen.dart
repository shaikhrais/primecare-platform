import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_treatment_notes_screen_controller.dart';
import 'sections/chiropractor_treatment_notes_header_section.dart';
import 'sections/chiropractor_treatment_notes_client_context_section.dart';
import 'sections/chiropractor_treatment_notes_notes_form_section.dart';
import 'sections/chiropractor_treatment_notes_notes_history_section.dart';
import 'sections/chiropractor_treatment_notes_action_bar_section.dart';


class ChiropractorTreatmentNotesScreen extends ConsumerWidget {
  const ChiropractorTreatmentNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_treatment_notesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorTreatmentNotes'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_treatment_notesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_treatment_notes_loading'), child: Semantics(label: 'chiropractor_treatment_notes_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_treatment_notes_screen'),
                    child: Column(
                      children: [
                        ChiropractorTreatmentNotesHeaderSection(data: state.data),
                        ChiropractorTreatmentNotesClientContextSection(data: state.data),
                        ChiropractorTreatmentNotesNotesFormSection(data: state.data),
                        ChiropractorTreatmentNotesNotesHistorySection(data: state.data),
                        ChiropractorTreatmentNotesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
