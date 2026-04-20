import 'package:flutter/material.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PrimeWorkflowQueueItem {
  final String title;
  final IconData icon;
  final Color statusColor;
  final VoidCallback onTap;

  PrimeWorkflowQueueItem({
    required this.title,
    required this.icon,
    required this.statusColor,
    required this.onTap,
  });
}

class PrimeWorkflowQueueCard extends ConsumerWidget {
  final String title;
  final List<PrimeWorkflowQueueItem> tasks;

  const PrimeWorkflowQueueCard({
    super.key,
    required this.title,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: tasks.asMap().entries.map((entry) {
              final idx = entry.key;
              final task = entry.value;
              return Column(
                children: [
                  PrimeCareTaskRow(
                    icon: task.icon,
                    title: task.title,
                    statusColor: task.statusColor,
                    onTap: () {
                      ref
                          .read(executionGateProvider)
                          .passGate(
                            ExecutionGateCategory.navigationLayer,
                            'Workflow Task Tapped: ${task.title}',
                          );
                      task.onTap();
                    },
                  ),
                  if (idx < tasks.length - 1) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
