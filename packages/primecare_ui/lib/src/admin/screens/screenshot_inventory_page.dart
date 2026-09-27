// Governance - Category: screen | Purpose: Admin Screenshot Inventory Page.
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/kpi_card.dart';

class ScreenshotInventoryPage extends StatelessWidget {
  const ScreenshotInventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder values; in real implementation would query DB.
    const totalScreens = 0;
    const generated = 0;
    const missing = 0;
    const failed = 0;
    const cfoScreens = 0;
    const duplicate = 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Screenshot Inventory')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // KPI cards
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                KpiCard(label: 'Total Screens', value: totalScreens, icon: Icons.grid_view),
                KpiCard(label: 'Generated', value: generated, icon: Icons.check_circle),
                KpiCard(label: 'Missing', value: missing, icon: Icons.error),
                KpiCard(label: 'Failed', value: failed, icon: Icons.warning),
                KpiCard(label: 'CFO Screens', value: cfoScreens, icon: Icons.business),
                KpiCard(label: 'Duplicates', value: duplicate, icon: Icons.copy),
              ],
            ),
            const SizedBox(height: 24),
            // Gallery placeholder
            Text('Screenshots Gallery', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // In a full implementation this would be a GridView.builder showing thumbnails.
            Center(child: Text('Gallery view coming soon...')),
          ],
        ),
      ),
    );
  }
}
