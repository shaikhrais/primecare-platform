import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'drift_findings_screen_controller.dart';
import 'sections/drift_findings_header_section.dart';
import 'sections/drift_findings_content_summary_section.dart';
import 'sections/drift_findings_primary_content_section.dart';
import 'sections/drift_findings_action_bar_section.dart';


class DriftFindingsScreen extends ConsumerWidget {
  const DriftFindingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(drift_findingsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('DriftFindings'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(drift_findingsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('drift_findings_loading'), child: Semantics(label: 'drift_findings_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('drift_findings_screen'),
                    child: Column(
                      children: [
                        DriftFindingsHeaderSection(data: state.data),
                        DriftFindingsContentSummarySection(data: state.data),
                        DriftFindingsPrimaryContentSection(data: state.data),
                        DriftFindingsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
