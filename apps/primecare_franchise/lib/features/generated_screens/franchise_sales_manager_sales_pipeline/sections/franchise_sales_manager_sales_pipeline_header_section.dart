import 'package:flutter/material.dart';

class FranchiseSalesManagerSalesPipelineHeaderSection extends StatelessWidget {
  const FranchiseSalesManagerSalesPipelineHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('franchise_sales_manager_sales_pipeline_header-section'),
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
