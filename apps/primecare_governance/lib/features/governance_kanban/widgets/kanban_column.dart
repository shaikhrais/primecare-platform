import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/governance/screen_work_item.dart';
import '../providers/kanban_provider.dart';
import 'kanban_card.dart';

class KanbanColumn extends ConsumerWidget {
  final String title;
  final String status;
  final List<ScreenWorkItem> items;

  const KanbanColumn({
    super.key,
    required this.title,
    required this.status,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return DragTarget<ScreenWorkItem>(
      onWillAcceptWithDetails: (details) => details.data.status != status,
      onAcceptWithDetails: (details) {
        ref.read(kanbanProvider.notifier).moveItem(details.data.serialNo, status);
      },
      builder: (context, candidateData, rejectedData) {
        final isOver = candidateData.isNotEmpty;
        
        return Container(
          width: 300,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: isOver ? theme.dividerColor.withValues(alpha: 0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isOver ? [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.2),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ] : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${items.length}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const Spacer(),
                    if (status == 'pending')
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () {
                          // In a real app, show a dialog
                          ref.read(kanbanProvider.notifier).addNewItem(
                            title: 'New Automated Screen',
                            app: 'primecare_admin',
                            module: 'Finance',
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Register New Screen',
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return KanbanCard(item: items[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'backlog':
        return Colors.grey;
      case 'in-progress':
        return Colors.blue;
      case 'verified':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
