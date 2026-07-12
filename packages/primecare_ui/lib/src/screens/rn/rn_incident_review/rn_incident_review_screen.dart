import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_incident_review_screen_controller.dart';
import 'sections/rn_incident_review_header_section.dart';
import 'sections/rn_incident_review_filter_bar_section.dart';
import 'sections/rn_incident_review_data_table_section.dart';
import 'sections/rn_incident_review_pagination_section.dart';
import 'sections/rn_incident_review_action_bar_section.dart';


class RnIncidentReviewScreen extends ConsumerWidget {
  const RnIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_incident_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnIncidentReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_incident_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_incident_review_loading'), child: Semantics(label: 'rn_incident_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_incident_review_screen'),
                    child: Column(
                      children: [
                        RnIncidentReviewHeaderSection(data: state.data),
                        RnIncidentReviewFilterBarSection(data: state.data),
                        RnIncidentReviewDataTableSection(data: state.data),
                        RnIncidentReviewPaginationSection(data: state.data),
                        RnIncidentReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
