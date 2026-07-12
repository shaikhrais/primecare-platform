import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_visit_notes_screen_controller.dart';
import 'sections/psw_visit_notes_header_section.dart';
import 'sections/psw_visit_notes_client_context_section.dart';
import 'sections/psw_visit_notes_notes_form_section.dart';
import 'sections/psw_visit_notes_notes_history_section.dart';
import 'sections/psw_visit_notes_action_bar_section.dart';


class VisitNotesScreen extends ConsumerWidget {
  const VisitNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_visit_notesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Visit Notes'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_visit_notesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_visit_notes_loading'), child: Semantics(label: 'psw_visit_notes_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_visit_notes_screen'),
                    child: Column(
                      children: [
                        PswVisitNotesHeaderSection(data: state.data),
                        PswVisitNotesClientContextSection(data: state.data),
                        PswVisitNotesNotesFormSection(data: state.data),
                        PswVisitNotesNotesHistorySection(data: state.data),
                        PswVisitNotesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswVisitNotesScreen = VisitNotesScreen;
