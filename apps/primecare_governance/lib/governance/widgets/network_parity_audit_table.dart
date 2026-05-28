// Governance - Category: view | Purpose: Core implementation file for the Network Parity Audit Table platform logic.
import 'package:flutter_core/flutter_core.dart';
import '../../core/governance/governance_provider.dart';

class NetworkParityAuditTable extends ConsumerWidget {
  const NetworkParityAuditTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final governanceState = ref.watch(governanceProvider);
    final issues = governanceState.subsystemIssues;

    if (issues.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
        ),
        child: const Center(
          child: Column(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 48),
              SizedBox(height: 16),
              Text(
                'Zero-Error Platform Parity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'All backend controllers and network endpoints are in 100% parity with the registry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              Colors.red.withValues(alpha: 0.05),
            ),
            columnSpacing: 24,
            columns: const [
              DataColumn(label: Text('Subsystem')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Identity')),
              DataColumn(label: Text('Message')),
              DataColumn(label: Text('Recommendation')),
              DataColumn(label: Text('Action')),
            ],
            rows: issues.map((issue) {
              final metadata = issue.metadata;
              final isRogue = metadata['type'] == 'rogue_endpoint';
              final color = isRogue ? Colors.red : Colors.orange;
              final identity = isRogue ? (metadata['path'] ?? 'N/A') : (metadata['endpoint'] ?? metadata['id'] ?? 'N/A');

              return DataRow(
                cells: [
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        issue.subsystem.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (metadata['type'] ?? 'drift').toString().replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      identity,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 200,
                      child: Text(
                        issue.issue,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 250,
                      child: Text(
                        issue.suggestion,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    IconButton(key: const Key('network_parity_audit_table_iconbutton_button_1'), 
                      icon: Icon(
                        issue.autoRemediable ? Icons.auto_fix_high : Icons.build,
                        color: Colors.blue,
                        size: 20,
                      ),
                      onPressed: () => _remediate(ref, issue),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _remediate(WidgetRef ref, PlatformAuditIssue issue) {
    // Integration Hook: Trigger backend remediation
    ref.read(governanceProvider.notifier).executeRemoteAction('remediate_drift');
  }
}
