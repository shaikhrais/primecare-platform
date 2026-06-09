// Governance - Category: view | Purpose: UI Screen component rendering the Psw Task List workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswTaskListState {
  final List<Map<String, dynamic>> tasks;

  const PswTaskListState({required this.tasks});

  PswTaskListState copyWith({List<Map<String, dynamic>>? tasks}) {
    return PswTaskListState(tasks: tasks ?? this.tasks);
  }
}

// --- Controller ---
class PswTaskListController extends StateNotifier<PswTaskListState> {
  final Ref _ref;
  PswTaskListController(this._ref)
      : super(const PswTaskListState(
          tasks: [
            {'id': '1', 'title': 'Morning Vitals check', 'done': false, 'desc': 'Check blood pressure & glucose levels.'},
            {'id': '2', 'title': 'Meal Prep - Lunch', 'done': false, 'desc': 'Prepare a low-sodium lunch.'},
            {'id': '3', 'title': 'Range of motion Exercises', 'done': false, 'desc': 'Complete physiotherapy exercises.'},
          ],
        ));

  void toggleTask(String id) {
    final updated = state.tasks.map((t) {
      if (t['id'] == id) {
        return {...t, 'done': !(t['done'] as bool)};
      }
      return t;
    }).toList();
    state = state.copyWith(tasks: updated);
    
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/task/list',
        eventType: 'updateTaskStatus',
        metadata: {'id': id},
      );
    } catch (_) {}
  }
}

final pswTaskListControllerProvider = StateNotifierProvider<PswTaskListController, PswTaskListState>((ref) {
  return PswTaskListController(ref);
});

// --- View ---
class PswTaskListScreen extends GovernedConsumerWidget {
  const PswTaskListScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswTaskListControllerProvider);
    final controller = ref.read(pswTaskListControllerProvider.notifier);

    return Semantics(
      label: 'data-cy:tasklist-btn-add',
      container: true,
      child: Scaffold(
        key: const Key('tasklist-btn-add'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Shift Task Checklist',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswtasklist-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswtasklist-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checklist Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Checklist Tasks', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ...state.tasks.map((t) => CheckboxListTile(
                        key: Key('tasklist-btn-update-${t['id']}'),
                        title: Text(t['title']?.toString() ?? '', style: theme.typography.bodyMedium.copyWith(decoration: (t['done'] as bool? ?? false) ? TextDecoration.lineThrough : null)),
                        subtitle: Text(t['desc']?.toString() ?? '', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                        value: t['done'] as bool? ?? false,
                        onChanged: (_) => controller.toggleTask(t['id']?.toString() ?? ''),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
