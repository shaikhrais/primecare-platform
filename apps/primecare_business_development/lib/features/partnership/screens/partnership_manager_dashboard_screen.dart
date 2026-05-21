import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class PartnershipManagerDashboardScreen extends StatefulWidget {
  const PartnershipManagerDashboardScreen({super.key});

  @override
  State<PartnershipManagerDashboardScreen> createState() => _PartnershipManagerDashboardScreenState();
}

class _PartnershipManagerDashboardScreenState extends State<PartnershipManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partnership Manager Dashboard'), backgroundColor: const Color(0xFF0F766E), foregroundColor: Colors.white),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              _StatCard('Active B2B Deals', '15', LucideIcons.building, Colors.blue),
              _StatCard('Renewal Rate', '94%', LucideIcons.refreshCcw, Colors.green),
              _StatCard('Recent Outreach', '42', LucideIcons.mail, Colors.orange),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Renewals & Strategic Account Standing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            const Text('High Priority Renewals', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Partner')),
                                  DataColumn(label: Text('Contract')),
                                  DataColumn(label: Text('Status')),
                                ],
                                rows: [
                                  DataRow(cells: [DataCell(Text('Sunrise Senior Care', style: TextStyle(fontSize: 12))), DataCell(Text(r'$140k/yr', style: TextStyle(fontSize: 12))), DataCell(Chip(label: Text('At Risk', style: TextStyle(fontSize: 10, color: Colors.red.shade900)), backgroundColor: Colors.red.shade100, padding: EdgeInsets.zero))]),
                                  DataRow(cells: [DataCell(Text('Toronto General', style: TextStyle(fontSize: 12))), DataCell(Text(r'$250k/yr', style: TextStyle(fontSize: 12))), DataCell(Chip(label: Text('Negotiating', style: TextStyle(fontSize: 10, color: Colors.orange.shade900)), backgroundColor: Colors.orange.shade100, padding: EdgeInsets.zero))]),
                                  DataRow(cells: [DataCell(Text('Evergreen Pharmacies', style: TextStyle(fontSize: 12))), DataCell(Text(r'$80k/yr', style: TextStyle(fontSize: 12))), DataCell(Chip(label: Text('Committed', style: TextStyle(fontSize: 10, color: Colors.green.shade900)), backgroundColor: Colors.green.shade100, padding: EdgeInsets.zero))]),
                                ]
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
                            const Text('Key Account Health Index', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            _PartnerHealthRow('Sunrise Senior Care', 0.68, Colors.red),
                            _PartnerHealthRow('Toronto General Hospital', 0.85, Colors.blue),
                            _PartnerHealthRow('Evergreen Pharmacies', 0.94, Colors.green),
                            _PartnerHealthRow('Mount Sinai Hospital', 0.72, Colors.purple),
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
                    label: 'New B2B Lead',
                    icon: LucideIcons.userPlus,
                    color: Colors.teal,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Log Outreach',
                    icon: LucideIcons.phone,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Review Contract',
                    icon: LucideIcons.fileText,
                    color: Colors.indigo,
                    onTap: () {},
                  ),
                  QuickActionItem(
                    label: 'Renew Alert',
                    icon: LucideIcons.bell,
                    color: Colors.orange,
                    onTap: () {},
                  ),
                ],
              ),
              const RecentActivityFeed(
                activities: [
                  PortalActivityItem(
                    title: 'Sunrise Care Pitch',
                    description: 'Contract review session scheduled for Sunrise Seniors account.',
                    time: '45m ago',
                    icon: LucideIcons.calendar,
                    color: Colors.orange,
                  ),
                  PortalActivityItem(
                    title: 'Deal Closed: Pharmacies',
                    description: 'Evergreen Pharmacies signed a \$80k/yr extension.',
                    time: '3h ago',
                    icon: LucideIcons.check,
                    color: Colors.green,
                  ),
                  PortalActivityItem(
                    title: 'Outreach Logged',
                    description: 'Sent partnership inquiry to Mount Sinai Hospital.',
                    time: '1d ago',
                    icon: LucideIcons.mail,
                    color: Colors.blue,
                  ),
                ],
              ),
              const AiInsightsCard(
                heading: 'Deal Risk Analysis',
                suggestions: [
                  'Sunrise Senior Care contract expires in 6 months. High risk indicators detected.',
                  'Evergreen contract renewal has been locked in. Consider upselling Allied Health.',
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

class _PartnerHealthRow extends StatelessWidget {
  final String partnerName;
  final double health;
  final Color color;

  const _PartnerHealthRow(this.partnerName, this.health, this.color);

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
              Text(partnerName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('${(health * 100).toInt()}% Health', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: health,
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
