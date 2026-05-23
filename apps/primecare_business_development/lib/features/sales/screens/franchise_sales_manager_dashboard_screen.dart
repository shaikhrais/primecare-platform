// Governance - Category: view | Purpose: UI Screen component rendering the Franchise Sales Manager Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class FranchiseSalesManagerDashboardScreen extends StatefulWidget {
  const FranchiseSalesManagerDashboardScreen({super.key});

  @override
  State<FranchiseSalesManagerDashboardScreen> createState() => _FranchiseSalesManagerDashboardScreenState();
}

class _FranchiseSalesManagerDashboardScreenState extends State<FranchiseSalesManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Franchise Sales Manager Dashboard'), backgroundColor: const Color(0xFF0F172A), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              _StatCard('Active Deals', '24', LucideIcons.briefcase, Colors.blue),
              _StatCard('Discovery Calls', '12', LucideIcons.phone, Colors.orange),
              _StatCard('Signed Contracts', '4', LucideIcons.fileSignature, Colors.green),
              _StatCard('Commission Proj.', r'$18,500', LucideIcons.dollarSign, Colors.purple),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Deal Funnel & Representative Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            const Text('Deal Stage Funnel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _FunnelRow('Prospects', 120, 1.0, Colors.grey),
                            _FunnelRow('Qualified Leads', 45, 0.6, Colors.blue),
                            _FunnelRow('Proposals Sent', 18, 0.3, Colors.orange),
                            _FunnelRow('Negotiation', 8, 0.15, Colors.purple),
                            _FunnelRow('Closed Won', 4, 0.05, Colors.green),
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
                            const Text('Sales Team Quota Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _QuotaProgressRow('Alice Smith', 0.88, Colors.green),
                            _QuotaProgressRow('Bob Jones', 0.64, Colors.blue),
                            _QuotaProgressRow('Clara Davis', 0.92, Colors.purple),
                            _QuotaProgressRow('Daniel Miller', 0.78, Colors.orange),
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
                    label: 'Add Franchisee',
                    icon: LucideIcons.userPlus,
                    color: Colors.indigo,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Schedule Call',
                    icon: LucideIcons.phone,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Draft Proposal',
                    icon: LucideIcons.fileText,
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Sales Forecast',
                    icon: LucideIcons.trendingUp,
                    color: Colors.purple,
                    onTap: () {},
                  ),
                ],
              ),
              const RecentActivityFeed(
                activities: [
                  PortalActivityItem(
                    title: 'Proposal Signed',
                    description: 'Franchise candidate John Doe signed Letter of Intent.',
                    time: '15m ago',
                    icon: LucideIcons.fileSignature,
                    color: Colors.green,
                  ),
                  PortalActivityItem(
                    title: 'New Qualified Lead',
                    description: 'High net-worth lead assigned in Ottawa region.',
                    time: '2h ago',
                    icon: LucideIcons.userCheck,
                    color: Colors.blue,
                  ),
                  PortalActivityItem(
                    title: 'Discovery Call Done',
                    description: 'Completed initial screening with investor group.',
                    time: '5h ago',
                    icon: LucideIcons.check,
                    color: Colors.teal,
                  ),
                ],
              ),
              const AiInsightsCard(
                heading: 'Pipeline Predictions',
                suggestions: [
                  'Qualified leads in Ontario have increased by 22% month-over-month.',
                  'Discovery-to-Proposal duration decreased to 8 days. Keep momentum high.',
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

class _FunnelRow extends StatelessWidget {
  final String label;
  final int count;
  final double fraction;
  final Color color;

  const _FunnelRow(this.label, this.count, this.fraction, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                height: 32,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 8),
                child: Text(count.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _QuotaProgressRow extends StatelessWidget {
  final String repName;
  final double progress;
  final Color color;

  const _QuotaProgressRow(this.repName, this.progress, this.color);

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
              Text(repName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('${(progress * 100).toInt()}% of Quota', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
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
