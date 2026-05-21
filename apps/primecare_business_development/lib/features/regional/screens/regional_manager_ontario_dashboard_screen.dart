import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class RegionalManagerOntarioDashboardScreen extends StatelessWidget {
  const RegionalManagerOntarioDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  children: [
                    Icon(LucideIcons.map, size: 40, color: Colors.blue.shade800),
                    const SizedBox(width: 16),
                    Text(
                      'Ontario Regional Dashboard',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ResponsiveSplitDashboard(
                  metrics: [
                    _StatCard('Active Clinics', '24 Sites', LucideIcons.building2, Colors.blue),
                    _StatCard('Compliance Rate', '99.1%', LucideIcons.shieldCheck, Colors.green),
                    _StatCard('Monthly Admissions', '1,420', LucideIcons.userPlus, Colors.orange),
                  ],
                  mainContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ontario Hub Standing & Admitted Cases',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ResponsiveGrid(
                        minItemWidth: 380,
                        maxItemWidth: 600,
                        children: [
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hub Compliance Overview',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  _ComplianceRow('Toronto Central Hub', 0.99, Colors.green),
                                  _ComplianceRow('Ottawa East Hub', 0.98, Colors.blue),
                                  _ComplianceRow('Hamilton South Hub', 0.95, Colors.orange),
                                  _ComplianceRow('London West Hub', 0.92, Colors.purple),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Admissions Growth Corridor',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  _CorridorGrowthRow('GTA Core', 0.85, Colors.teal),
                                  _CorridorGrowthRow('Ottawa-Gatineau', 0.70, Colors.indigo),
                                  _CorridorGrowthRow('Niagara-Hamilton', 0.55, Colors.amber),
                                  _CorridorGrowthRow('Southwestern Ontario', 0.40, Colors.pink),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  defaultSidebarWidgets: [
                    QuickActionsPanel(
                      actions: [
                        QuickActionItem(
                          label: 'Audit Hub',
                          icon: LucideIcons.clipboardCheck,
                          color: Colors.blue,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Assign Supervisor',
                          icon: LucideIcons.userCheck,
                          color: Colors.purple,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Generate Reports',
                          icon: LucideIcons.fileSpreadsheet,
                          color: Colors.teal,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Escalate SOS',
                          icon: LucideIcons.alertTriangle,
                          color: Colors.red,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const RecentActivityFeed(
                      activities: [
                        PortalActivityItem(
                          title: 'GTA Compliance Clear',
                          description: 'GTA Core clinic cleared compliance audit with 100% score.',
                          time: '1h ago',
                          icon: LucideIcons.checkCircle,
                          color: Colors.green,
                        ),
                        PortalActivityItem(
                          title: 'New Dispatch Unit',
                          description: 'Registered 3 new home care dispatch units in London.',
                          time: '4h ago',
                          icon: LucideIcons.truck,
                          color: Colors.blue,
                        ),
                        PortalActivityItem(
                          title: 'Licensing Renewal',
                          description: 'Renewed clinic licenses for Niagara branch.',
                          time: '1d ago',
                          icon: LucideIcons.fileSignature,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    const AiInsightsCard(
                      heading: 'Ontario Insights',
                      suggestions: [
                        'Admissions in GTA Core show an 8% increase; consider reallocating floating PSW units.',
                        'Hamilton South Hub is running at 95% capacity. Suggest opening secondary intake lane.',
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(this.title, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(
                  value,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ComplianceRow extends StatelessWidget {
  final String hubName;
  final double score;
  final Color color;

  const _ComplianceRow(this.hubName, this.score, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hubName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(
                '${(score * 100).toInt()}% Compliance',
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score,
              backgroundColor: color.withValues(alpha: 0.1),
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _CorridorGrowthRow extends StatelessWidget {
  final String corridor;
  final double growth;
  final Color color;

  const _CorridorGrowthRow(this.corridor, this.growth, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(corridor, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(
                '${(growth * 100).toInt()}% Capacity',
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: growth,
              backgroundColor: color.withValues(alpha: 0.1),
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}