import 'package:primecare_ui/primecare_ui.dart';
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
          color: context.theme.colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PrimeActionPalette.of(context, PrimeActionTone.success).border),
        ),
        child: Center(
          child: Column(
            children: [
              PrimeIcon(Icons.check_circle_outline, color: PrimeActionPalette.of(context, PrimeActionTone.success).onBase, size: 48),
              SizedBox(height: 16),
              PrimeText(
                'Zero-Error Platform Parity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              PrimeText(
                'All backend controllers and network endpoints are in 100% parity with the registry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.theme.colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeActionPalette.of(context, PrimeActionTone.error).border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              PrimeActionPalette.of(context, PrimeActionTone.error).surface,
            ),
            columnSpacing: 24,
            columns: const [
              DataColumn(label: PrimeText('Subsystem')),
              DataColumn(label: PrimeText('Type')),
              DataColumn(label: PrimeText('Identity')),
              DataColumn(label: PrimeText('Message')),
              DataColumn(label: PrimeText('Recommendation')),
              DataColumn(label: PrimeText('Action')),
            ],
            rows: issues.map((issue) {
              final metadata = issue.metadata;
              final isRogue = metadata['type'] == 'rogue_endpoint';
              final color = isRogue ? PrimeActionPalette.of(context, PrimeActionTone.error).accent : PrimeActionPalette.of(context, PrimeActionTone.warning).accent;
              final identity = isRogue ? (metadata['path'] ?? 'N/A') : (metadata['endpoint'] ?? metadata['id'] ?? 'N/A');

              return DataRow(
                cells: [
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: PrimeActionPalette.of(context, PrimeActionTone.primary).surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: PrimeText(
                        issue.subsystem.toUpperCase(),
                        style: TextStyle(
                          color: PrimeActionPalette.of(context, PrimeActionTone.primary).onSurface,
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
                        color: PrimeActionPalette.tintSurface(context, color),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: PrimeText(
                        (metadata['type'] ?? 'drift').toString().replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: PrimeActionPalette.onTint(context, color),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    PrimeText(
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
                      child: PrimeText(
                        issue.issue,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 250,
                      child: PrimeText(
                        issue.suggestion,
                        style: TextStyle(
                          fontSize: 12,
                          color: PrimeActionPalette.of(context, PrimeActionTone.primary).onBase,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    PrimeIconButton(key: const Key('network_parity_audit_table_iconbutton_button_1'),
                      icon: PrimeIcon(
                        issue.autoRemediable ? Icons.auto_fix_high : Icons.build,
                        color: PrimeActionPalette.of(context, PrimeActionTone.primary).onBase,
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
