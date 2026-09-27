import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_care_plan_review_screen_controller.dart';
import 'sections/rn_care_plan_review_header_section.dart';
import 'sections/rn_care_plan_review_filter_bar_section.dart';
import 'sections/rn_care_plan_review_data_table_section.dart';
import 'sections/rn_care_plan_review_pagination_section.dart';
import 'sections/rn_care_plan_review_action_bar_section.dart';


class RnCarePlanReviewScreen extends ConsumerWidget {
  const RnCarePlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_care_plan_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnCarePlanReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_care_plan_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_care_plan_review_loading'), child: Semantics(label: 'rn_care_plan_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_care_plan_review_screen'),
                    child: Column(
                      children: [
                        RnCarePlanReviewHeaderSection(data: state.data),
                        RnCarePlanReviewFilterBarSection(data: state.data),
                        RnCarePlanReviewDataTableSection(data: state.data),
                        RnCarePlanReviewPaginationSection(data: state.data),
                        RnCarePlanReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
