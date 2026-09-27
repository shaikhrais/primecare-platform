import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/access_review_certifier_header_section.dart';
import 'sections/access_review_certifier_filter_bar_section.dart';
import 'sections/access_review_certifier_data_table_section.dart';
import 'sections/access_review_certifier_pagination_section.dart';
import 'sections/access_review_certifier_action_bar_section.dart';

class AccessReviewCertifierScreen extends StatelessWidget {
  const AccessReviewCertifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'access_review_certifier',
      title: 'Access Review Certifier',
      child: Column(
        children: const [
          const AccessReviewCertifierHeaderSection(),
          const AccessReviewCertifierFilterBarSection(),
          const AccessReviewCertifierDataTableSection(),
          const AccessReviewCertifierPaginationSection(),
          const AccessReviewCertifierActionBarSection(),
        ],
      ),
    );
  }
}
