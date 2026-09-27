import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_care_plan_review_header_section.dart';
import 'sections/rpn_care_plan_review_filter_bar_section.dart';
import 'sections/rpn_care_plan_review_data_table_section.dart';
import 'sections/rpn_care_plan_review_pagination_section.dart';
import 'sections/rpn_care_plan_review_action_bar_section.dart';

class RpnCarePlanReviewScreen extends StatelessWidget {
  const RpnCarePlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_care_plan_review',
      title: 'RpnCarePlanReviewScreen',
      child: Column(
        children: const [
          const RpnCarePlanReviewHeaderSection(),
          const RpnCarePlanReviewFilterBarSection(),
          const RpnCarePlanReviewDataTableSection(),
          const RpnCarePlanReviewPaginationSection(),
          const RpnCarePlanReviewActionBarSection(),
        ],
      ),
    );
  }
}
