import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class LocalLeadsScreen extends ConsumerWidget {
  const LocalLeadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Lead Generation Dashboard',
      subtitle: 'Monitor incoming leads, acquisition cost, and conversion performance from local campaigns.',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.download,
            label: 'Export Data',
            isPrimary: false,
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.plus,
            label: 'Manual Entry',
            isPrimary: true,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'Total Leads',
          value: '12,842',
          icon: LucideIcons.users,
          trend: 12.0,
          trendLabel: 'vs last month',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Conversion Rate',
          value: '18.4%',
          icon: LucideIcons.percent,
          trend: 2.1,
          trendLabel: 'vs last month',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Cost per Lead',
          value: '\$142.50',
          icon: LucideIcons.dollarSign,
          trend: -5.0,
          trendLabel: 'vs target',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Quality Score',
          value: '8.2/10',
          icon: LucideIcons.award,
          trend: 0.0,
          trendLabel: 'avg rating',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lead Acquisition by Source (12 Months)',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  Row(
                    children: [
                      _buildLegend(PrimeCareTheme.colors.emeraldTeal, 'Organic'),
                      const SizedBox(width: 16),
                      _buildLegend(PrimeCareTheme.colors.navyIndigo, 'Paid'),
                      const SizedBox(width: 16),
                      _buildLegend(PrimeCareTheme.colors.slateGray, 'Referral'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStackedBar('Jan', 40, 70, 20),
                    _buildStackedBar('Feb', 50, 60, 25),
                    _buildStackedBar('Mar', 65, 85, 30),
                    _buildStackedBar('Apr', 80, 100, 35),
                    _buildStackedBar('May', 75, 95, 40),
                    _buildStackedBar('Jun', 90, 110, 45),
                    _buildStackedBar('Jul', 110, 130, 50),
                    _buildStackedBar('Aug', 125, 140, 55),
                    _buildStackedBar('Sep', 140, 150, 60),
                    _buildStackedBar('Oct', 160, 170, 70),
                    _buildStackedBar('Nov', 180, 190, 80),
                    _buildStackedBar('Dec', 195, 200, 95),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.star,
                    color: PrimeCareTheme.colors.emeraldTeal,
                  ),
                  const SizedBox(width: 12),
                  Text('Recent High-Value', style: PrimeCareTheme.typography.h3),
                ],
              ),
              const SizedBox(height: 24),
              _buildHighValueLead(
                'Marcus Thorne',
                'Thorne Healthcare',
                '\$120k',
                94,
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildHighValueLead(
                'Saki Tanaka',
                'Tanaka Clinics',
                '\$85k',
                91,
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildHighValueLead(
                'Julian Vogel',
                'Vogel & Co',
                '\$62k',
                88,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildStackedBar(String label, double organic, double paid, double referral) {
    final maxTotal = 400.0; // Arbitrary max for scaling
    final total = organic + paid + referral;
    final scale = 350 / maxTotal;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Container(
                height: referral * scale,
                color: PrimeCareTheme.colors.slateGray,
              ),
              Container(
                height: paid * scale,
                color: PrimeCareTheme.colors.navyIndigo,
              ),
              Container(
                height: organic * scale,
                color: PrimeCareTheme.colors.emeraldTeal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
      ],
    );
  }

  Widget _buildHighValueLead(
    String name,
    String company,
    String value,
    int score,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
          child: Text(
            name[0],
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.emeraldTeal,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                company,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            Row(
              children: [
                const Icon(
                  LucideIcons.flame,
                  size: 14,
                  color: PrimeCareTheme.colors.emeraldTeal,
                ),
                const SizedBox(width: 4),
                Text(
                  score.toString(),
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.emeraldTeal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
