import 'package:flutter/material.dart';

class TerritoryExpansionManagerSiteSelectionContentSummarySection extends StatelessWidget {
  const TerritoryExpansionManagerSiteSelectionContentSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('territory_expansion_manager_site_selection_content_summary-section'),
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
