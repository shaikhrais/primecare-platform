import 'package:flutter/material.dart';

class TherapistDashboardHeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'therapist_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text('Therapist Clinical Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
