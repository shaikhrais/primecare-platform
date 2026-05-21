import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class RegionalBdmDashboardScreen extends StatefulWidget {
  const RegionalBdmDashboardScreen({super.key});

  @override
  State<RegionalBdmDashboardScreen> createState() => _RegionalBdmDashboardScreenState();
}

class _RegionalBdmDashboardScreenState extends State<RegionalBdmDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regional BDM Dashboard'), backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              _StatCard('Market Share', '14%', LucideIcons.pieChart, Colors.purple),
              _StatCard('Active Territories', '8', LucideIcons.map, Colors.blue),
              _StatCard('Pipeline Value', r'$1.2M', LucideIcons.trendingUp, Colors.green),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Market Intelligence & Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ResponsiveGrid(
                  minItemWidth: 380,
                  maxItemWidth: 600,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Territory Growth Target', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _TerritoryRow('Greater Toronto Area', 0.8),
                            _TerritoryRow('Vancouver Metro', 0.6),
                            _TerritoryRow('Calgary Region', 0.4),
                            _TerritoryRow('Halifax Regional', 0.2),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Pipeline Conversion Rates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _PipelineConversionRow('Lead Assignment', 0.95, Colors.purple),
                            _PipelineConversionRow('Discovery Calls', 0.72, Colors.blue),
                            _PipelineConversionRow('Proposals Signed', 0.48, Colors.orange),
                            _PipelineConversionRow('Territory Handover', 0.35, Colors.green),
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
                    label: 'Add Territory',
                    icon: LucideIcons.plus,
                    color: Colors.indigo,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Schedule Sync',
                    icon: LucideIcons.calendar,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Run Analytics',
                    icon: LucideIcons.barChart2,
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Export Report',
                    icon: LucideIcons.download,
                    color: Colors.teal,
                    onTap: () {},
                  ),
                ],
              ),
              const RecentActivityFeed(
                activities: [
                  PortalActivityItem(
                    title: 'GTA Growth Milestone',
                    description: 'Toronto Area reached 80% growth target for this quarter.',
                    time: '2h ago',
                    icon: LucideIcons.trophy,
                    color: Colors.orange,
                  ),
                  PortalActivityItem(
                    title: 'New Franchise Pitch',
                    description: 'Franchise inquiry in Vancouver Metro registered.',
                    time: '5h ago',
                    icon: LucideIcons.fileText,
                    color: Colors.blue,
                  ),
                  PortalActivityItem(
                    title: 'Pipeline Sync Done',
                    description: 'Synced live pipeline value of \$1.2M with Hub.',
                    time: '1d ago',
                    icon: LucideIcons.refreshCw,
                    color: Colors.green,
                  ),
                ],
              ),
              const AiInsightsCard(
                heading: 'Growth Opportunities',
                suggestions: [
                  'Demographic analysis suggests high demand in Hamilton & London.',
                  'Increase active sales reps in Vancouver to match the 12% lead surge.',
                  'Pipeline conversion rate is up 4% this week. Keep up the high touch.',
                ],
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
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey)),
                Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TerritoryRow extends StatelessWidget {
  final String name;
  final double growth;

  const _TerritoryRow(this.name, this.growth);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: LinearProgressIndicator(value: growth, backgroundColor: Colors.grey.shade200, minHeight: 8, color: Colors.indigo)),
          const SizedBox(width: 16),
          Text('${(growth * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _PipelineConversionRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _PipelineConversionRow(this.label, this.value, this.color);

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
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('${(value * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: color.withOpacity(0.1),
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
