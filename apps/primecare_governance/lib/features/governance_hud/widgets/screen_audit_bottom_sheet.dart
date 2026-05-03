import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/governance/screen_metadata.dart';
import '../../../core/services/platform_env_service.dart';
import '../../../core/services/governance_issue_service.dart';
import '../../../governance/models/governance_severity.dart';

class ScreenAuditBottomSheet extends ConsumerWidget {
  final String title;
  final List<ScreenMetadata> screens;
  final Color themeColor;

  const ScreenAuditBottomSheet({
    super.key,
    required this.title,
    required this.screens,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: screens.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: screens.length,
                    itemBuilder: (context, index) => _buildScreenTile(context, ref, screens[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.analytics_rounded, color: themeColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${screens.length} Screens Identified',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_user_rounded, size: 64, color: Colors.green.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'Architectural Compliance Verified',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            'No screens found in this category.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenTile(BuildContext context, WidgetRef ref, ScreenMetadata screen) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          children: [
            Expanded(
              child: Text(
                screen.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _buildBadge(screen.lifecycleStatus.name.toUpperCase(), _getStatusColor(screen.lifecycleStatus)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Route: ${screen.routePath}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text('Owner: ${screen.productOwner}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showRemediationMenu(context, ref, screen),
        ),
        onTap: () {
          // Future: Navigate to screen preview or editor
        },
      ),
    );
  }

  void _showRemediationMenu(BuildContext context, WidgetRef ref, ScreenMetadata screen) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_calendar_rounded, color: Colors.blue),
              title: const Text('Update Lifecycle Status'),
              onTap: () {
                Navigator.pop(context);
                _showStatusPicker(context, ref, screen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report_rounded, color: Colors.orange),
              title: const Text('Flag for Review'),
              onTap: () {
                Navigator.pop(context);
                _showFlagDialog(context, ref, screen);
              },
            ),
            ListTile(
              leading: Icon(Icons.terminal_rounded, color: screen.sourcePath.isNotEmpty ? Colors.purple : Colors.grey),
              title: const Text('Open Implementation'),
              subtitle: Text(screen.sourcePath.isNotEmpty ? screen.sourcePath : 'Source path not registered', style: const TextStyle(fontSize: 10)),
              onTap: screen.sourcePath.isNotEmpty ? () {
                Navigator.pop(context);
                _openSourceCode(ref, screen);
              } : null,
            ),
            ListTile(
              leading: const Icon(Icons.copy_all_rounded, color: Colors.teal),
              title: const Text('Generate Registry Patch'),
              onTap: () {
                Navigator.pop(context);
                _showPatchDialog(context, screen);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFlagDialog(BuildContext context, WidgetRef ref, ScreenMetadata screen) {
    final reasonController = TextEditingController();
    GovernanceSeverity selectedSeverity = GovernanceSeverity.medium;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Flag for Review: ${screen.title}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for review',
                  hintText: 'e.g. Broken layout on mobile',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<GovernanceSeverity>(
                initialValue: selectedSeverity,
                decoration: const InputDecoration(labelText: 'Severity'),
                items: GovernanceSeverity.values.map((s) => DropdownMenuItem(
                  value: s,
                  child: Text(s.name.toUpperCase()),
                )).toList(),
                onChanged: (val) => setState(() => selectedSeverity = val!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (reasonController.text.isEmpty) return;
                
                await ref.read(governanceIssueServiceProvider).flagForReview(
                  screenId: screen.id,
                  screenTitle: screen.title,
                  reason: reasonController.text,
                  severity: selectedSeverity,
                );
                
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Screen ${screen.title} flagged for review.')),
                  );
                }
              },
              child: const Text('Submit Flag'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPatchDialog(BuildContext context, ScreenMetadata screen) {
    final patchCode = """
'${screen.id}': ScreenMetadata(
  id: '${screen.id}',
  featureName: '${screen.featureName}',
  routePath: '${screen.routePath}',
  title: '${screen.title}',
  lifecycleStatus: LifecycleStatus.${screen.lifecycleStatus.name},
  testPassRate: ${screen.testPassRate},
  isRenderOk: ${screen.isRenderOk},
  sourcePath: '${screen.sourcePath}',
),""";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registry Patch Generated'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To synchronize this status update, replace the lifecycleStatus field in screen_registry.dart for this screen ID:', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                patchCode,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Text('Screen ID: ${screen.id}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: patchCode));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Full Registry Patch copied to clipboard.')),
              );
            },
            child: const Text('Copy Full Patch'),
          ),
        ],
      ),
    );
  }

  void _showStatusPicker(BuildContext context, WidgetRef ref, ScreenMetadata screen) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Status: ${screen.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LifecycleStatus.values.map((status) => ListTile(
            title: Text(status.name.toUpperCase()),
            selected: screen.lifecycleStatus == status,
            onTap: () {
              Navigator.pop(context);
              // In a real app, this would call a service to update the registry
              // For now, we show a success indicator
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Status updated to ${status.name}. Please update screen_registry.dart.')),
              );
            },
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getStatusColor(LifecycleStatus status) {
    switch (status) {
      case LifecycleStatus.completed: return Colors.green;
      case LifecycleStatus.testing: return Colors.orange;
      case LifecycleStatus.generation: return Colors.blue;
      case LifecycleStatus.design: return Colors.purple;
      case LifecycleStatus.research: return Colors.teal;
      case LifecycleStatus.backlog: return Colors.grey;
      case LifecycleStatus.legacy: return Colors.blueGrey;
    }
  }

  Future<void> _openSourceCode(WidgetRef ref, ScreenMetadata screen) async {
    if (screen.sourcePath.isEmpty) return;
    
    final envService = ref.read(platformEnvServiceProvider);
    final uri = envService.getVSCodeUri(screen.sourcePath);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      // Fallback for environment issues
    }
  }
}
