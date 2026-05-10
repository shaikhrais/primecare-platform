import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/services/platform_env_service.dart';
import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../services/registry_patch_engine.dart';

class GovernanceIssueTable extends ConsumerWidget {
  final List<GovernanceIssue> issues;

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
              DataColumn(label: Text('governance.issueTable.severity'.tr())),
              DataColumn(label: Text('governance.issueTable.category'.tr())),
              DataColumn(label: Text('governance.issueTable.screen'.tr())),
              DataColumn(label: Text('governance.issueTable.issue'.tr())),
              DataColumn(
                label: Text('governance.issueTable.suggestedFix'.tr()),
              ),
              DataColumn(label: Text('governance.issueTable.owner'.tr())),
              DataColumn(label: Text('governance.issueTable.actions'.tr())),
            ],
            rows: issues
                .map(
                  (issue) => DataRow(
                    cells: [
                      DataCell(_buildSeverityBadge(issue.severity)),
                      DataCell(
                        Text(
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
                            Text(
                              issue.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
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
                          child: Text(
                            issue.message,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 250,
                          child: Text(
                            issue.fix,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(issue.owner, style: const TextStyle(fontSize: 12)),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (issue.sourcePath != null &&
                                issue.sourcePath!.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.code, size: 18),
                                tooltip: 'Open in VS Code',
                                onPressed: () async {
                                  final uri = env.getVSCodeUri(
                                    issue.sourcePath!,
                                  );
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                              ),
                            if (issue.fixProperty != null)
                              IconButton(
                                icon: const Icon(
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
                                        issue.fixProperty!,
                                        issue.fixValue!,
                                      );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          success
                                              ? 'governance.issueTable.fixSuccess'
                                                    .tr(
                                                      args: [
                                                        issue.fixProperty
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
                            IconButton(
                              icon: const Icon(
                                Icons.build,
                                size: 18,
                                color: Colors.blue,
                              ),
                              tooltip: 'Manual Remediate',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
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

  Widget _buildSeverityBadge(GovernanceSeverity severity) {
    Color color;
    switch (severity) {
      case GovernanceSeverity.critical:
        color = Colors.red;
        break;
      case GovernanceSeverity.high:
        color = Colors.orange;
        break;
      case GovernanceSeverity.medium:
        color = Colors.amber;
        break;
      case GovernanceSeverity.low:
        color = Colors.blue;
        break;
      case GovernanceSeverity.info:
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
      child: Text(
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
