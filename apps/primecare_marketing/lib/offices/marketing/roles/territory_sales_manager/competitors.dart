import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TerritoryCompetitorsScreen extends ConsumerStatefulWidget {
  const TerritoryCompetitorsScreen({super.key});

  @override
  ConsumerState<TerritoryCompetitorsScreen> createState() =>
      _TerritoryCompetitorsScreenState();
}

class _TerritoryCompetitorsScreenState
    extends ConsumerState<TerritoryCompetitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildMarketOverview(),
          const SizedBox(height: 32),
          Text(
            'Key Competitors',
            style: PrimeCareTheme.typography.h2.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildCompetitorGrid(),
          const SizedBox(height: 48),
          Text(
            'Pricing & Services Matrix',
            style: PrimeCareTheme.typography.h2.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 24),
          _buildCompetitiveMatrix(),
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
            Text(
              'Competitor Analysis',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track market share, pricing, and key competitor movements within your territory.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.calendar,
              label: 'Q3 2026',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Add Competitor',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMarketOverview() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMarketMetric(
            label: 'PrimeCare Market Share',
            value: '34.2%',
            subtext: '+1.5% YoY',
            isPositive: true,
          ),
          Container(
            width: 1,
            height: 60,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildMarketMetric(
            label: 'Main Competitor Share',
            value: '28.5%',
            subtext: '-0.3% YoY',
            isPositive: true,
          ), // Competitor down is good
          Container(
            width: 1,
            height: 60,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildMarketMetric(
            label: 'Avg Price vs Market',
            value: '-4.0%',
            subtext: 'Value Leader',
            isPositive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMarketMetric({
    required String label,
    required String value,
    required String subtext,
    required bool isPositive,
  }) {
    Color subtextColor = isPositive
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.coralRed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: PrimeCareTheme.typography.heroTitle.copyWith(
            color: PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtext,
          style: PrimeCareTheme.typography.label.copyWith(
            color: subtextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCompetitorGrid() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: [
        _buildCompetitorCard(
          name: 'HealthFirst Urgent Care',
          marketShare: '28.5%',
          threatLevel: 'High',
          strengths: ['Brand Recognition', 'Extended Hours'],
          weaknesses: ['Long Wait Times', 'Premium Pricing'],
        ),
        _buildCompetitorCard(
          name: 'Apex Medical Clinics',
          marketShare: '15.0%',
          threatLevel: 'Medium',
          strengths: ['Specialized Services', 'Modern Tech'],
          weaknesses: ['Limited Locations', 'Low Marketing Spend'],
        ),
        _buildCompetitorCard(
          name: 'Local Independent Practices',
          marketShare: '22.3%',
          threatLevel: 'Low',
          strengths: ['Community Trust', 'Personalized Care'],
          weaknesses: ['Fragmented', 'No Digital Access'],
        ),
      ],
    );
  }

  Widget _buildCompetitorCard({
    required String name,
    required String marketShare,
    required String threatLevel,
    required List<String> strengths,
    required List<String> weaknesses,
  }) {
    Color threatColor;
    if (threatLevel == 'High') {
      threatColor = PrimeCareTheme.colors.coralRed;
    } else if (threatLevel == 'Medium') {
      threatColor = Colors.amber.shade700;
    } else {
      threatColor = PrimeCareTheme.colors.emeraldTeal;
    }

    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: threatColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$threatLevel Threat',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: threatColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Icon(
                LucideIcons.moreHorizontal,
                size: 20,
                color: PrimeCareTheme.colors.slateGray,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: PrimeCareTheme.typography.h3.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                LucideIcons.pieChart,
                size: 14,
                color: PrimeCareTheme.colors.slateGray,
              ),
              const SizedBox(width: 8),
              Text(
                'Share: $marketShare',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.trendingUp,
                            size: 14,
                            color: PrimeCareTheme.colors.emeraldTeal,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Strengths',
                            style: PrimeCareTheme.typography.label.copyWith(
                              fontSize: 11,
                              color: PrimeCareTheme.colors.slateGray,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      for (var s in strengths)
                        Text(
                          '• $s',
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.navyIndigo,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.trendingDown,
                            size: 14,
                            color: PrimeCareTheme.colors.coralRed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Weaknesses',
                            style: PrimeCareTheme.typography.label.copyWith(
                              fontSize: 11,
                              color: PrimeCareTheme.colors.slateGray,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      for (var w in weaknesses)
                        Text(
                          '• $w',
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.navyIndigo,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitiveMatrix() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildMatrixHeader(),
          _buildMatrixRow(
            service: 'Standard Consult (Self-Pay)',
            primecare: '\$120',
            competitor1: '\$150',
            competitor2: '\$135',
            advantage: 'PrimeCare',
            isPrimecareWin: true,
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildMatrixRow(
            service: 'Telehealth Availability',
            primecare: '24/7',
            competitor1: '8am - 8pm',
            competitor2: 'None',
            advantage: 'PrimeCare',
            isPrimecareWin: true,
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildMatrixRow(
            service: 'Average Wait Time',
            primecare: '15 mins',
            competitor1: '45 mins',
            competitor2: '20 mins',
            advantage: 'PrimeCare',
            isPrimecareWin: true,
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildMatrixRow(
            service: 'In-House Labs Output',
            primecare: '24 hrs',
            competitor1: '2 hrs (Point of Care)',
            competitor2: '48 hrs',
            advantage: 'HealthFirst',
            isPrimecareWin: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'CORE SERVICE METRIC',
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
              'PRIMECARE V4',
              style: PrimeCareTheme.typography.label.copyWith(
                fontSize: 11,
                color: PrimeCareTheme.colors.emeraldTeal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'HEALTHFIRST (Main)',
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
              'APEX CLINICS',
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
              'ADVANTAGE',
              style: PrimeCareTheme.typography.label.copyWith(
                fontSize: 11,
                color: PrimeCareTheme.colors.slateGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixRow({
    required String service,
    required String primecare,
    required String competitor1,
    required String competitor2,
    required String advantage,
    required bool isPrimecareWin,
  }) {
    Color advantageColor = isPrimecareWin
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.coralRed;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              service,
              style: PrimeCareTheme.typography.h4.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.emeraldTeal.withValues(
                  alpha: 0.05,
                ),
                border: Border.all(
                  color: PrimeCareTheme.colors.emeraldTeal.withValues(
                    alpha: 0.3,
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                primecare,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                competitor1,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                competitor2,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: advantageColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IntrinsicWidth(
                child: Center(
                  child: Text(
                    advantage,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: advantageColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
