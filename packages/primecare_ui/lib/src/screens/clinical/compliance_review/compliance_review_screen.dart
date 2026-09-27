import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'compliance_review_screen_controller.dart';
import 'sections/compliance_review_header_section.dart';
import 'sections/compliance_review_filter_bar_section.dart';
import 'sections/compliance_review_data_table_section.dart';
import 'sections/compliance_review_pagination_section.dart';
import 'sections/compliance_review_action_bar_section.dart';


class ComplianceReviewScreen extends ConsumerWidget {
  const ComplianceReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compliance_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ComplianceReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(compliance_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('compliance_review_loading'), child: Semantics(label: 'compliance_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('compliance_review_screen'),
                    child: Column(
                      children: [
                        ComplianceReviewHeaderSection(data: state.data),
                        ComplianceReviewFilterBarSection(data: state.data),
                        ComplianceReviewDataTableSection(data: state.data),
                        ComplianceReviewPaginationSection(data: state.data),
                        ComplianceReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
