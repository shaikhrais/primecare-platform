import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_reviews_header_section.dart';
import 'sections/quality_assurance_reviews_filter_bar_section.dart';
import 'sections/quality_assurance_reviews_data_table_section.dart';
import 'sections/quality_assurance_reviews_pagination_section.dart';
import 'sections/quality_assurance_reviews_action_bar_section.dart';

class QualityAssuranceReviewsScreen extends StatelessWidget {
  const QualityAssuranceReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_reviews',
      title: 'Quality Assurance Reviews',
      child: Column(
        children: const [
          const QualityAssuranceReviewsHeaderSection(),
          const QualityAssuranceReviewsFilterBarSection(),
          const QualityAssuranceReviewsDataTableSection(),
          const QualityAssuranceReviewsPaginationSection(),
          const QualityAssuranceReviewsActionBarSection(),
        ],
      ),
    );
  }
}
