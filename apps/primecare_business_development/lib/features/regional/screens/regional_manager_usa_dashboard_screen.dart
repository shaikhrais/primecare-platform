// Governance - Category: view | Purpose: UI Screen component rendering the Regional Manager Usa Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class RegionalManagerUsaDashboardScreen extends StatelessWidget {
  const RegionalManagerUsaDashboardScreen({Key? key}) : super(key: key);

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
                    Icon(LucideIcons.globe, size: 40, color: Colors.blue.shade800),
                    const SizedBox(width: 16),
                    Text(
                      'USA Regional Dashboard',
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
                    _StatCard('Cross-Border Referrals', '412 Cases', LucideIcons.arrowUpDown, Colors.indigo),
                    _StatCard('License Verifications', '180 Approved', LucideIcons.award, Colors.green),
                    _StatCard('Active Care Plans', '950 Clients', LucideIcons.fileHeart, Colors.teal),
                  ],
                  mainContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'US Regulatory Approvals & Licensing Velocity',
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
                                    'Regulatory State Approval Index',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  _RegulatoryRow('New York Division', 0.96, Colors.green),
                                  _RegulatoryRow('Michigan Lakes Division', 0.88, Colors.blue),
                                  _RegulatoryRow('Ohio Valley Division', 0.75, Colors.orange),
                                  _RegulatoryRow('Pennsylvania Division', 0.60, Colors.purple),
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
                                    'Nurse Licensing Progress',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  _LicensingRow('Fingerprinting & Background', 0.94, Colors.teal),
                                  _LicensingRow('State Board Endorsement', 0.82, Colors.indigo),
                                  _LicensingRow('Credential Assembly', 0.65, Colors.amber),
                                  _LicensingRow('Jurisprudence Exams', 0.45, Colors.pink),
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
                          label: 'State Filing',
                          icon: LucideIcons.filePlus,
                          color: Colors.indigo,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Verify License',
                          icon: LucideIcons.checkSquare,
                          color: Colors.green,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Billing Sync',
                          icon: LucideIcons.dollarSign,
                          color: Colors.teal,
                          onTap: () {},
                        ),
                        QuickActionItem(
                          label: 'Policy Launch',
                          icon: LucideIcons.send,
                          color: Colors.blue,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const RecentActivityFeed(
                      activities: [
                        PortalActivityItem(
                          title: 'Michigan Board Clearance',
                          description: 'Board of Nursing approved 14 RN licenses for Lakes corridor.',
                          time: '3h ago',
                          icon: LucideIcons.userCheck,
                          color: Colors.green,
                        ),
                        PortalActivityItem(
                          title: 'New York Billing Audit',
                          description: 'SSO auto-synced monthly Medicaid claims with Hub.',
                          time: '7h ago',
                          icon: LucideIcons.checkCircle,
                          color: Colors.blue,
                        ),
                        PortalActivityItem(
                          title: 'Regulatory Audit Update',
                          description: 'Filing submitted for PA expansion permits.',
                          time: '2d ago',
                          icon: LucideIcons.landmark,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    const AiInsightsCard(
                      heading: 'USA Insights',
                      suggestions: [
                        'Board verification delays in Ohio Valley corridor reached 8 business days. Suggest launching fast-track endorsements.',
                        'Cross-border referral velocity shows 14% growth in New York; verify therapist allocation matches the target trend.',
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

class _RegulatoryRow extends StatelessWidget {
  final String division;
  final double score;
  final Color color;

  const _RegulatoryRow(this.division, this.score, this.color);

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
              Text(division, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(
                '${(score * 100).toInt()}% Approval',
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

class _LicensingRow extends StatelessWidget {
  final String stage;
  final double progress;
  final Color color;

  const _LicensingRow(this.stage, this.progress, this.color);

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
              Text(stage, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(
                '${(progress * 100).toInt()}% Done',
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
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