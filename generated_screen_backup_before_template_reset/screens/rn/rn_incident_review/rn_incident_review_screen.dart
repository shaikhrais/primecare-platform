import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_incident_review_header_section.dart';
import 'sections/rn_incident_review_filter_bar_section.dart';
import 'sections/rn_incident_review_data_table_section.dart';
import 'sections/rn_incident_review_pagination_section.dart';
import 'sections/rn_incident_review_action_bar_section.dart';

class RnIncidentReviewScreen extends StatelessWidget {
  const RnIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_incident_review',
      title: 'RnIncidentReviewScreen',
      child: Column(
        children: const [
          const RnIncidentReviewHeaderSection(),
          const RnIncidentReviewFilterBarSection(),
          const RnIncidentReviewDataTableSection(),
          const RnIncidentReviewPaginationSection(),
          const RnIncidentReviewActionBarSection(),
        ],
      ),
    );
  }
}
