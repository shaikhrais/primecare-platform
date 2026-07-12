import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'claims_processing_screen_controller.dart';
import 'sections/claims_processing_header_section.dart';
import 'sections/claims_processing_content_summary_section.dart';
import 'sections/claims_processing_primary_content_section.dart';
import 'sections/claims_processing_action_bar_section.dart';


class ClaimsProcessingScreen extends ConsumerWidget {
  const ClaimsProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(claims_processingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClaimsProcessing'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(claims_processingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('claims_processing_loading'), child: Semantics(label: 'claims_processing_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('claims_processing_screen'),
                    child: Column(
                      children: [
                        ClaimsProcessingHeaderSection(data: state.data),
                        ClaimsProcessingContentSummarySection(data: state.data),
                        ClaimsProcessingPrimaryContentSection(data: state.data),
                        ClaimsProcessingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
