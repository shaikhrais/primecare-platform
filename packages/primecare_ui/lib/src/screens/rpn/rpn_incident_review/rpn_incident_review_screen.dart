import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_incident_review_screen_controller.dart';
import 'sections/rpn_incident_review_header_section.dart';
import 'sections/rpn_incident_review_filter_bar_section.dart';
import 'sections/rpn_incident_review_data_table_section.dart';
import 'sections/rpn_incident_review_pagination_section.dart';
import 'sections/rpn_incident_review_action_bar_section.dart';


class RpnIncidentReviewScreen extends ConsumerWidget {
  const RpnIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_incident_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnIncidentReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_incident_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_incident_review_loading'), child: Semantics(label: 'rpn_incident_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_incident_review_screen'),
                    child: Column(
                      children: [
                        RpnIncidentReviewHeaderSection(data: state.data),
                        RpnIncidentReviewFilterBarSection(data: state.data),
                        RpnIncidentReviewDataTableSection(data: state.data),
                        RpnIncidentReviewPaginationSection(data: state.data),
                        RpnIncidentReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
