import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'care_plan_review_screen_controller.dart';
import 'sections/care_plan_review_header_section.dart';
import 'sections/care_plan_review_filter_bar_section.dart';
import 'sections/care_plan_review_data_table_section.dart';
import 'sections/care_plan_review_pagination_section.dart';
import 'sections/care_plan_review_action_bar_section.dart';


class CarePlanReviewScreen extends ConsumerWidget {
  const CarePlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(care_plan_reviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CarePlanReview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(care_plan_reviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('care_plan_review_loading'), child: Semantics(label: 'care_plan_review_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('care_plan_review_screen'),
                    child: Column(
                      children: [
                        CarePlanReviewHeaderSection(data: state.data),
                        CarePlanReviewFilterBarSection(data: state.data),
                        CarePlanReviewDataTableSection(data: state.data),
                        CarePlanReviewPaginationSection(data: state.data),
                        CarePlanReviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
