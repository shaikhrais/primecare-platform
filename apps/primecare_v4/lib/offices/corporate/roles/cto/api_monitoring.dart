import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ApiMonitoringScreen extends StatelessWidget {
  const ApiMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      header: PageHeader(
        title: 'API Monitoring & Traffic',
        subtitle:
            'Track API request volume, latency, endpoint usage, and token limits.',
        actions: [
          _buildActionIconButton(context, LucideIcons.download, 'Export Logs'),
          const SizedBox(width: 12),
          _buildActionIconButton(context, LucideIcons.webhook, 'Webhooks'),
        ],
      ),
      content: [
        _buildKPIs(context),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildTrafficChart(context),
                  const SizedBox(height: 24),
                  _buildEndpointsTable(context),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildLatencyPercentiles(context),
                  const SizedBox(height: 24),
                  _buildTokenUsage(context),
                ],
              ),
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
            'Total Requests (24h)',
            '1.4M',
            LucideIcons.gitPullRequest,
            '+12% vs yesterday',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Global Error Rate',
            '0.04%',
            LucideIcons.alertOctagon,
            'Mainly 401s, 429s',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Avg Latency',
            '85ms',
            LucideIcons.activity,
            'Optimal (<100ms)',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Active Tokens',
            '8,421',
            LucideIcons.key,
            'Valid active keys',
            Colors.blue,
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

  Widget _buildTrafficChart(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'API Request Volume (Last 12 hours)',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  _buildStatusIndicator(
                    'Success (2xx)',
                    PrimeCareTheme.emeraldTeal,
                  ),
                  const SizedBox(width: 16),
                  _buildStatusIndicator('Client Error (4xx)', Colors.orange),
                  const SizedBox(width: 16),
                  _buildStatusIndicator('Server Error (5xx)', Colors.redAccent),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Placeholder for an actual Line Chart
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBarGroup(120, 5, 0),
                    const Spacer(),
                    _buildBarGroup(140, 8, 2),
                    const Spacer(),
                    _buildBarGroup(155, 12, 0),
                    const Spacer(),
                    _buildBarGroup(180, 20, 5),
                    const Spacer(),
                    _buildBarGroup(210, 45, 10),
                    const Spacer(),
                    _buildBarGroup(190, 30, 2),
                    const Spacer(),
                    _buildBarGroup(130, 10, 0),
                    const Spacer(),
                    _buildBarGroup(140, 5, 0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarGroup(
    double successHeight,
    double clientHeight,
    double serverHeight,
  ) {
    return SizedBox(
      width: 32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (serverHeight > 0)
            Container(
              width: 32,
              height: serverHeight,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          if (clientHeight > 0)
            Container(
              width: 32,
              height: clientHeight,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Container(
            width: 32,
            height: successHeight,
            decoration: BoxDecoration(
              color: PrimeCareTheme.emeraldTeal,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildEndpointsTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top 5 Endpoints by Volume',
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
                DataColumn(label: Text('Method')),
                DataColumn(label: Text('Endpoint path')),
                DataColumn(label: Text('Requests')),
                DataColumn(label: Text('Error %')),
                DataColumn(label: Text('Avg Time')),
              ],
              rows: [
                _buildDataRow(
                  'GET',
                  '/api/v4/emr/patients',
                  '412,045',
                  '0.01%',
                  '45ms',
                ),
                _buildDataRow(
                  'POST',
                  '/api/v4/auth/verify',
                  '285,120',
                  '0.12%',
                  '110ms',
                ),
                _buildDataRow(
                  'GET',
                  '/api/v4/schedules/today',
                  '194,500',
                  '0.00%',
                  '32ms',
                ),
                _buildDataRow(
                  'POST',
                  '/api/v4/sync/offline',
                  '145,210',
                  '1.45%',
                  '350ms',
                ),
                _buildDataRow(
                  'GET',
                  '/api/v4/billing/invoices',
                  '85,420',
                  '0.05%',
                  '210ms',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String method,
    String endpoint,
    String reqs,
    String errors,
    String time,
  ) {
    Color methodColor = method == 'GET'
        ? Colors.blue
        : (method == 'POST' ? PrimeCareTheme.emeraldTeal : Colors.orange);
    return DataRow(
      cells: [
        DataCell(
          Text(
            method,
            style: TextStyle(color: methodColor, fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          Text(endpoint, style: const TextStyle(fontFamily: 'monospace')),
        ),
        DataCell(Text(reqs)),
        DataCell(
          Text(
            errors,
            style: TextStyle(
              color: double.parse(errors.replaceAll('%', '')) > 1.0
                  ? Colors.orange
                  : Colors.white70,
            ),
          ),
        ),
        DataCell(Text(time, style: const TextStyle(color: Colors.white70))),
      ],
    );
  }

  Widget _buildLatencyPercentiles(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.listEnd, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Latency Percentiles',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildPercentileRow(
            'p50 (Median)',
            '45ms',
            PrimeCareTheme.emeraldTeal,
            0.45,
          ),
          const SizedBox(height: 16),
          _buildPercentileRow('p90', '110ms', Colors.blue, 0.65),
          const SizedBox(height: 16),
          _buildPercentileRow('p95', '240ms', Colors.orange, 0.85),
          const SizedBox(height: 16),
          _buildPercentileRow('p99', '850ms', Colors.redAccent, 1.0),
        ],
      ),
    );
  }

  Widget _buildPercentileRow(
    String label,
    String value,
    Color color,
    double widthRatio,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * widthRatio,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTokenUsage(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.shieldCheck,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Token Usage & Limits',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildUsageRow('Auth Vault Service', '84%', Colors.orange),
          const SizedBox(height: 16),
          _buildUsageRow(
            'Postmark SMTP Relay',
            '42%',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildUsageRow(
            'Stripe Payment Gateway',
            '12%',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildUsageRow('Twilio SMS Gateway', '98%', Colors.redAccent),
          const Divider(color: Colors.white12, height: 32),
          Center(
            child: Text(
              'Rate limits are assessed per minute.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageRow(String service, String percent, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(LucideIcons.keySquare, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              service,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            percent,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
