import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/medication_reconciliation_tool_header_section.dart';
import 'sections/medication_reconciliation_tool_content_summary_section.dart';
import 'sections/medication_reconciliation_tool_primary_content_section.dart';
import 'sections/medication_reconciliation_tool_action_bar_section.dart';

class MedicationReconciliationToolScreen extends StatelessWidget {
  const MedicationReconciliationToolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'medication_reconciliation_tool',
      title: 'Medication Reconciliation Tool',
      child: Column(
        children: const [
          const MedicationReconciliationToolHeaderSection(),
          const MedicationReconciliationToolContentSummarySection(),
          const MedicationReconciliationToolPrimaryContentSection(),
          const MedicationReconciliationToolActionBarSection(),
        ],
      ),
    );
  }
}
