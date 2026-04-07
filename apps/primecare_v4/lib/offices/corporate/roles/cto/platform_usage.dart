import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PlatformUsageScreen extends StatelessWidget {
  const PlatformUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Platform Usage & Capacity',
      subtitle:
          'Monitor concurrency, active sessions, storage tiers, and capacity planning.',
      headerTrailing: [
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Scale Tiers',
          icon: LucideIcons.cloudRain,
          isPrimary: true,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Export Usage',
          icon: LucideIcons.download,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Peak Concurrency',
          value: '4,280',
          icon: LucideIcons.users,
          trend: 'Users/min',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Total Storage Used',
          value: '14.2 TB',
          icon: LucideIcons.database,
          trend: '78% of provisioned',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        KPICardData(
          title: 'MAU',
          value: '124.5k',
          icon: LucideIcons.activity,
          trend: '+12% MoM',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Capacity Headroom',
          value: '6.5 Mo',
          icon: LucideIcons.calendar,
          trend: 'Before auto-scale',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
      ],
      mainContent: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildConcurrencyChart(),
                  const SizedBox(height: 24),
                  _buildActiveSessionsList(),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildStorageUtilization(),
                  const SizedBox(height: 24),
                  _buildCapacityForecast(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConcurrencyChart() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '24h Concurrency Timeline',
                style: PrimeCareTheme.typography.h3,
              ),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'Filter by Region',
                icon: LucideIcons.filter,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.cloudGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.barChart2,
                    size: 48,
                    color: PrimeCareTheme.colors.slateGray.withOpacity(0.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Concurrency Spline Chart Placeholder',
                    style: PrimeCareTheme.typography.label,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSessionsList() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Session Distribution',
                style: PrimeCareTheme.typography.h3,
              ),
              Icon(
                LucideIcons.moreHorizontal,
                color: PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSessionRow(
            'US East (N. Virginia)',
            1845,
            0.45,
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildSessionRow(
            'US West (Oregon)',
            1220,
            0.30,
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildSessionRow(
            'EU Central (Frankfurt)',
            840,
            0.20,
            PrimeCareTheme.colors.navyIndigo,
          ),
          const SizedBox(height: 16),
          _buildSessionRow(
            'AP South (Mumbai)',
            375,
            0.05,
            PrimeCareTheme.colors.amberWarning,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionRow(
    String region,
    int sessions,
    double fraction,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(region, style: PrimeCareTheme.typography.body),
            Text(
              '$sessions',
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            backgroundColor: PrimeCareTheme.colors.cloudGray,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildStorageUtilization() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Storage Tier Utilization', style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 24),
          _buildStorageTier(
            'Hot (SSD)',
            '4.2 TB',
            '6.0 TB',
            0.70,
            PrimeCareTheme.colors.amberWarning,
          ),
          const SizedBox(height: 20),
          _buildStorageTier(
            'Warm (HDD)',
            '8.1 TB',
            '10.0 TB',
            0.81,
            PrimeCareTheme.colors.amberWarning,
          ),
          const SizedBox(height: 20),
          _buildStorageTier(
            'Cold (Glacier)',
            '1.9 TB',
            'Unlimited',
            0.1,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildStorageTier(
    String name,
    String used,
    String total,
    double fill,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$used / $total',
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fill,
            backgroundColor: PrimeCareTheme.colors.cloudGray,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildCapacityForecast() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  LucideIcons.trendingUp,
                  color: PrimeCareTheme.colors.emeraldTeal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text('Capacity Forecaster', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Predicted threshold crossing for Database Compute tier (R5.4xlarge) based on current linear growth vector.',
            style: PrimeCareTheme.typography.label,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.cloudGray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Est. Crossing Date',
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Nov 15, 2026',
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.amberWarning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ClinicalGlassButton(
              onPressed: () {},
              label: 'Provision Next Tier Now',
              isPrimary: false,
            ),
          ),
        ],
      ),
    );
  }
}

