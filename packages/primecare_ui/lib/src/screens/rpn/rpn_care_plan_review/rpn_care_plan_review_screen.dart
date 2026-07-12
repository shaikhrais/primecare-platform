import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_care_plan_review_screen_controller.dart';
import 'sections/rpn_care_plan_review_header_section.dart';
import 'sections/rpn_care_plan_review_filter_bar_section.dart';
import 'sections/rpn_care_plan_review_data_table_section.dart';
import 'sections/rpn_care_plan_review_pagination_section.dart';
import 'sections/rpn_care_plan_review_action_bar_section.dart';


class RpnCarePlanReviewScreen extends ConsumerWidget {
  const RpnCarePlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_care_plan_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnCarePlanReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_care_plan_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_care_plan_review_loading'), child: Semantics(label: 'rpn_care_plan_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_care_plan_review_screen'),
                    child: Column(
                      children: [
                        RpnCarePlanReviewHeaderSection(data: state.data),
                        RpnCarePlanReviewFilterBarSection(data: state.data),
                        RpnCarePlanReviewDataTableSection(data: state.data),
                        RpnCarePlanReviewPaginationSection(data: state.data),
                        RpnCarePlanReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
