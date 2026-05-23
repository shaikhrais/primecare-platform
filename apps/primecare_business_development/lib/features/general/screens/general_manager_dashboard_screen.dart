// Governance - Category: view | Purpose: UI Screen component rendering the General Manager Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class GeneralManagerDashboardScreen extends StatelessWidget {
  const GeneralManagerDashboardScreen({Key? key}) : super(key: key);

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
                    Icon(LucideIcons.briefcase, size: 40, color: Colors.blueGrey.shade800),
                    const SizedBox(width: 16),
                    Text("General Manager Dashboard", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800)),
                  ],
                ),
              ),
              Expanded(
                child: ResponsiveSplitDashboard(
                  metrics: [
                    _StatCard('Overall Operations', '98.4%', LucideIcons.activity, Colors.indigo),
                    _StatCard('Staff Utilization', '89%', LucideIcons.users, Colors.purple),
                    _StatCard('Active Sites', '12 Hubs', LucideIcons.home, Colors.teal),
                  ],
                  mainContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Operational Overview & Hub Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                  const Text('Operational Standing', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 250,
                                    width: double.infinity,
                                    decoration: BoxDecoration(color: Colors.teal.shade50.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(LucideIcons.checkCircle, size: 56, color: Colors.teal.shade400),
                                          const SizedBox(height: 12),
                                          const Text("Division Active", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 6),
                                          Text("All regional metrics, staff allocations, and client satisfaction indexes are aligned with core company KPIs.", textAlign: TextAlign.center, style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
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
                                  const Text('Regional Hub Standing', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 16),
                                  _HubStatusRow('Toronto Central Hub', 0.98, Colors.green),
                                  _HubStatusRow('Calgary Regional Hub', 0.95, Colors.blue),
                                  _HubStatusRow('Vancouver Metro Hub', 0.94, Colors.purple),
                                  _HubStatusRow('Halifax Coastal Hub', 0.92, Colors.orange),
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
                          label: 'Division Audit',
                          icon: LucideIcons.clipboardList,
                          color: Colors.teal,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Staff Recruitment',
                          icon: LucideIcons.userPlus,
                          color: Colors.indigo,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Finance Summary',
                          icon: LucideIcons.dollarSign,
                          color: Colors.green,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Policy Update',
                          icon: LucideIcons.fileText,
                          color: Colors.orange,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const RecentActivityFeed(
                      activities: [
                        PortalActivityItem(
                          title: 'Compliance Verified',
                          description: 'All 12 active hubs cleared their quarterly health compliance.',
                          time: '3h ago',
                          icon: LucideIcons.shieldAlert,
                          color: Colors.green,
                        ),
                        PortalActivityItem(
                          title: 'PSW Shift Surge',
                          description: 'PSW coordinator dispatched 45 shift coverages successfully.',
                          time: '6h ago',
                          icon: LucideIcons.users,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const AiInsightsCard(
                      heading: 'Operational Insights',
                      suggestions: [
                        'Hub staffing utilization shows a 5% optimization window in eastern clinics.',
                        'Review recruitment drive schedules to prevent seasonal support gaps.',
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
            CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _HubStatusRow extends StatelessWidget {
  final String hubName;
  final double score;
  final Color color;

  const _HubStatusRow(this.hubName, this.score, this.color);

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
              Text('${(score * 100).toInt()}% Operating', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score,
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