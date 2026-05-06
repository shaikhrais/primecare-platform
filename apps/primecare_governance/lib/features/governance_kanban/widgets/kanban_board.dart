import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kanban_provider.dart';
import 'kanban_column.dart';

class KanbanBoard extends ConsumerWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kanbanProvider);

    return SizedBox(
      height: 600,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          KanbanColumn(
            title: 'Architectural Backlog',
            status: 'backlog',
            items: state.backlog,
          ),
          KanbanColumn(
            title: 'Screen Hydration',
            status: 'in-progress',
            items: state.inProgress,
          ),
          KanbanColumn(
            title: 'Verified UI',
            status: 'verified',
            items: state.verified,
          ),
        ],
      ),
    );
  }
}
