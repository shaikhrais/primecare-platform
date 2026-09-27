import 'package:flutter/material.dart';

class ComplianceOverviewPaginationSection extends StatelessWidget {
  const ComplianceOverviewPaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('compliance_overview_pagination-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Pagination Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
