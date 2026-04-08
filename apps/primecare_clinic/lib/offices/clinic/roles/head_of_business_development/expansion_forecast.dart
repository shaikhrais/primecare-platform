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
              const SizedBox(height: 24),
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
                      'Quarterly Trajectory (Baseline Model)',
                      style: PrimeCareTheme.typography.h2,
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.moreHorizontal),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // High-fidelity chart visualization area
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest
                      .withOpacity(0.3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://via.placeholder.com/1200x350/0f172c/48ddbc?text=Forecast+Visualization+Line+Chart',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ClinicalGlassButton(
                      label: 'Adjust Parameters',
                      icon: LucideIcons.sliders,
                      onPressed: () {},
                      isPrimary: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Regional Projections', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8), // No borders for a cleaner look
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? LucideIcons.checkCircle : LucideIcons.circle,
            color: isSelected
                ? PrimeCareTheme.colors.emeraldTeal
                : PrimeCareTheme.colors.slateGray,
            size: 20,
          ),
          const SizedBox(width: 16),
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
                    color: isSelected
                        ? PrimeCareTheme.colors.emeraldTeal
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
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
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              region,
              style: PrimeCareTheme.typography.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(revenue, style: PrimeCareTheme.typography.body),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
