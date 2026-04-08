import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class FunnelAnalyticsScreen extends ConsumerWidget {
  const FunnelAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Funnel Analytics Dashboard',
      subtitle:
          'Comprehensive breakdown of the patient acquisition funnel over the last 30 days.',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.download,
            label: 'Export Report',
            isPrimary: false,
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.calendar,
            label: 'Last 30 Days',
            isPrimary: true,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'Total Impressions',
          value: '1.25M',
          icon: LucideIcons.eye,
          trend: 5.2,
          trendLabel: 'vs last period',
          color: PrimeCareTheme.colors.slateGray,
        ),
        KPICardData(
          title: 'Aggregate CTR',
          value: '2.4%',
          icon: LucideIcons.mousePointerClick,
          trend: 0.2, // Arbitrary representation
          trendLabel: 'above benchmark',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Cost Per Lead',
          value: '\$118',
          icon: LucideIcons.dollarSign,
          trend: -12.0,
          trendLabel: 'vs last period',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Total Patients (Acquired)',
          value: '1,328',
          icon: LucideIcons.userCheck,
          trend: 8.1,
          trendLabel: 'vs last period',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Global Funnel Stages',
                style: PrimeCareTheme.typography.h2.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'End-to-end patient acquisition journey across all channels.',
                style: PrimeCareTheme.typography.body.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 48),
              _buildFunnelStageModern(
                'Impressions',
                '1,250,400',
                '100%',
                PrimeCareTheme.colors.surfaceContainerHighest,
                1.0,
                LucideIcons.eye,
              ),
              _buildConnectingArrowModern('2.4% CTR'),
              _buildFunnelStageModern(
                'Clicks',
                '30,009',
                '2.4%',
                PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.1),
                0.85,
                LucideIcons.mousePointerClick,
              ),
              _buildConnectingArrowModern('12% Conv. Rate'),
              _buildFunnelStageModern(
                'Leads Generated (MQLs)',
                '3,601',
                '0.28%',
                PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.3),
                0.70,
                LucideIcons.filter,
              ),
              _buildConnectingArrowModern('45% Qual. Rate'),
              _buildFunnelStageModern(
                'Consultations Booked (SQLs)',
                '1,620',
                '0.12%',
                PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.7),
                0.55,
                LucideIcons.calendarCheck,
              ),
              _buildConnectingArrowModern('82% Show Rate'),
              _buildFunnelStageModern(
                'New Patients',
                '1,328',
                '0.10%',
                PrimeCareTheme.colors.navyIndigo,
                0.40,
                LucideIcons.userCheck,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Channels',
                    style: PrimeCareTheme.typography.h3.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                  Icon(
                    LucideIcons.pieChart,
                    color: PrimeCareTheme.colors.slateGray,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildChannelRow(
                'Organic Search',
                45,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              const SizedBox(height: 24),
              _buildChannelRow(
                'Paid Social (Meta)',
                30,
                PrimeCareTheme.colors.navyIndigo,
              ),
              const SizedBox(height: 24),
              _buildChannelRow(
                'Google Ads (PPC)',
                15,
                PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 24),
              _buildChannelRow(
                'Referrals',
                10,
                PrimeCareTheme.colors.slateGray,
              ),

              const SizedBox(height: 32),
              Text(
                'Channel ROI Overview',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 16),
              _buildRoiCard('Organic Search', '8.4x', '+1.2x'),
              const SizedBox(height: 12),
              _buildRoiCard('Paid Social', '3.2x', '-0.4x'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFunnelStageModern(
    String title,
    String value,
    String initialPct,
    Color bgColor,
    double widthRatio,
    IconData icon,
  ) {
    bool isDark = widthRatio <= 0.55;
    Color textColor = isDark ? Colors.white : PrimeCareTheme.colors.navyIndigo;
    Color subTextColor = isDark
        ? Colors.white.withValues(alpha: 0.8)
        : PrimeCareTheme.colors.slateGray;

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthRatio,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: subTextColor, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: PrimeCareTheme.typography.h3.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    initialPct,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: subTextColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    value,
                    style: PrimeCareTheme.typography.h2.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectingArrowModern(String dropOffText) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.arrowDown,
                    color: PrimeCareTheme.colors.emeraldTeal,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    dropOffText,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.emeraldTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelRow(String name, double percentage, Color color) {
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
              '${percentage.toInt()}%',
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildRoiCard(String title, String roi, String trend) {
    bool isPositive = trend.startsWith('+');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          Row(
            children: [
              Text(
                roi,
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      (isPositive
                              ? PrimeCareTheme.colors.emeraldTeal
                              : PrimeCareTheme.colors.errorContainer)
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: isPositive
                        ? PrimeCareTheme.colors.emeraldTeal
                        : PrimeCareTheme.colors.errorContainer,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
