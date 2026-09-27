import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/care_plan_review_header_section.dart';
import 'sections/care_plan_review_filter_bar_section.dart';
import 'sections/care_plan_review_data_table_section.dart';
import 'sections/care_plan_review_pagination_section.dart';
import 'sections/care_plan_review_action_bar_section.dart';

class CarePlanReviewScreen extends StatelessWidget {
  const CarePlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'care_plan_review',
      title: 'CarePlanReviewScreen',
      child: Column(
        children: const [
          const CarePlanReviewHeaderSection(),
          const CarePlanReviewFilterBarSection(),
          const CarePlanReviewDataTableSection(),
          const CarePlanReviewPaginationSection(),
          const CarePlanReviewActionBarSection(),
        ],
      ),
    );
  }
}
