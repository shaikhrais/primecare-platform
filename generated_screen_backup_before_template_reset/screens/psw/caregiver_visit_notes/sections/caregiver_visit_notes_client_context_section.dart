import 'package:flutter/material.dart';

class CaregiverVisitNotesClientContextSection extends StatelessWidget {
  const CaregiverVisitNotesClientContextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('caregiver_visit_notes_client_context-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Client Context Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
