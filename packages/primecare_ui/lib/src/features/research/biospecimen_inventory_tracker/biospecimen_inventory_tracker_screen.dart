import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/biospecimen_inventory_tracker_header_section.dart';
import 'sections/biospecimen_inventory_tracker_content_summary_section.dart';
import 'sections/biospecimen_inventory_tracker_primary_content_section.dart';
import 'sections/biospecimen_inventory_tracker_action_bar_section.dart';

class BiospecimenInventoryTrackerScreen extends StatelessWidget {
  const BiospecimenInventoryTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'biospecimen_inventory_tracker',
      title: 'Biospecimen Inventory Tracker',
      child: Column(
        children: const [
          const BiospecimenInventoryTrackerHeaderSection(),
          const BiospecimenInventoryTrackerContentSummarySection(),
          const BiospecimenInventoryTrackerPrimaryContentSection(),
          const BiospecimenInventoryTrackerActionBarSection(),
        ],
      ),
    );
  }
}
