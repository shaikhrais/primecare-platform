import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_care_plan_review_header_section.dart';
import 'sections/rn_care_plan_review_filter_bar_section.dart';
import 'sections/rn_care_plan_review_data_table_section.dart';
import 'sections/rn_care_plan_review_pagination_section.dart';
import 'sections/rn_care_plan_review_action_bar_section.dart';

class RnCarePlanReviewScreen extends StatelessWidget {
  const RnCarePlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_care_plan_review',
      title: 'RnCarePlanReviewScreen',
      child: Column(
        children: const [
          const RnCarePlanReviewHeaderSection(),
          const RnCarePlanReviewFilterBarSection(),
          const RnCarePlanReviewDataTableSection(),
          const RnCarePlanReviewPaginationSection(),
          const RnCarePlanReviewActionBarSection(),
        ],
      ),
    );
  }
}
