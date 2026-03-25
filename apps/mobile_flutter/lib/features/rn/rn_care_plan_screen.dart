import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RnCarePlanScreen extends StatelessWidget {
  const RnCarePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Care Plan Architect')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Medication Frequency',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const MedicationFrequencyPicker(),
            const SizedBox(height: 24),
            const ClinicalInterventionFormGroup(),
            const SizedBox(height: 24),
            const Text(
              'Attending RN Signature',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const DigitalSignaturePad(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: PrimeButton(label: 'LOCK PLAN & DEPLOY', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
