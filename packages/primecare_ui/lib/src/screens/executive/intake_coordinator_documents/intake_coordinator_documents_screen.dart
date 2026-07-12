import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_documents_screen_controller.dart';
import 'sections/intake_coordinator_documents_header_section.dart';
import 'sections/intake_coordinator_documents_content_summary_section.dart';
import 'sections/intake_coordinator_documents_primary_content_section.dart';
import 'sections/intake_coordinator_documents_action_bar_section.dart';


class IntakeCoordinatorDocumentsScreen extends ConsumerWidget {
  const IntakeCoordinatorDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intake_coordinator_documentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IntakeCoordinatorDocuments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(intake_coordinator_documentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('intake_coordinator_documents_loading'), child: Semantics(label: 'intake_coordinator_documents_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('intake_coordinator_documents_screen'),
                    child: Column(
                      children: [
                        IntakeCoordinatorDocumentsHeaderSection(data: state.data),
                        IntakeCoordinatorDocumentsContentSummarySection(data: state.data),
                        IntakeCoordinatorDocumentsPrimaryContentSection(data: state.data),
                        IntakeCoordinatorDocumentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
