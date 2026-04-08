import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RegionalCampaignsScreen extends ConsumerWidget {
  const RegionalCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Regional Marketing Operations',
      subtitle:
          'Analyze clinic marketing performance, budget allocation, and ROI by geographic territory.',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.filter,
            label: 'Filter by Territory',
            isPrimary: false,
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.plus,
            label: 'New Regional Push',
            isPrimary: true,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'Active Campaigns',
          value: '12',
          icon: LucideIcons.flag,
          trend: 4.2,
          trendLabel: 'trend',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Lead Velocity',
          value: '142',
          icon: LucideIcons.zap,
          trend: 0.0,
          trendLabel: 'SQLs / day',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Total Spend',
          value: '\$1.24M',
          icon: LucideIcons.dollarSign,
          trend: 0.0,
          trendLabel: 'Q1-Q4',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Target Reach',
          value: '84%',
          icon: LucideIcons.target,
          trend: 0.0,
          trendLabel: 'Progress to goal',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interactive Campaign Map',
                      style: PrimeCareTheme.typography.h2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          color: PrimeCareTheme.colors.emeraldTeal,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Territories Active',
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.emeraldTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest
                      .withOpacity(0.3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=1200',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.globe,
                        size: 48,
                        color: PrimeCareTheme.colors.emeraldTeal.withOpacity(
                          0.8,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Geospatial Rendering Engine initializing...',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
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
                  Icon(
                    LucideIcons.barChart2,
                    color: PrimeCareTheme.colors.emeraldTeal,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Top Performing Regions',
                    style: PrimeCareTheme.typography.h3,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildRegionRow(
                'North America',
                '\$540k Spend',
                '22%',
                PrimeCareTheme.colors.emeraldTeal,
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildRegionRow('EMEA', '\$315k Spend', '18%', Colors.blue),
              const Divider(color: Colors.white12, height: 24),
              _buildRegionRow(
                'APAC',
                '\$180k Spend',
                '14%',
                PrimeCareTheme.colors.slateGray,
              ),
              const SizedBox(height: 24),
              Text(
                'High concentration of Leads generated in regions aligned with recent Pushes.',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegionRow(
    String region,
    String detail,
    String conversionRate,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.mapPin, size: 16, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  detail,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          conversionRate,
          style: PrimeCareTheme.typography.h3.copyWith(color: color),
        ),
      ],
    );
  }
}
