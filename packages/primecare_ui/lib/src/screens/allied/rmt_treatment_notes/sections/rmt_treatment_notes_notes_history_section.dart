import 'package:flutter/material.dart';

class RmtTreatmentNotesNotesHistorySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RmtTreatmentNotesNotesHistorySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'rmt_treatment_notes_notes_history_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Notes History Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
