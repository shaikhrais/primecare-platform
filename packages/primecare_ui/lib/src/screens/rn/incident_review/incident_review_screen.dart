import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'incident_review_screen_controller.dart';
import 'sections/incident_review_header_section.dart';
import 'sections/incident_review_filter_bar_section.dart';
import 'sections/incident_review_data_table_section.dart';
import 'sections/incident_review_pagination_section.dart';
import 'sections/incident_review_action_bar_section.dart';


class IncidentReviewScreen extends ConsumerWidget {
  const IncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(incident_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IncidentReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(incident_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('incident_review_loading'), child: Semantics(label: 'incident_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('incident_review_screen'),
                    child: Column(
                      children: [
                        IncidentReviewHeaderSection(data: state.data),
                        IncidentReviewFilterBarSection(data: state.data),
                        IncidentReviewDataTableSection(data: state.data),
                        IncidentReviewPaginationSection(data: state.data),
                        IncidentReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
