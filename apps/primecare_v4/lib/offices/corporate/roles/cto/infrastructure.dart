import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InfrastructureScreen extends StatelessWidget {
  const InfrastructureScreen({super.key});

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
                            _buildDataCenterMap(context),
                            const SizedBox(height: 24),
                            _buildContainerStatus(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildResourceCosts(context),
                            const SizedBox(height: 24),
                            _buildNetworkTopology(context),
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
              'Cloud Infrastructure',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage data centers, network topology, container deployments, and AWS costs.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(
              context,
              LucideIcons.cloudRain,
              'Simulate Failover',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.server,
              'Provision Instance',
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
            'Total Instances',
            '42',
            LucideIcons.server,
            'Across 3 Regions',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Docker Containers',
            '256',
            LucideIcons.box,
            '98% Healthy',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'VPC Network Traffic',
            '4.2 TB',
            LucideIcons.workflow,
            'Last 24h',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Est. Monthly Cost',
            '\$12,450',
            LucideIcons.badgeDollarSign,
            'On track (-5%)',
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

  Widget _buildDataCenterMap(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Data Center Regions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  _buildStatusIndicator('Healthy', PrimeCareTheme.emeraldTeal),
                  const SizedBox(width: 16),
                  _buildStatusIndicator('Degraded', Colors.orange),
                  const SizedBox(width: 16),
                  _buildStatusIndicator('Offline', Colors.red),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Placeholder for an actual map graphic
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    LucideIcons.globe,
                    size: 180,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                _buildRegionMarker(
                  context,
                  'us-east-1 (N. Virginia)',
                  40,
                  60,
                  true,
                ),
                _buildRegionMarker(context, 'us-west-2 (Oregon)', 30, 20, true),
                _buildRegionMarker(
                  context,
                  'eu-central-1 (Frankfurt)',
                  55,
                  120,
                  false,
                ),
              ],
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

  Widget _buildRegionMarker(
    BuildContext context,
    String name,
    double topOffset,
    double leftOffset,
    bool isHealthy,
  ) {
    return Positioned(
      top: topOffset, // Relative percentages in real app
      left: leftOffset,
      child: Column(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isHealthy ? PrimeCareTheme.emeraldTeal : Colors.orange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isHealthy
                      ? PrimeCareTheme.emeraldTeal.withValues(alpha: 0.5)
                      : Colors.orange.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerStatus(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kubernetes Pod Status',
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
                DataColumn(label: Text('Namespace')),
                DataColumn(label: Text('Cluster')),
                DataColumn(label: Text('Pods (Ready)')),
                DataColumn(label: Text('Restarts')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _buildDataRow(
                  'production-api',
                  'primecare-prod-cluster',
                  '12/12',
                  '0',
                  PrimeCareTheme.emeraldTeal,
                  'Running',
                ),
                _buildDataRow(
                  'frontend-web',
                  'primecare-prod-cluster',
                  '8/8',
                  '0',
                  PrimeCareTheme.emeraldTeal,
                  'Running',
                ),
                _buildDataRow(
                  'auth-service',
                  'primecare-prod-cluster',
                  '4/4',
                  '2',
                  Colors.orange,
                  'Running',
                ),
                _buildDataRow(
                  'analytics-worker',
                  'primecare-data-cluster',
                  '2/3',
                  '14',
                  Colors.red,
                  'CrashLoopBackOff',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String namespace,
    String cluster,
    String pods,
    String restarts,
    Color statusColor,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            namespace,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
        ),
        DataCell(Text(cluster, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(pods)),
        DataCell(
          Text(
            restarts,
            style: TextStyle(
              color: restarts != '0' ? Colors.orange : Colors.white70,
            ),
          ),
        ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildResourceCosts(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart2,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Cloud Spend Allocation',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildCostLine('EC2 Compute Compute', '\$4,250'),
          const SizedBox(height: 12),
          _buildCostLine('RDS Database Storage', '\$3,120'),
          const SizedBox(height: 12),
          _buildCostLine('S3 / CloudFront CDN', '\$1,180'),
          const SizedBox(height: 12),
          _buildCostLine('Data Transfer Out', '\$850'),
          const Divider(color: Colors.white12, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total MTD Spend',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '\$9,400',
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

  Widget _buildNetworkTopology(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.network, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Network Gateways',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildNetworkNode('ALB-Public-Ingress', '82.4k req/sec', true),
          const SizedBox(height: 16),
          Container(
            height: 20,
            width: 2,
            color: Colors.white12,
            margin: const EdgeInsets.only(left: 18),
          ),
          const SizedBox(height: 16),
          _buildNetworkNode('NAT Gateway - AZ A', '4.2 TB Transferred', true),
          const SizedBox(height: 16),
          Container(
            height: 20,
            width: 2,
            color: Colors.white12,
            margin: const EdgeInsets.only(left: 18),
          ),
          const SizedBox(height: 16),
          _buildNetworkNode(
            'VPN Transit Gateway',
            'Degraded Connection',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkNode(String name, String stat, bool healthy) {
    return Row(
      children: [
        Icon(
          healthy ? LucideIcons.checkCircle2 : LucideIcons.alertTriangle,
          color: healthy ? PrimeCareTheme.emeraldTeal : Colors.orange,
          size: 20,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              stat,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
