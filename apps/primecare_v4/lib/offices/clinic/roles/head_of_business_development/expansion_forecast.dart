import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ExpansionForecastScreen extends ConsumerWidget {
  const ExpansionForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Expansion Forecast',
      subtitle: 'Predictive modeling for future franchise and clinic growth.',
      kpiCards: [
        KPICardData(
          title: 'Projected Q3 Growth',
          value: '+15%',
          icon: LucideIcons.trendingUp,
          trend: 2.5,
          trendLabel: 'vs conservative model',
        ),
        KPICardData(
          title: 'Est. Revenue Impact',
          value: '\$8.5M',
          icon: LucideIcons.dollarSign,
          trend: 10.0,
          trendLabel: 'expected by year end',
        ),
        KPICardData(
          title: 'Target Locations',
          value: '12',
          icon: LucideIcons.mapPin,
          trend: 0.0,
          trendLabel: 'active in forecast',
        ),
        KPICardData(
          title: 'Risk Adjusted ROI',
          value: '22%',
          icon: LucideIcons.barChart2,
          trend: -1.2,
          trendLabel: 'due to market shifts',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forecast Models', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildModelSelector(
                'Aggressive Growth',
                'High risk, high reward',
                false,
              ),
              _buildModelSelector(
                'Baseline (Current)',
                'Standard trajectory',
                true,
              ),
              _buildModelSelector('Conservative', 'Recession adjusted', false),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Key Variables', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildVariableRow('Interest Rates', 'Stable at 4.5%'),
              _buildVariableRow('Market Demand', 'Increasing (+8%)'),
              _buildVariableRow('Competitor Action', 'Moderate'),
              _buildVariableRow('Supply Chain', 'Delayed (30 days)'),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quarterly Trajectory (Baseline Model)',
                style: PrimeCareTheme.typography.h2,
              ),
              const SizedBox(height: 24),
              // Placeholder for a chart, using a styled container
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.lineChart,
                        size: 48,
                        color: PrimeCareTheme.colors.navyIndigo.withOpacity(
                          0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Interactive Chart Visualization',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Regional Projections', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildProjectionRow('Ontario', '\$4.2M expected', '+12%', true),
              _buildProjectionRow(
                'British Columbia',
                '\$2.1M expected',
                '+8%',
                true,
              ),
              _buildProjectionRow('Alberta', '\$1.0M expected', '-2%', false),
              _buildProjectionRow(
                'Nova Scotia',
                '\$1.2M expected',
                '+15%',
                true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModelSelector(String name, String description, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.navyIndigo.withOpacity(0.05)
            : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? PrimeCareTheme.colors.navyIndigo
              : PrimeCareTheme.colors.surfaceContainerHighest,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? LucideIcons.checkCircle : LucideIcons.circle,
            color: isSelected
                ? PrimeCareTheme.colors.navyIndigo
                : PrimeCareTheme.colors.slateGray,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: PrimeCareTheme.typography.body.copyWith(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                Text(
                  description,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariableRow(String variable, String state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(variable, style: PrimeCareTheme.typography.body),
          Text(
            state,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectionRow(
    String region,
    String revenue,
    String growth,
    bool isPositive,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(
              0.5,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              region,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(revenue, style: PrimeCareTheme.typography.body)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPositive
                  ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1)
                  : PrimeCareTheme.colors.coralRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              growth,
              style: PrimeCareTheme.typography.label.copyWith(
                color: isPositive
                    ? PrimeCareTheme.colors.emeraldTeal
                    : PrimeCareTheme.colors.coralRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
