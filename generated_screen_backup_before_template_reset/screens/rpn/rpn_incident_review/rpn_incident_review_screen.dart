import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_incident_review_header_section.dart';
import 'sections/rpn_incident_review_filter_bar_section.dart';
import 'sections/rpn_incident_review_data_table_section.dart';
import 'sections/rpn_incident_review_pagination_section.dart';
import 'sections/rpn_incident_review_action_bar_section.dart';

class RpnIncidentReviewScreen extends StatelessWidget {
  const RpnIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_incident_review',
      title: 'RpnIncidentReviewScreen',
      child: Column(
        children: const [
          const RpnIncidentReviewHeaderSection(),
          const RpnIncidentReviewFilterBarSection(),
          const RpnIncidentReviewDataTableSection(),
          const RpnIncidentReviewPaginationSection(),
          const RpnIncidentReviewActionBarSection(),
        ],
      ),
    );
  }
}
