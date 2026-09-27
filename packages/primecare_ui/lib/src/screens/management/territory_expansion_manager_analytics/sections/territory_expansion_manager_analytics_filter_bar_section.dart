import 'package:flutter/material.dart';

class TerritoryExpansionManagerAnalyticsFilterBarSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const TerritoryExpansionManagerAnalyticsFilterBarSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'territory_expansion_manager_analytics_filter_bar_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Filter Bar Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
