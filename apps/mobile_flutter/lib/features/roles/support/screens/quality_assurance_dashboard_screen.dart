import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class QualityAssuranceDashboardScreen extends StatelessWidget {
  const QualityAssuranceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: 'Quality Assurance Dashboard'),
      body: Center(
        child: Text('Quality Assurance view coming soon...'),
      ),
    );
  }
}
