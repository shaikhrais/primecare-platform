import 'package:flutter/material.dart';

class FranchiseSalesManagerDiscoveryCallsContentSummarySection extends StatelessWidget {
  const FranchiseSalesManagerDiscoveryCallsContentSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('franchise_sales_manager_discovery_calls_content_summary-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Content Summary Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
