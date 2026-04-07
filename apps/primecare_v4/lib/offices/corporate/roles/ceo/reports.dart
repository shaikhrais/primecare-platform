import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CeoReportsScreen extends StatelessWidget {
  const CeoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Executive Reports Library',
      subtitle: 'Board decks, investor relations packets, and historical annual reports.',
      kpiCards: const [
        KPIConfig(label: 'Published Decks', value: '24', trend: 'Q3 Pending', color: Colors.blue),
        KPIConfig(label: 'Data Rooms', value: '2', trend: 'Active', color: Colors.green),
        KPIConfig(label: 'Analyst Models', value: '14', trend: 'Updated', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Document Vault', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Secure, searchable list of highly confidential executive reports...'),
            ],
          ),
        ),
      ],
    );
  }
}
