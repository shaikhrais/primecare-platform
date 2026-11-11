import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';

class ClinicalReferencePrimaryContentSection extends StatelessWidget {
  const ClinicalReferencePrimaryContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('clinical_reference_primary_content-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PrimeText('Primary Content Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
