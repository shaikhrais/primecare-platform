import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_incident_review_header_section.dart';
import 'sections/clinical_director_incident_review_filter_bar_section.dart';
import 'sections/clinical_director_incident_review_data_table_section.dart';
import 'sections/clinical_director_incident_review_pagination_section.dart';
import 'sections/clinical_director_incident_review_action_bar_section.dart';

class ClinicalDirectorIncidentReviewScreen extends StatelessWidget {
  const ClinicalDirectorIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_incident_review',
      title: 'ClinicalDirectorIncidentReviewScreen',
      child: Column(
        children: const [
          const ClinicalDirectorIncidentReviewHeaderSection(),
          const ClinicalDirectorIncidentReviewFilterBarSection(),
          const ClinicalDirectorIncidentReviewDataTableSection(),
          const ClinicalDirectorIncidentReviewPaginationSection(),
          const ClinicalDirectorIncidentReviewActionBarSection(),
        ],
      ),
    );
  }
}
