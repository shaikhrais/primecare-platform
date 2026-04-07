import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class InfrastructureScreen extends StatelessWidget {
  const InfrastructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Cloud Infrastructure',
      subtitle:
          'Manage data centers, network topology, container deployments, and AWS costs.',
      headerTrailing: [
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Simulate Failover',
          icon: LucideIcons.cloudRain,
          isPrimary: true,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Provision Instance',
          icon: LucideIcons.server,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Total Instances',
          value: '42',
          icon: LucideIcons.server,
          trend: 'Across 3 Regions',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Docker Containers',
          value: '256',
          icon: LucideIcons.box,
          trend: '98% Healthy',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'VPC Network Traffic',
          value: '4.2 TB',
          icon: LucideIcons.workflow,
          trend: 'Last 24h',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Est. Monthly Cost',
          value: '\$12,450',
          icon: LucideIcons.badgeDollarSign,
          trend: 'On track (-5%)',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
      ],
      mainContent: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildDataCenterMap(),
                  const SizedBox(height: 24),
                  _buildContainerStatus(),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildResourceCosts(),
                  const SizedBox(height: 24),
                  _buildNetworkTopology(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDataCenterMap() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Data Center Regions', style: PrimeCareTheme.typography.h3),
              Row(
                children: [
                  _buildStatusIndicator('Healthy', PrimeCareTheme.colors.emeraldTeal),
                  const SizedBox(width: 16),
                  _buildStatusIndicator('Degraded', PrimeCareTheme.colors.amberWarning),
                  const SizedBox(width: 16),
                  _buildStatusIndicator('Offline', PrimeCareTheme.colors.roseRed),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.cloudGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    LucideIcons.globe,
                    size: 180,
                    color: PrimeCareTheme.colors.slateGray.withOpacity(0.2),
                  ),
                ),
                _buildRegionMarker(
                  'us-east-1 (N. Virginia)',
                  40,
                  60,
                  true,
                ),
                _buildRegionMarker('us-west-2 (Oregon)', 30, 20, true),
                _buildRegionMarker(
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
          style: PrimeCareTheme.typography.label,
        ),
      ],
    );
  }

  Widget _buildRegionMarker(
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
              color: isHealthy ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.amberWarning,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isHealthy
                      ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.5)
                      : PrimeCareTheme.colors.amberWarning.withOpacity(0.5),
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
              color: PrimeCareTheme.colors.navyIndigo,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.iceWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerStatus() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kubernetes Pod Status', style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: PrimeCareTheme.typography.body,
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
                  PrimeCareTheme.colors.emeraldTeal,
                  'Running',
                ),
                _buildDataRow(
                  'frontend-web',
                  'primecare-prod-cluster',
                  '8/8',
                  '0',
                  PrimeCareTheme.colors.emeraldTeal,
                  'Running',
                ),
                _buildDataRow(
                  'auth-service',
                  'primecare-prod-cluster',
                  '4/4',
                  '2',
                  PrimeCareTheme.colors.amberWarning,
                  'Running',
                ),
                _buildDataRow(
                  'analytics-worker',
                  'primecare-data-cluster',
                  '2/3',
                  '14',
                  PrimeCareTheme.colors.roseRed,
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
            style: PrimeCareTheme.typography.body.copyWith(
              fontFamily: 'monospace',
            ),
          ),
        ),
        DataCell(Text(cluster)),
        DataCell(Text(pods)),
        DataCell(
          Text(
            restarts,
            style: PrimeCareTheme.typography.body.copyWith(
              color: restarts != '0' ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.iceWhite,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: Text(
              status,
              style: PrimeCareTheme.typography.label.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResourceCosts() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart2,
                color: PrimeCareTheme.colors.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text('Cloud Spend Allocation', style: PrimeCareTheme.typography.h3),
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
          Divider(color: PrimeCareTheme.colors.cloudGray, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total MTD Spend',
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$9,400',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.iceWhite,
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
        Text(service, style: PrimeCareTheme.typography.body),
        Text(
          cost,
          style: PrimeCareTheme.typography.body.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkTopology() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.network, color: PrimeCareTheme.colors.navyIndigo, size: 24),
              const SizedBox(width: 12),
              Text('Network Gateways', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 24),
          _buildNetworkNode('ALB-Public-Ingress', '82.4k req/sec', true),
          const SizedBox(height: 16),
          Container(
            height: 20,
            width: 2,
            color: PrimeCareTheme.colors.cloudGray,
            margin: const EdgeInsets.only(left: 18),
          ),
          const SizedBox(height: 16),
          _buildNetworkNode('NAT Gateway - AZ A', '4.2 TB Transferred', true),
          const SizedBox(height: 16),
          Container(
            height: 20,
            width: 2,
            color: PrimeCareTheme.colors.cloudGray,
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
          color: healthy ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.amberWarning,
          size: 20,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              stat,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

