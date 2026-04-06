import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SystemHealthScreen extends StatelessWidget {
  const SystemHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                            children: [
                                _buildServerLoad(context),
                                const SizedBox(height: 24),
                                _buildAPIMonitoring(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildDatabasePerformance(context),
                            const SizedBox(height: 24),
                            _buildRecentAlerts(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Health Diagnostics',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Real-time monitoring of infrastructure, servers, and database performance',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.refreshCcw, 'Refresh Data'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.settings, 'Configure Alerts'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildKPIUnit(context, 'System Uptime', '99.99%', LucideIcons.checkCircle, 'Last 30 Days', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Avg Response Time', '142ms', LucideIcons.activity, '-12ms improvement', Colors.blue)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Active Connections', '8,432', LucideIcons.network, 'Peak: 12k', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Error Rate', '0.04%', LucideIcons.alertTriangle, 'Threshold: 1.0%', Colors.orange)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String subtitle, Color color) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
            ),
           )
        ],
      ),
    );
  }

    Widget _buildServerLoad(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.server, color: Colors.blue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Server Infrastructure Load',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Expanded(child: _buildResourceMeter('CPU Utilization', 45, Colors.blue)),
                     const SizedBox(width: 24),
                     Expanded(child: _buildResourceMeter('Memory Usage', 78, Colors.orange)),
                     const SizedBox(width: 24),
                     Expanded(child: _buildResourceMeter('Disk I/O', 32, PrimeCareTheme.emeraldTeal)),
                ]
            ),
             const SizedBox(height: 24),
             _buildServerInstanceRow('us-east-1a (Primary)', 'Healthy', PrimeCareTheme.emeraldTeal, 42, 65),
             const SizedBox(height: 12),
             _buildServerInstanceRow('us-east-1b (Replica)', 'Healthy', PrimeCareTheme.emeraldTeal, 38, 60),
             const SizedBox(height: 12),
             _buildServerInstanceRow('eu-central-1 (Edge)', 'Warning: High Mem', Colors.orange, 55, 88),
          ],
        ),
      );
    }
    
    Widget _buildResourceMeter(String label, double percentage, Color color) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                         Text('${percentage.toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                    ]
                ),
                const SizedBox(height: 8),
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 8,
                    ),
                ),
            ]
        );
    }

    Widget _buildServerInstanceRow(String name, String status, Color statusColor, int cpu, int mem) {
         return Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
                 color: Colors.white.withValues(alpha: 0.05),
                 borderRadius: BorderRadius.circular(8),
             ),
             child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                     Row(
                         children: [
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                            const SizedBox(width: 12),
                             Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                         ]
                     ),
                      Row(
                          children: [
                              Text('CPU: $cpu%', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                              const SizedBox(width: 16),
                              Text('Mem: $mem%', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                              const SizedBox(width: 16),
                             Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                          ]
                      )
                 ]
             )
         );
    }

  Widget _buildAPIMonitoring(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'API Gateway Status',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Endpoint')),
                DataColumn(label: Text('Req/min')),
                DataColumn(label: Text('Latency (P95)')),
                DataColumn(label: Text('Error Rate')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _buildDataRow('/api/v4/auth', '1,245', '110ms', '0.01%', PrimeCareTheme.emeraldTeal, 'Live'),
                _buildDataRow('/api/v4/emr/sync', '4,521', '245ms', '0.05%', PrimeCareTheme.emeraldTeal, 'Live'),
                _buildDataRow('/api/v4/billing/process', '320', '850ms', '1.20%', Colors.orange, 'Degraded'),
                _buildDataRow('/api/v4/analytics', '850', '420ms', '0.00%', PrimeCareTheme.emeraldTeal, 'Live'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String endpoint, String reqs, String latency, String errors, Color statusColor, String status) {
    return DataRow(
      cells: [
        DataCell(Text(endpoint, style: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'monospace'))),
        DataCell(Text(reqs)),
        DataCell(Text(latency, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(errors, style: TextStyle(color: errors != '0.00%' ? Colors.orange : Colors.white70))),
        DataCell(
             Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                     color: statusColor.withValues(alpha: 0.2),
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                 ),
                 child: Text(
                     status,
                     style: TextStyle(
                         color: statusColor,
                         fontSize: 12,
                         fontWeight: FontWeight.w500,
                     ),
                 ),
             )
        ),
      ],
    );
  }

    Widget _buildDatabasePerformance(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.database, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'PostgreSQL Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildDbStat('Query Latency', '14ms', '+2ms'),
            const Divider(color: Colors.white12, height: 24),
             _buildDbStat('Cache Hit Ratio', '98.5%', 'Optimal'),
            const Divider(color: Colors.white12, height: 24),
             _buildDbStat('Active Locks', '12', 'Normal'),
             const Divider(color: Colors.white12, height: 24),
             _buildDbStat('Transaction Rate', '450/sec', 'Peak Hour'),
          ],
        ),
      );
    }
    
    Widget _buildDbStat(String label, String value, String note) {
        return Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                 Text(label, style: const TextStyle(color: Colors.white70)),
                 Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                         Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                         Text(note, style: const TextStyle(color: PrimeCareTheme.emeraldTeal, fontSize: 11)),
                     ]
                 )
             ]
        );
    }

    Widget _buildRecentAlerts(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.bellRing, color: Colors.orange, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Active Alerts',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildAlertItem('High Memory Usage on eu-central-1', '10m ago', Colors.orange),
                    const Divider(color: Colors.white12, height: 24),
                    _buildAlertItem('Billing API Latency Spike (>800ms)', '22m ago', Colors.redAccent),
                    const Divider(color: Colors.white12, height: 24),
                    _buildAlertItem('Scheduled Maintenance Tonight', '2h ago', Colors.blue),
                ]
            )
        );
    }

    Widget _buildAlertItem(String message, String time, Color iconColor) {
        return Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Icon(LucideIcons.alertCircle, color: iconColor, size: 16),
                 const SizedBox(width: 12),
                 Expanded(
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                             Text(message, style: const TextStyle(color: Colors.white, fontSize: 13)),
                             const SizedBox(height: 4),
                             Text(time, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                         ]
                     )
                 )
             ]
        );
    }
}
