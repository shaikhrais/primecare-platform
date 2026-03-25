import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';

final universalTasksProvider = FutureProvider.family
    .autoDispose<List<dynamic>, String>((ref, rolePrefix) async {
      final response = await apiClient.get('/api/activities?role=$rolePrefix');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        return [];
      }
    });

class UniversalDailyTasksScreen extends ConsumerStatefulWidget {
  final String rolePrefix;
  const UniversalDailyTasksScreen({super.key, required this.rolePrefix});

  @override
  ConsumerState<UniversalDailyTasksScreen> createState() =>
      _UniversalDailyTasksScreenState();
}

class _UniversalDailyTasksScreenState
    extends ConsumerState<UniversalDailyTasksScreen> {
  Future<void> _markTaskComplete(String taskId) async {
    try {
      await apiClient.patch(
        '/api/activities/$taskId',
        {'status': 'completed'},
      );
      ref.invalidate(universalTasksProvider(widget.rolePrefix));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Task physically marked as complete gracefully natively.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to complete task securely: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncTasks = ref.watch(universalTasksProvider(widget.rolePrefix));

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.rolePrefix.toUpperCase()} Daily Tasks'),
      ),
      body: asyncTasks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading tasks organically: $err')),
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.green.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'All tasks completed for today!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.blue),
                  title: Text(
                    task['title'] ?? 'Task ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    task['description'] ?? 'Pending action required.',
                  ),
                  trailing: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    final taskId =
                        task['id']?.toString() ?? 'fallback_${index}';
                    _markTaskComplete(taskId);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
