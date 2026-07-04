import 'package:flutter/material.dart';

class RpnPatientChartingHeaderSection extends StatelessWidget {
  const RpnPatientChartingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rpn_patient_charting_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
