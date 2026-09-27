import 'package:flutter/material.dart';

class FamilyOverviewPaginationSection extends StatelessWidget {
  const FamilyOverviewPaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('family_overview_pagination-section'),
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
