import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:primecare_v4/providers/dynamic_page_providers.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/page_template.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class ComplianceTrackingView extends ConsumerWidget {
  const ComplianceTrackingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (metrics) => PageTemplate(
        title: 'Global Compliance & Regulatory Tracking',
        subtitle: 'Overview and analytical breakdown for Global Compliance & Regulatory Tracking.',
        kpiCards: [
          _buildKpiCard('Activity Level', 'High', LucideIcons.activity, AppTheme.emeraldTeal),
          _buildKpiCard('Pending Items', '12', LucideIcons.listTodo, AppTheme.amberWarning),
          _buildKpiCard('System Sync', 'Active', LucideIcons.refreshCcw, AppTheme.navyIndigo),
          _buildKpiCard('Alerts', '0', LucideIcons.bellRing, Colors.redAccent),
        ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tracking Ledger',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClinicalGlassPanel(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final dataAsync = ref.watch(
                            dynamicPageProvider('officeComplianceTrackingView'),
                          );
                          return dataAsync.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (e, st) => Text('Error: $e'),
                            data: (items) {
                              if (items.isEmpty) {
                                return const Text(
                                  'No records found.',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontFamily: 'Inter',
                                  ),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: items.map((item) {
                                  return Column(
                                    children: [
                                      _buildLedgerRow(
                                        LucideIcons.fileText,
                                        item['title'] ?? 'Record',
                                        item['status'] ?? 'Active',
                                        AppTheme.emeraldTeal,
                                      ),
                                      const Divider(
                                        color: Colors.blueGrey,
                                        height: 24,
                                        thickness: 0.1,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            },
                          );
                        },
                      ),
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
                  Text(
                    'Change Log',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClinicalGlassPanel(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildAuditLogTile(
                            'Update Triggered',
                            'Automated policy sync.',
                            '1 Hr Ago',
                            LucideIcons.history,
                            AppTheme.emeraldTeal,
                          ),
                          const Divider(
                            color: Colors.blueGrey,
                            height: 16,
                            thickness: 0.1,
                          ),
                          _buildAuditLogTile(
                            'Audit Warning',
                            'Item requires review.',
                            '3 Hrs Ago',
                            LucideIcons.alertTriangle,
                            AppTheme.amberWarning,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return ClinicalGlassPanel(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+0.0%',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLedgerRow(
    IconData icon,
    String title,
    String subtitle,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            key: const Key(
              'data-status-id=corporate-compliance-compliance-action-1',
            ),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor.withOpacity(0.1),
              foregroundColor: statusColor,
              elevation: 0,
            ),
            child: const Text(
              'View',
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLogTile(
    String title,
    String subtitle,
    String timestamp,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Text(
            timestamp,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

