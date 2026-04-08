import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class RegionalBdmTasksScreen extends StatelessWidget {
  const RegionalBdmTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Daily Field Action Items',
      subtitle:
          'Track daily follow-ups, contract reviews, and scheduled field visits.',
      kpiCards: const [
        KPIConfig(
          label: 'Due Today',
          value: '12',
          trend: 'High Priority',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'Completed',
          value: '8',
          trend: 'Good Pace',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Overdue',
          value: '0',
          trend: 'Clear',
          color: Colors.blue,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Kanban Board',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Interactive lists: To Do, In Progress, Blocked, Done...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
