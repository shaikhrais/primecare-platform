import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';

class PartnershipManagerReportsExportActionsSection extends StatelessWidget {
  const PartnershipManagerReportsExportActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('partnership_manager_reports_export_actions-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PrimeText('Export Actions Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
