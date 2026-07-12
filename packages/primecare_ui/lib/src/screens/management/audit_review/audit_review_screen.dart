import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'audit_review_screen_controller.dart';
import 'sections/audit_review_header_section.dart';
import 'sections/audit_review_filter_bar_section.dart';
import 'sections/audit_review_data_table_section.dart';
import 'sections/audit_review_pagination_section.dart';
import 'sections/audit_review_action_bar_section.dart';


class AuditReviewScreen extends ConsumerWidget {
  const AuditReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audit_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('AuditReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(audit_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('audit_review_loading'), child: Semantics(label: 'audit_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('audit_review_screen'),
                    child: Column(
                      children: [
                        AuditReviewHeaderSection(data: state.data),
                        AuditReviewFilterBarSection(data: state.data),
                        AuditReviewDataTableSection(data: state.data),
                        AuditReviewPaginationSection(data: state.data),
                        AuditReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
