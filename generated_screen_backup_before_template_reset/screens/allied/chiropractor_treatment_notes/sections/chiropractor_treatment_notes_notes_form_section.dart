import 'package:flutter/material.dart';

class ChiropractorTreatmentNotesNotesFormSection extends StatelessWidget {
  const ChiropractorTreatmentNotesNotesFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('chiropractor_treatment_notes_notes_form-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Notes Form Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
