import 'package:flutter/material.dart';

class RpnIncidentReviewDataTableSection extends StatelessWidget {
  const RpnIncidentReviewDataTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rpn_incident_review_data_table-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Data Table Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
