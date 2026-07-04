import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/audit_review_header_section.dart';
import 'sections/audit_review_filter_bar_section.dart';
import 'sections/audit_review_data_table_section.dart';
import 'sections/audit_review_pagination_section.dart';
import 'sections/audit_review_action_bar_section.dart';

class AuditReviewScreen extends StatelessWidget {
  const AuditReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'audit_review',
      title: 'AuditReviewScreen',
      child: Column(
        children: const [
          const AuditReviewHeaderSection(),
          const AuditReviewFilterBarSection(),
          const AuditReviewDataTableSection(),
          const AuditReviewPaginationSection(),
          const AuditReviewActionBarSection(),
        ],
      ),
    );
  }
}
