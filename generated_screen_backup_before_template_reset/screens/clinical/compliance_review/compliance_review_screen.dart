import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_review_header_section.dart';
import 'sections/compliance_review_filter_bar_section.dart';
import 'sections/compliance_review_data_table_section.dart';
import 'sections/compliance_review_pagination_section.dart';
import 'sections/compliance_review_action_bar_section.dart';

class ComplianceReviewScreen extends StatelessWidget {
  const ComplianceReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_review',
      title: 'ComplianceReviewScreen',
      child: Column(
        children: const [
          const ComplianceReviewHeaderSection(),
          const ComplianceReviewFilterBarSection(),
          const ComplianceReviewDataTableSection(),
          const ComplianceReviewPaginationSection(),
          const ComplianceReviewActionBarSection(),
        ],
      ),
    );
  }
}
