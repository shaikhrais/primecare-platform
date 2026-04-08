import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CommunityPartnershipsScreen extends ConsumerStatefulWidget {
  const CommunityPartnershipsScreen({super.key});

  @override
  ConsumerState<CommunityPartnershipsScreen> createState() =>
      _CommunityPartnershipsScreenState();
}

class _CommunityPartnershipsScreenState
    extends ConsumerState<CommunityPartnershipsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildKPIs(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildPartnershipsTable()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildPipelineSummary(),
                    const SizedBox(height: 32),
                    _buildActivityFeed(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.handshake,
                  color: PrimeCareTheme.colors.navyIndigo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Partnerships Platform',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Manage business development partnerships and organizational alliances.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        ClinicalGlassButton(
          onPressed: () {},
          icon: LucideIcons.plus,
          label: 'New Partner',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Active Partnerships',
            value: '18',
            icon: LucideIcons.network,
            trend: '+2 this quarter',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Partner Revenue Impact',
            value: '\$450K',
            icon: LucideIcons.trendingUp,
            trend: '+15% YTD',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Leads Sourced (MTD)',
            value: '42',
            icon: LucideIcons.users,
            trend: '24% of total pipeline',
            isPositive: false,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Expiring MOUs',
            value: '2',
            icon: LucideIcons.fileWarning,
            trend: 'Requires renewal',
            isWarning: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required String trend,
    bool isWarning = false,
    bool isPositive = false,
  }) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;

    if (isWarning) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: PrimeCareTheme.typography.label.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnershipsTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Organizational Partners',
                  style: PrimeCareTheme.typography.h3.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PrimeCareTheme.colors.surfaceContainerHighest,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.search,
                        size: 18,
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Search partners...',
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'ORGANIZATION',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TIER',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'PRIMARY CONTACT',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'REFERRALS (YTD)',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'EST. VALUE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'STATUS',
                    textAlign: TextAlign.center,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ..._buildPartnershipRows(),
        ],
      ),
    );
  }

  List<Widget> _buildPartnershipRows() {
    final partners = [
      {
        'org': 'City General Hospital',
        'tier': 'Platinum',
        'contact': 'Dr. S. Jenkins',
        'referrals': '145',
        'value': '\$280K',
        'status': 'Active',
      },
      {
        'org': 'Elder Care Network',
        'tier': 'Gold',
        'contact': 'M. Thompson',
        'referrals': '82',
        'value': '\$115K',
        'status': 'Active',
      },
      {
        'org': 'Lincoln High School',
        'tier': 'Silver',
        'contact': 'D. Kim',
        'referrals': '12',
        'value': '\$15K',
        'status': 'Active',
      },
      {
        'org': 'Community Health Foundation',
        'tier': 'Gold',
        'contact': 'E. Chen',
        'referrals': '45',
        'value': '\$40K',
        'status': 'Expiring',
      },
      {
        'org': 'Westside Internal Med',
        'tier': 'Bronze',
        'contact': 'Dr. P. Patel',
        'referrals': '4',
        'value': '\$5K',
        'status': 'Dormant',
      },
    ];

    return partners.asMap().entries.map((entry) {
      final partner = entry.value;
      final int index = entry.key;

      Color statusColor;
      switch (partner['status']) {
        case 'Active':
          statusColor = PrimeCareTheme.colors.emeraldTeal;
          break;
        case 'Expiring':
          statusColor = Colors.amber.shade700;
          break;
        case 'Dormant':
          statusColor = PrimeCareTheme.colors.slateGray;
          break;
        default:
          statusColor = PrimeCareTheme.colors.navyIndigo;
      }

      Color tierColor;
      switch (partner['tier']) {
        case 'Platinum':
          tierColor = PrimeCareTheme.colors.navyIndigo;
          break;
        case 'Gold':
          tierColor = Colors.amber.shade600;
          break;
        case 'Silver':
          tierColor = PrimeCareTheme.colors.slateGray;
          break;
        case 'Bronze':
          tierColor = Colors.brown.shade400;
          break;
        default:
          tierColor = PrimeCareTheme.colors.slateGray;
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    partner['org']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(LucideIcons.shield, size: 14, color: tierColor),
                      const SizedBox(width: 4),
                      Text(
                        partner['tier']!,
                        style: PrimeCareTheme.typography.body.copyWith(
                          color: PrimeCareTheme.colors.navyIndigo,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    partner['contact']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    partner['referrals']!,
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    partner['value']!,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.emeraldTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        partner['status']!,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (index < partners.length - 1)
            Divider(
              height: 1,
              color: PrimeCareTheme.colors.surfaceContainerHighest,
            ),
        ],
      );
    }).toList();
  }

  Widget _buildPipelineSummary() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Partner Pipeline',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.filter,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildPipelineStage(
            'Qualified Targets',
            '12',
            PrimeCareTheme.colors.slateGray,
            0.4,
          ),
          const SizedBox(height: 16),
          _buildPipelineStage('In Discussion', '5', Colors.amber.shade600, 0.6),
          const SizedBox(height: 16),
          _buildPipelineStage(
            'MOU Negotiations',
            '2',
            PrimeCareTheme.colors.navyIndigo,
            0.8,
          ),
          const SizedBox(height: 16),
          _buildPipelineStage(
            'Recently Signed',
            '1',
            PrimeCareTheme.colors.emeraldTeal,
            1.0,
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineStage(
    String label,
    String count,
    Color color,
    double progress,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              count,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityFeed() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.activity,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActivityItem(
            'MOU Renewed',
            'Elder Care Network renewed their Gold partnership.',
            '2 hours ago',
            LucideIcons.fileCheck,
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'Meeting Completed',
            'Initial discussion with Valley Health.',
            'Yesterday',
            LucideIcons.users,
            PrimeCareTheme.colors.navyIndigo,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'Lead Received',
            'New referral received from City General Hospital.',
            'Oct 25',
            LucideIcons.userPlus,
            PrimeCareTheme.colors.coralRed,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String desc,
    String time,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    time,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
