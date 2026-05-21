import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class TerritoryExpansionManagerDashboardScreen extends StatefulWidget {
  const TerritoryExpansionManagerDashboardScreen({super.key});

  @override
  State<TerritoryExpansionManagerDashboardScreen> createState() => _TerritoryExpansionManagerDashboardScreenState();
}

class _TerritoryExpansionManagerDashboardScreenState extends State<TerritoryExpansionManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Territory Expansion Dashboard'), backgroundColor: const Color(0xFFC026D3), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              _StatCard('Open Territories', '45', LucideIcons.mapPin, Colors.orange),
              _StatCard('Site Selections', '12', LucideIcons.building2, Colors.blue),
              _StatCard('12-mo Forecast', '+8 Nodes', LucideIcons.calendar, Colors.green),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Demographics Heatmap & Expansion Analysis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            const Text('Territory Heatmap Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(LucideIcons.map, size: 56, color: Colors.grey),
                                    SizedBox(height: 12),
                                    Text('Interactive Territory Map (Active)', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
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
                            const Text('Regional Suitability Indices', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _SuitabilityRow('Calgary Metro Corridor', 0.94, Colors.green),
                            _SuitabilityRow('Ontario Southwest Region', 0.88, Colors.blue),
                            _SuitabilityRow('Vancouver Fraser Valley', 0.72, Colors.purple),
                            _SuitabilityRow('Montreal West Island', 0.65, Colors.orange),
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
                    label: 'Add New Site',
                    icon: LucideIcons.plusCircle,
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Analyze Demog',
                    icon: LucideIcons.globe,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Forecast Exp',
                    icon: LucideIcons.trendingUp,
                    color: Colors.green,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Feasibility Study',
                    icon: LucideIcons.bookOpen,
                    color: Colors.indigo,
                    onTap: () {},
                  ),
                ],
              ),
              const RecentActivityFeed(
                activities: [
                  PortalActivityItem(
                    title: 'Site Approved: Calgary',
                    description: 'Calgary North site selection approved by operational board.',
                    time: '1h ago',
                    icon: LucideIcons.checkSquare,
                    color: Colors.green,
                  ),
                  PortalActivityItem(
                    title: 'Demographic Sync Done',
                    description: 'Imported census 2026 dataset for Ontario regions.',
                    time: '4h ago',
                    icon: LucideIcons.database,
                    color: Colors.blue,
                  ),
                  PortalActivityItem(
                    title: 'Forecast Updated',
                    description: 'Added 2 new node forecasts in Montreal East corridor.',
                    time: '2d ago',
                    icon: LucideIcons.calendar,
                    color: Colors.orange,
                  ),
                ],
              ),
              const AiInsightsCard(
                heading: 'Expansion Insights',
                suggestions: [
                  'Calgary North has a 14% underservice rate based on local community density.',
                  'Feasibility study suggests high growth in Montreal East corridor.',
                  'Ontario regional hub is ready for additional PSW recruitment expansion.',
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

class _SuitabilityRow extends StatelessWidget {
  final String region;
  final double suitability;
  final Color color;

  const _SuitabilityRow(this.region, this.suitability, this.color);

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
              Text(region, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('${(suitability * 100).toInt()}% Suitability', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: suitability,
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
