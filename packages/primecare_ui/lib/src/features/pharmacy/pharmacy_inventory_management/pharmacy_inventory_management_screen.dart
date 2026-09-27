import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/pharmacy_inventory_management_header_section.dart';
import 'sections/pharmacy_inventory_management_content_summary_section.dart';
import 'sections/pharmacy_inventory_management_primary_content_section.dart';
import 'sections/pharmacy_inventory_management_action_bar_section.dart';

class PharmacyInventoryManagementScreen extends StatelessWidget {
  const PharmacyInventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'pharmacy_inventory_management',
      title: 'Pharmacy Inventory Management',
      child: Column(
        children: const [
          const PharmacyInventoryManagementHeaderSection(),
          const PharmacyInventoryManagementContentSummarySection(),
          const PharmacyInventoryManagementPrimaryContentSection(),
          const PharmacyInventoryManagementActionBarSection(),
        ],
      ),
    );
  }
}
