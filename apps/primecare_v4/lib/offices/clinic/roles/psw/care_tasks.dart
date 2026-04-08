import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PswCareTasksScreen extends StatelessWidget {
  const PswCareTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      title: 'Care Tasks',
      subtitle:
          'Checklist of specific interventions required for each client visit.',
      kpis: [],
      children: [],
    );
  }
}
