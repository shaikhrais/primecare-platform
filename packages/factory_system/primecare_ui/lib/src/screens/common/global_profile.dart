import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/shared/page_template.dart';
import 'package:primecare_ui/src/design_system/clinical_glass.dart';
import 'package:primecare_ui/src/components/audit_log_tile.dart';

class GlobalProfileScreen extends ConsumerWidget {
  const GlobalProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(
      dashboardMetricsProvider(CommonRoutes.globalProfile),
    );

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (metrics) => PageTemplate(
        title: 'User Institutional Profile',
        subtitle:
            'Overview and analytical breakdown for User Institutional Profile.',
        icon: Icons.person,
        kpis: const [
          KPICardData(
            title: 'Component Title',
            value: 'High',
            icon: Icons.show_chart,
            color: Colors.teal,
          ),
          KPICardData(
            title: 'Component Title',
            value: '12',
            icon: Icons.pending_actions,
            color: Colors.orange,
          ),
          KPICardData(
            title: 'Component Title',
            value: 'Active',
            icon: Icons.sync,
            color: Colors.indigo,
          ),
          KPICardData(
            title: 'Component Title',
            value: '0',
            icon: Icons.notification_important,
            color: Colors.red,
          ),
        ],
        mainContent: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Institutional Profile Ledger',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClinicalGlass(
                      padding: const EdgeInsets.all(24),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final dataAsync = ref.watch(
                            dynamicPageProvider('officeGlobalProfileScreen'),
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
                                  style: TextStyle(color: Colors.blueGrey),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: items.map((item) {
                                  return Column(
                                    children: [
                                      _buildLedgerRow(
                                        Icons.api,
                                        item['title'] ?? 'Record',
                                        item['status'] ?? 'Active',
                                        Colors.teal,
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClinicalGlass(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const AuditLogTile(
                            title: 'Component Title',
                            subtitle: 'Automated policy sync.',
                            timestamp: '1 Hr Ago',
                            icon: Icons.history,
                            iconColor: Colors.teal,
                          ),
                          const Divider(
                            color: Colors.blueGrey,
                            height: 16,
                            thickness: 0.1,
                          ),
                          const AuditLogTile(
                            title: 'Component Title',
                            subtitle: 'Item requires review.',
                            timestamp: '3 Hrs Ago',
                            icon: Icons.warning,
                            iconColor: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            key: const Key('data-status-id=shared-global-global-action-1'),
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
