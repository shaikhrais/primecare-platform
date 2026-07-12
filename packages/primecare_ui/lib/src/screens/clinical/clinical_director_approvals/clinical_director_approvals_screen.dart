import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_director_approvals_screen_controller.dart';
import 'sections/clinical_director_approvals_header_section.dart';
import 'sections/clinical_director_approvals_content_summary_section.dart';
import 'sections/clinical_director_approvals_primary_content_section.dart';
import 'sections/clinical_director_approvals_action_bar_section.dart';


class ClinicalDirectorApprovalsScreen extends ConsumerWidget {
  const ClinicalDirectorApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_director_approvalsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalDirectorApprovals'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_director_approvalsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_director_approvals_loading'), child: Semantics(label: 'clinical_director_approvals_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_director_approvals_screen'),
                    child: Column(
                      children: [
                        ClinicalDirectorApprovalsHeaderSection(data: state.data),
                        ClinicalDirectorApprovalsContentSummarySection(data: state.data),
                        ClinicalDirectorApprovalsPrimaryContentSection(data: state.data),
                        ClinicalDirectorApprovalsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
