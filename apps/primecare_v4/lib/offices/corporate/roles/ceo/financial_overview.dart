import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:primecare_v4/providers/dynamic_page_providers.dart';
import '../../../../office/components/page_template.dart';
import '../../../../office/components/clinical_glass_panel.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../providers/dashboard_providers.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FinancialOverviewView extends ConsumerWidget {
  const FinancialOverviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return PageTemplate(
      title: 'Institutional Financial Performance',
      subtitle: 'Overview and analytical breakdown for Institutional Financial Performance.',
      headerIcon: LucideIcons.landmark,
      actions: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.download, size: 16),
          label: const Text('Export Ledger'),
          style: FilledButton.styleFrom(
            backgroundColor: PrimeCareTheme.emeraldTeal,
            foregroundColor: Colors.white,
          ),
        ),
      ],
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP KPI METRICS
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = constraints.maxWidth > 1200
                    ? (constraints.maxWidth - 48) / 4
                    : (constraints.maxWidth > 600
                        ? (constraints.maxWidth - 16) / 2
                        : constraints.maxWidth);
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: KpiStatCard(
                        title: 'Activity Level',
                        value: 'High',
                        icon: LucideIcons.trendingUp,
                        iconColor: PrimeCareTheme.emeraldTeal,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: KpiStatCard(
                        title: 'Pending Items',
                        value: '12',
                        icon: LucideIcons.clock,
                        iconColor: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: KpiStatCard(
                        title: 'System Sync',
                        value: 'Active',
                        icon: LucideIcons.refreshCcw,
                        iconColor: PrimeCareTheme.navyIndigo,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: KpiStatCard(
                        title: 'Alerts',
                        value: '0',
                        icon: LucideIcons.alertTriangle,
                        iconColor: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // LISTINGS / LEDGER
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClinicalGlassPanel(
                    title: 'Financial Performance Ledger',
                    icon: LucideIcons.server,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final dataAsync = ref.watch(
                          dynamicPageProvider(
                            'officeFinancialOverviewView',
                          ),
                        );
                        return dataAsync.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (e, st) => Text('Error: $e'),
                          data: (items) {
                            if (items.isEmpty) {
                              return Text(
                                'No records found.',
                                style: TextStyle(
                                  color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.6),
                                ),
                              );
                            }
                            return Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: items.map((item) {
                                return Column(
                                  children: [
                                    _buildLedgerRow(
                                      LucideIcons.code,
                                      item['title'] ?? 'Record',
                                      item['status'] ?? 'Active',
                                      PrimeCareTheme.emeraldTeal,
                                    ),
                                    Divider(
                                      color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.1),
                                      height: 24,
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
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: ClinicalGlassPanel(
                    title: 'Change Log',
                    icon: LucideIcons.history,
                    child: Column(
                      children: [
                        AuditLogTile(
                          title: 'Update Triggered',
                          subtitle: 'Automated policy sync.',
                          timestamp: '1 Hr Ago',
                          icon: LucideIcons.history,
                          iconColor: PrimeCareTheme.emeraldTeal,
                        ),
                        Divider(
                          color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.1),
                          height: 16,
                        ),
                        AuditLogTile(
                          title: 'Audit Warning',
                          subtitle: 'Item requires review.',
                          timestamp: '3 Hrs Ago',
                          icon: LucideIcons.alertTriangle,
                          iconColor: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
              color: statusColor.withValues(alpha: 0.1),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: PrimeCareTheme.navyIndigo.withValues(alpha: 0.6), 
                    fontSize: 12
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            key: const Key('data-status-id=corporate-ceo-financial-action-1'),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor.withValues(alpha: 0.1),
              foregroundColor: statusColor,
              elevation: 0,
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }
}
