import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_documents_screen_controller.dart';
import 'sections/psw_documents_header_section.dart';
import 'sections/psw_documents_content_summary_section.dart';
import 'sections/psw_documents_primary_content_section.dart';
import 'sections/psw_documents_action_bar_section.dart';


class Documents extends ConsumerWidget {
  const Documents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_documentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Documents'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_documentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_documents_loading'), child: Semantics(label: 'psw_documents_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_documents_screen'),
                    child: Column(
                      children: [
                        PswDocumentsHeaderSection(data: state.data),
                        PswDocumentsContentSummarySection(data: state.data),
                        PswDocumentsPrimaryContentSection(data: state.data),
                        PswDocumentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswDocumentsScreen = Documents;
