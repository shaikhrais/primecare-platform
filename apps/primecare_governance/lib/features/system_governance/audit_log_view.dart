import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'audit_log_controller.dart';

class AuditLogView extends ConsumerWidget {
  const AuditLogView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(auditLogsProvider);

    return logsAsync.when(
      data: (logs) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: logs.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final log = logs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: log.action.contains('ERROR') ? Colors.red[100] : Colors.blue[100],
              child: Icon(
                log.action.contains('ERROR') ? Icons.error_outline : Icons.info_outline,
                color: log.action.contains('ERROR') ? Colors.red : Colors.blue,
              ),
            ),
            title: Text(log.action, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(log.details),
                const SizedBox(height: 4),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(log.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: log.isSynced 
              ? const Icon(Icons.cloud_done, color: Colors.green, size: 16)
              : const Icon(Icons.cloud_off, color: Colors.grey, size: 16),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error loading logs: $err')),
    );
  }
}
