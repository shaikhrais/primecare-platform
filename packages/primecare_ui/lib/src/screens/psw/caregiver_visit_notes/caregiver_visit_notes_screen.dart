import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'caregiver_visit_notes_screen_controller.dart';
import 'sections/caregiver_visit_notes_header_section.dart';
import 'sections/caregiver_visit_notes_client_context_section.dart';
import 'sections/caregiver_visit_notes_notes_form_section.dart';
import 'sections/caregiver_visit_notes_notes_history_section.dart';
import 'sections/caregiver_visit_notes_action_bar_section.dart';


class CaregiverVisitNotesScreen extends ConsumerWidget {
  const CaregiverVisitNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiver_visit_notesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CaregiverVisitNotes'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(caregiver_visit_notesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('caregiver_visit_notes_loading'), child: Semantics(label: 'caregiver_visit_notes_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('caregiver_visit_notes_screen'),
                    child: Column(
                      children: [
                        CaregiverVisitNotesHeaderSection(data: state.data),
                        CaregiverVisitNotesClientContextSection(data: state.data),
                        CaregiverVisitNotesNotesFormSection(data: state.data),
                        CaregiverVisitNotesNotesHistorySection(data: state.data),
                        CaregiverVisitNotesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
