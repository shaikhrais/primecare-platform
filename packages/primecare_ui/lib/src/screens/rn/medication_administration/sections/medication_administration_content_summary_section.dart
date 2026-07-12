import 'package:flutter/material.dart';

class MedicationAdministrationContentSummarySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const MedicationAdministrationContentSummarySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'medication_administration_content_summary_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Content Summary Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
