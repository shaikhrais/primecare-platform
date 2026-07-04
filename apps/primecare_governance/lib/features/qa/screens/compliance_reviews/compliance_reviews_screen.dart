import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_reviews_header_section.dart';
import 'sections/compliance_reviews_filter_bar_section.dart';
import 'sections/compliance_reviews_data_table_section.dart';
import 'sections/compliance_reviews_pagination_section.dart';
import 'sections/compliance_reviews_action_bar_section.dart';

class ComplianceReviewsScreen extends StatelessWidget {
  const ComplianceReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_reviews',
      title: 'Compliance Reviews',
      child: Column(
        children: const [
          const ComplianceReviewsHeaderSection(),
          const ComplianceReviewsFilterBarSection(),
          const ComplianceReviewsDataTableSection(),
          const ComplianceReviewsPaginationSection(),
          const ComplianceReviewsActionBarSection(),
        ],
      ),
    );
  }
}
