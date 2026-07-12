import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'documents_screen_controller.dart';
import 'sections/documents_header_section.dart';
import 'sections/documents_content_summary_section.dart';
import 'sections/documents_primary_content_section.dart';
import 'sections/documents_action_bar_section.dart';


class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentsControllerProvider);

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
                onPressed: () => ref.read(documentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('documents_loading'), child: Semantics(label: 'documents_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('documents_screen'),
                    child: Column(
                      children: [
                        DocumentsHeaderSection(data: state.data),
                        DocumentsContentSummarySection(data: state.data),
                        DocumentsPrimaryContentSection(data: state.data),
                        DocumentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
