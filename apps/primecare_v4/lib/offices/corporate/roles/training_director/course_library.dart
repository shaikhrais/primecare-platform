import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CourseLibraryScreen extends StatelessWidget {
  const CourseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Course Library',
      subtitle: 'Track uploaded SCORM modules and curriculum updates.',
      kpiCards: const [
        KPIConfig(label: 'Total Courses', value: '412', trend: 'Global Cat', color: Colors.blue),
        KPIConfig(label: 'New L30D', value: '14', trend: 'Added', color: Colors.green),
        KPIConfig(label: 'Outdated', value: '7', trend: 'Refactor Req', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Module Inventory', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Grid view of all internal educational assets, sortable by compliance tag, difficulty, and expiration date...'),
            ],
          ),
        ),
      ],
    );
  }
}
