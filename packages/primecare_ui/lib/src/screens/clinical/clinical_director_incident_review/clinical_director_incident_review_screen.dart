import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_director_incident_review_screen_controller.dart';
import 'sections/clinical_director_incident_review_header_section.dart';
import 'sections/clinical_director_incident_review_filter_bar_section.dart';
import 'sections/clinical_director_incident_review_data_table_section.dart';
import 'sections/clinical_director_incident_review_pagination_section.dart';
import 'sections/clinical_director_incident_review_action_bar_section.dart';


class ClinicalDirectorIncidentReviewScreen extends ConsumerWidget {
  const ClinicalDirectorIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinical_director_incident_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClinicalDirectorIncidentReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(clinical_director_incident_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('clinical_director_incident_review_loading'), child: Semantics(label: 'clinical_director_incident_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('clinical_director_incident_review_screen'),
                    child: Column(
                      children: [
                        ClinicalDirectorIncidentReviewHeaderSection(data: state.data),
                        ClinicalDirectorIncidentReviewFilterBarSection(data: state.data),
                        ClinicalDirectorIncidentReviewDataTableSection(data: state.data),
                        ClinicalDirectorIncidentReviewPaginationSection(data: state.data),
                        ClinicalDirectorIncidentReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
