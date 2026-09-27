import 'package:flutter/material.dart';

class TerritorySalesManagerFieldActivityPrimaryContentSection extends StatelessWidget {
  const TerritorySalesManagerFieldActivityPrimaryContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('territory_sales_manager_field_activity_primary_content-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Primary Content Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
