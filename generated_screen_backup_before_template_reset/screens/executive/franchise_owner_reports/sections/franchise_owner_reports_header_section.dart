import 'package:flutter/material.dart';

class FranchiseOwnerReportsHeaderSection extends StatelessWidget {
  const FranchiseOwnerReportsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('franchise_owner_reports_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
