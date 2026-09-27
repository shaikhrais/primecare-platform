import 'package:flutter/material.dart';

class FranchiseOwnerBranchOverviewDataTableSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const FranchiseOwnerBranchOverviewDataTableSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'franchise_owner_branch_overview_data_table_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Data Table Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
