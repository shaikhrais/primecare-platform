import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_documents_screen_controller.dart';
import 'sections/patient_documents_header_section.dart';
import 'sections/patient_documents_content_summary_section.dart';
import 'sections/patient_documents_primary_content_section.dart';
import 'sections/patient_documents_action_bar_section.dart';


class PatientDocumentsScreen extends ConsumerWidget {
  const PatientDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_documentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientDocuments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_documentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_documents_loading'), child: Semantics(label: 'patient_documents_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_documents_screen'),
                    child: Column(
                      children: [
                        PatientDocumentsHeaderSection(data: state.data),
                        PatientDocumentsContentSummarySection(data: state.data),
                        PatientDocumentsPrimaryContentSection(data: state.data),
                        PatientDocumentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
