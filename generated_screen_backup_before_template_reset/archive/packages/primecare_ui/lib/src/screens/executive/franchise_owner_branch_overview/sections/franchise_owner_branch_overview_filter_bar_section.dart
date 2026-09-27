import 'package:flutter/material.dart';

class FranchiseOwnerBranchOverviewFilterBarSection extends StatelessWidget {
  const FranchiseOwnerBranchOverviewFilterBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('franchise_owner_branch_overview_filter_bar-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Filter Bar Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
