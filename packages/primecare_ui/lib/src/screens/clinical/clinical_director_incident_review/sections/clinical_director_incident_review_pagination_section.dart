import 'package:flutter/material.dart';

class ClinicalDirectorIncidentReviewPaginationSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const ClinicalDirectorIncidentReviewPaginationSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'clinical_director_incident_review_pagination_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Pagination Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
