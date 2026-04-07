import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons/lucide_icons.dart';

class IntegrationsScreen extends StatelessWidget {
  const IntegrationsScreen({super.key});

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
                            _buildActivePartnerships(context),
                            const SizedBox(height: 24),
                            _buildWebhookDelivery(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildDataSyncLatency(context),
                            const SizedBox(height: 24),
                            _buildExternalAPICosts(context),
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
              '3rd Party Integrations & APIs',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage external vendor connections, webhooks, and sync latency.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.key, 'API Keys'),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.plus,
              'New Integration',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(
    BuildContext context,
    IconData icon,
    String tooltip,
  ) {
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
        Expanded(
          child: _buildKPIUnit(
            context,
            'Active Integrations',
            '14',
            LucideIcons.plug,
            'Across all suites',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Webhook Delivery Rate',
            '99.8%',
            LucideIcons.send,
            'Last 24 hours',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Total API Calls Out',
            '4.2M',
            LucideIcons.arrowUpRight,
            '+500k this month',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'API Errors',
            '0.12%',
            LucideIcons.alertTriangle,
            'Threshold: < 1%',
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildKPIUnit(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String subtitle,
    Color color,
  ) {
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
          ),
        ],
      ),
    );
  }

  Widget _buildActivePartnerships(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Partner Integrations',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Manage Configs',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 13,
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
                DataColumn(label: Text('Partner/Service')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Data Flow')),
                DataColumn(label: Text('Health')),
                DataColumn(label: Text('Avg Response')),
              ],
              rows: [
                _buildDataRow(
                  'Stripe Gateway',
                  'Payments',
                  'Bi-directional',
                  PrimeCareTheme.emeraldTeal,
                  'Healthy',
                  '45ms',
                ),
                _buildDataRow(
                  'Twilio SMS',
                  'Communications',
                  'Outbound Only',
                  PrimeCareTheme.emeraldTeal,
                  'Healthy',
                  '110ms',
                ),
                _buildDataRow(
                  'Epic EMR Sync',
                  'Clinical Data',
                  'Bi-directional',
                  Colors.orange,
                  'Degraded',
                  '1.4s',
                ),
                _buildDataRow(
                  'Checkr Backgrounds',
                  'HR/Staffing',
                  'Bi-directional',
                  PrimeCareTheme.emeraldTeal,
                  'Healthy',
                  '320ms',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String partner,
    String type,
    String flow,
    Color statusColor,
    String status,
    String responseTime,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(partner, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(type, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(flow)),
        DataCell(
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(responseTime)),
      ],
    );
  }

  Widget _buildWebhookDelivery(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.webhook, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Webhook Delivery Pipeline',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text(
                'View Dead Letter Queue',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildPipelineStage(
            'Event Intercepted',
            12450,
            PrimeCareTheme.emeraldTeal,
          ),
          Container(
            height: 20,
            width: 2,
            color: Colors.white12,
            margin: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
          ),
          _buildPipelineStage(
            'Payload Transformed',
            12450,
            PrimeCareTheme.emeraldTeal,
          ),
          Container(
            height: 20,
            width: 2,
            color: Colors.white12,
            margin: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
          ),
          _buildPipelineStage(
            'Dispatched to Endpoints',
            12430,
            Colors.orange,
          ), // 20 failed
          Container(
            height: 20,
            width: 2,
            color: Colors.white12,
            margin: const EdgeInsets.only(left: 18, top: 8, bottom: 8),
          ),
          _buildPipelineStage(
            'Acknowledged (200 OK)',
            12428,
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineStage(String name, int count, Color color) {
    return Row(
      children: [
        Icon(LucideIcons.checkCircle2, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$count msgs',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataSyncLatency(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.arrowRightLeft, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              Text(
                'Data Sync Latency',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSyncRow('Epic EMR Target', '1.4s', Colors.orange),
          const SizedBox(height: 16),
          _buildSyncRow(
            'Payroll ADP Push',
            '450ms',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildSyncRow(
            'Global Registry Replicate',
            '12ms',
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildSyncRow(String target, String latency, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          target,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Text(
          latency,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildExternalAPICosts(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.coins,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'External API Costs (MTD)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildCostLine('Twilio Transit', '\$842.10'),
          const SizedBox(height: 12),
          _buildCostLine('Mapbox / Haversine', '\$310.50'),
          const SizedBox(height: 12),
          _buildCostLine('Checkr Checks', '\$1,120.00'),
          const Divider(color: Colors.white12, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Provider Spend',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '\$2,272.60',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostLine(String service, String cost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          service,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Text(
          cost,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
