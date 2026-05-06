import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/governance/screen_work_item.dart';
import '../providers/kanban_provider.dart';

class KanbanCard extends ConsumerWidget {
  final ScreenWorkItem item;

  const KanbanCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Draggable<ScreenWorkItem>(
      data: item,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.8,
          child: _buildCard(context, theme, ref, isDragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildCard(context, theme, ref),
      ),
      child: _buildCard(context, theme, ref),
    );
  }

  Widget _buildCard(BuildContext context, ThemeData theme, WidgetRef ref, {bool isDragging = false}) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          if (isDragging)
            BoxShadow(
              color: _getPriorityColor(item.priority).withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(item.priority).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getPriorityLabel(item.priority),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getPriorityColor(item.priority),
                  ),
                ),
              ),
              const Spacer(),
              if (item.stitchProject != null)
                const Icon(Icons.architecture, size: 14, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.notes,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.folder_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.targetApp,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              if (item.category != null) ...[
                const SizedBox(width: 8),
                Text(
                  item.category!,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ],
          ),
          if (item.status == 'pending' || item.status == 'verified') ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (item.status == 'pending')
                  TextButton.icon(
                    onPressed: () => ref.read(kanbanProvider.notifier).initiateHydration(item),
                    icon: const Icon(Icons.bolt, size: 16),
                    label: const Text('HYDRATE', style: TextStyle(fontSize: 10)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                if (item.status == 'verified' && item.routePath != null)
                  TextButton.icon(
                    onPressed: () {
                      // Navigate to the verified screen
                      // context.go(item.routePath!);
                    },
                    icon: const Icon(Icons.launch, size: 16),
                    label: const Text('LAUNCH', style: TextStyle(fontSize: 10)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'CRITICAL';
      case 2:
        return 'HIGH';
      case 3:
        return 'NORMAL';
      default:
        return 'LOW';
    }
  }
}
