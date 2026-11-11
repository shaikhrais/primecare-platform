// Governance - Category: view | Purpose: Core implementation file for the Governance Issue Table platform logic.
import 'package:primecare_ui/primecare_ui.dart' show PrimeIcon, PrimeIconButton;
import 'package:url_launcher/url_launcher.dart';
import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter_core/flutter_core.dart';
import '../../core/services/platform_env_service.dart';
import '../services/registry_patch_engine.dart';

class GovernanceIssueTable extends ConsumerWidget {
  final List<PlatformAuditIssue> issues;

  const GovernanceIssueTable({super.key, required this.issues});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(platformEnvServiceProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              Colors.grey.withValues(alpha: 0.05),
            ),
            columnSpacing: 24,
            columns: [
              DataColumn(label: PrimeText('governance.issueTable.severity'.tr())),
              DataColumn(label: PrimeText('governance.issueTable.category'.tr())),
              DataColumn(label: PrimeText('governance.issueTable.screen'.tr())),
              DataColumn(label: PrimeText('governance.issueTable.issue'.tr())),
              DataColumn(
                label: PrimeText('governance.issueTable.suggestedFix'.tr()),
              ),
              DataColumn(label: PrimeText('governance.issueTable.owner'.tr())),
              DataColumn(label: PrimeText('governance.issueTable.actions'.tr())),
            ],
            rows: issues
                .map(
                  (issue) => DataRow(
                    cells: [
                      DataCell(_buildSeverityBadge(issue.severity)),
                      DataCell(
                        PrimeText(
                          issue.category.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimeText(
                              issue.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            PrimeText(
                              issue.routePath,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 250,
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
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        PrimeText(
                          issue.metadata['owner'] ?? 'Unassigned',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (issue.metadata['sourcePath'] != null)
                              PrimeIconButton(key: const Key('governance_issue_table_iconbutton_button_1'),
                                icon: const PrimeIcon(Icons.code, size: 18),
                                tooltip: 'Open in VS Code',
                                onPressed: () async {
                                  final uri = env.getVSCodeUri(
                                    issue.metadata['sourcePath']!,
                                  );
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                              ),
                            if (issue.metadata['fixProperty'] != null)
                              PrimeIconButton(key: const Key('governance_issue_table_iconbutton_button_2'),
                                icon: const PrimeIcon(
                                  Icons.auto_fix_high_rounded,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                tooltip: 'Auto-Fix Registry',
                                onPressed: () async {
                                  final success =
                                      await RegistryPatchEngine.applyFix(
                                        PlatformEnvService.projectRoot,
                                        issue,
                                        issue.metadata['fixProperty']!,
                                        issue.metadata['fixValue']!,
                                      );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: PrimeText(
                                          success
                                              ? 'governance.issueTable.fixSuccess'
                                                    .tr(
                                                      args: [
                                                        issue.metadata['fixProperty']
                                                            .toString(),
                                                        issue.screenId,
                                                      ],
                                                    )
                                              : 'governance.issueTable.fixFailed'
                                                    .tr(args: [issue.screenId]),
                                        ),
                                        backgroundColor: success
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    );
                                  }
                                },
                              ),
                            PrimeIconButton(key: const Key('governance_issue_table_iconbutton_button_3'),
                              icon: const PrimeIcon(
                                Icons.build,
                                size: 18,
                                color: Colors.blue,
                              ),
                              tooltip: 'Manual Remediate',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: PrimeText(
                                      'governance.issueTable.remediationInitiated'
                                          .tr(args: [issue.title]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSeverityBadge(AuditSeverity severity) {
    Color color;
    switch (severity) {
      case AuditSeverity.critical:
        color = Colors.red;
        break;
      case AuditSeverity.high:
        color = Colors.orange;
        break;
      case AuditSeverity.medium:
        color = Colors.amber;
        break;
      case AuditSeverity.low:
        color = Colors.blue;
        break;
      case AuditSeverity.info:
        color = Colors.teal;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: PrimeText(
        severity.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
