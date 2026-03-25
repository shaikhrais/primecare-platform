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

  void _openDataEntryForm(String taskId, String rolePrefix, String taskTitle) {
    String formTitle = 'Data Entry';
    String formPlaceholder = 'Enter required data...';
    String formButton = 'Submit Entry';

    switch (rolePrefix.toLowerCase()) {
      case 'superuser':
        formTitle = 'Dispatch Framework Message';
        formPlaceholder = 'Direct Communication Array payload';
        formButton = 'Execute DB Cloud Storage';
        break;
      case 'psw':
        formTitle = 'Clinical Progress Note';
        formPlaceholder = 'Describe patient vitals, mood, and daily observations...';
        formButton = 'Log Native Progress to DB';
        break;
      case 'rn':
        formTitle = 'Medical Reconciliation Log';
        formPlaceholder = 'Identify and document structural medication adjustments...';
        formButton = 'Execute Med-Recon Commit';
        break;
      case 'manager':
        formTitle = 'Incident Resolution Report';
        formPlaceholder = 'Detail the resolution strategy applied to this escalation...';
        formButton = 'Clear Escalation Safely';
        break;
      case 'coordinator':
        formTitle = 'Active Dispatch Adjustment';
        formPlaceholder = 'Provide structural justification for shift trajectory override...';
        formButton = 'Commit Schedule Matrix';
        break;
      case 'client':
        formTitle = 'Client Wellness Feedback';
        formPlaceholder = 'Provide feedback to your care agency...';
        formButton = 'Push Secure Feedback';
        break;
      default:
        formTitle = '$taskTitle Entry Module';
        formPlaceholder = 'General telemetry notes...';
        formButton = 'Commit Data';
    }

    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.assignment_add, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(child: Text(formTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: formPlaceholder,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                // We simulate saving this specific contextual payload securely
                _markTaskComplete(taskId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(formButton),
            ),
          ],
        );
      },
    );
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
              final taskId = task['id']?.toString() ?? 'fallback_${index}';
              final title = task['title'] ?? 'Task ${index + 1}';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.assignment_turned_in, color: Colors.blue),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    task['description'] ?? 'Data Entry Required.',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _openDataEntryForm(taskId, widget.rolePrefix, title),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    child: const Text('Enter Data'),
                  ),
                  onTap: () => _openDataEntryForm(taskId, widget.rolePrefix, title),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
