// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A high-fidelity visualization of partnership synergy and referral trends.
class PartnerSynergyMatrix extends StatelessWidget {
  final AnalyticsChart chart;

  const PartnerSynergyMatrix({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Partner Synergy Matrix', style: theme.typography.h3),
                  Text(
                    'Referral performance and growth velocity',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'DETAILS',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.externalLink,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 300, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A high-density grid showing lead conversion status.
class PartnershipLeadConversionGrid extends StatelessWidget {
  const PartnershipLeadConversionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lead Conversion Pipeline', style: theme.typography.h3),
          Text(
            'Active referral tracking and status auditing',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const [
              'Partner',
              'Lead Source',
              'Conversion Rate',
              'Status',
            ],
            rows: [
              _buildRow('General Hospital', 'Direct Referral', '82%', 'active'),
              _buildRow(
                'Senior Living Inc',
                'Community Event',
                '65%',
                'pending',
              ),
              _buildRow('MedCenter Plus', 'Digital Portal', '48%', 'caution'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String partner, String source, String rate, String status) {
    return DataRow(
      cells: [
        DataCell(Text(partner)),
        DataCell(Text(source)),
        DataCell(Text(rate)),
        DataCell(
          PrimeCareStatusBadge(
            label: status.toUpperCase(),
            type: _getStatusType(status),
          ),
        ),
      ],
    );
  }

  BadgeType _getStatusType(String status) {
    switch (status) {
      case 'active':
        return BadgeType.success;
      case 'caution':
        return BadgeType.warning;
      case 'pending':
        return BadgeType.info;
      default:
        return BadgeType.neutral;
    }
  }
}

/// Quick action hub for the Partnership Manager.
class PartnerActionHub extends StatelessWidget {
  const PartnerActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'New Partner',
          icon: LucideIcons.userPlus,
          route: '/onboarding/partner',
        ),
        PrimeCareActionItem(
          title: 'Referral Log',
          icon: LucideIcons.fileText,
          route: '/reports/referrals',
        ),
        PrimeCareActionItem(
          title: 'Synergy Audit',
          icon: LucideIcons.shieldCheck,
          route: '/audit/synergy',
        ),
      ],
    );
  }
}
