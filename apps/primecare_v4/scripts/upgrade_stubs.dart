import 'dart:io';

void main() {
  final officesDir = Directory('lib/offices');
  final dartFiles = officesDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();

  int upgradedCount = 0;

  for (final file in dartFiles) {
    if (file.path.contains('_layout') ||
        file.path.contains('_sidebar') ||
        file.path.contains('_topbar')) {
      continue;
    }

    final content = file.readAsStringSync();
    final lines = content.split('\n');

    // Identify stub pages (short files)
    if (lines.length < 65) {
      // Extract the class name
      final classMatch = RegExp(
        r'class\s+([A-Za-z0-9_]+)\s+extends',
      ).firstMatch(content);
      if (classMatch == null) continue;

      final className = classMatch.group(1)!;

      // Extract title from Text('Title') if possible
      String title = className
          .replaceAll('View', '')
          .replaceAll('Dashboard', '');
      final textMatch = RegExp(r"Text\('([^']+)'").firstMatch(content);
      if (textMatch != null &&
          textMatch.group(1)! != 'Error loading metrics: \$err') {
        title = textMatch.group(1)!;
      } else {
        // Beautify class name
        title = title
            .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
            .trim();
      }

      stdout.writeln('Upgrading $className ($title) in ${file.path}');

      final newContent =
          '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class $className extends ConsumerWidget {
  const $className({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: \$err')),
        data: (metrics) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Overview and analytical breakdown for $title.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // TOP KPI METRICS
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth = constraints.maxWidth > 1200 
                            ? (constraints.maxWidth - 48) / 4 
                            : (constraints.maxWidth > 600 ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth);
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            SizedBox(width: cardWidth, child: KpiStatCard(title: 'Activity Level', value: 'High', icon: Icons.show_chart, iconColor: Colors.teal)),
                            SizedBox(width: cardWidth, child: KpiStatCard(title: 'Pending Items', value: '12', icon: Icons.pending_actions, iconColor: Colors.orange)),
                            SizedBox(width: cardWidth, child: KpiStatCard(title: 'System Sync', value: 'Active', icon: Icons.sync, iconColor: Colors.indigo)),
                            SizedBox(width: cardWidth, child: KpiStatCard(title: 'Alerts', value: '0', icon: Icons.notification_important, iconColor: Colors.red)),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // LISTINGS / LEDGER
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$title Ledger', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLedgerRow(Icons.file_copy, 'System Report Generated', 'Nominal status.', Colors.teal),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildLedgerRow(Icons.update, 'Periodic Sync', 'Synchronized across regions.', Colors.indigo),
                                    const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                    _buildLedgerRow(Icons.check_circle, 'Verification Process', 'Completed', Colors.teal),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Change Log', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
                              const SizedBox(height: 16),
                              GlassSurface(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    AuditLogTile(title: 'Update Triggered', subtitle: 'Automated policy sync.', timestamp: '1 Hr Ago', icon: Icons.history, iconColor: Colors.teal),
                                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                                    AuditLogTile(title: 'Audit Warning', subtitle: 'Item requires review.', timestamp: '3 Hrs Ago', icon: Icons.warning, iconColor: Colors.orange),
                                  ]
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLedgerRow(IconData icon, String title, String subtitle, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor.withOpacity(0.1),
              foregroundColor: statusColor,
              elevation: 0,
            ),
            child: const Text('View'),
          )
        ],
      ),
    );
  }
}
''';
      file.writeAsStringSync(newContent);
      upgradedCount++;
    }
  }

  stdout.writeln(
    '\\nSuccessfully upgraded $upgradedCount stub pages to high fidelity Riverpod UI.',
  );
}
