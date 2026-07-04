import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/incident_review_header_section.dart';
import 'sections/incident_review_filter_bar_section.dart';
import 'sections/incident_review_data_table_section.dart';
import 'sections/incident_review_pagination_section.dart';
import 'sections/incident_review_action_bar_section.dart';

class IncidentReviewScreen extends StatelessWidget {
  const IncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'incident_review',
      title: 'IncidentReviewScreen',
      child: Column(
        children: const [
          const IncidentReviewHeaderSection(),
          const IncidentReviewFilterBarSection(),
          const IncidentReviewDataTableSection(),
          const IncidentReviewPaginationSection(),
          const IncidentReviewActionBarSection(),
        ],
      ),
    );
  }
}
