import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';

class PrimeCareHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PrimeCareHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'prime_care_header_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Header Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            PrimeStatusText('Clinical Care Operations Status.', tone: PrimeStatusTone.muted),
          ],
        ),
      ),
    );
  }
}
