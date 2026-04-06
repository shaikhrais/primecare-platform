import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FunnelAnalyticsScreen extends ConsumerStatefulWidget {
  const FunnelAnalyticsScreen({super.key});

  @override
  ConsumerState<FunnelAnalyticsScreen> createState() => _FunnelAnalyticsScreenState();
}

class _FunnelAnalyticsScreenState extends ConsumerState<FunnelAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildMetricCards(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildMainFunnel()),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildChannelBreakdown()),
              ],
            )
          ],
        ),
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
              'Funnel Analytics Dashboard',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comprehensive breakdown of the patient acquisition funnel over the last 30 days.',
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
              icon: LucideIcons.download,
              label: 'Export Report',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.calendar,
              label: 'Last 30 Days',
              isActive: true, // Primary action
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCards() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Total Impressions',
            '1.25M',
            '+5.2% vs last period',
            LucideIcons.eye,
            PrimeCareTheme.colors.slateGray,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Aggregate CTR',
            '2.4%',
            '0.2% above benchmark',
            LucideIcons.mousePointerClick,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Cost Per Lead',
            '\$118',
            '-12% vs last period',
            LucideIcons.dollarSign,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Total Patients (Acquired)',
            '1,328',
            '+8.1% vs last period',
            LucideIcons.userCheck,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color accentColor) {
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.display.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainFunnel() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Global Funnel Stages', style: PrimeCareTheme.typography.h2.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
          const SizedBox(height: 8),
          Text('End-to-end patient acquisition journey across all channels.', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          const SizedBox(height: 48),
          _buildFunnelStageModern('Impressions', '1,250,400', '100%', PrimeCareTheme.colors.surfaceContainerHighest, 1.0, LucideIcons.eye),
          _buildConnectingArrowModern('2.4% CTR'),
          _buildFunnelStageModern('Clicks', '30,009', '2.4%', PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.1), 0.85, LucideIcons.mousePointerClick),
          _buildConnectingArrowModern('12% Conv. Rate'),
          _buildFunnelStageModern('Leads Generated (MQLs)', '3,601', '0.28%', PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.3), 0.70, LucideIcons.filter),
          _buildConnectingArrowModern('45% Qual. Rate'),
          _buildFunnelStageModern('Consultations Booked (SQLs)', '1,620', '0.12%', PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.7), 0.55, LucideIcons.calendarCheck),
          _buildConnectingArrowModern('82% Show Rate'),
          _buildFunnelStageModern('New Patients', '1,328', '0.10%', PrimeCareTheme.colors.navyIndigo, 0.40, LucideIcons.userCheck),
        ],
      ),
    );
  }

  Widget _buildFunnelStageModern(String title, String value, String initialPct, Color bgColor, double widthRatio, IconData icon) {
    bool isDark = widthRatio <= 0.55; 
    Color textColor = isDark ? Colors.white : PrimeCareTheme.colors.navyIndigo;
    Color subTextColor = isDark ? Colors.white.withValues(alpha: 0.8) : PrimeCareTheme.colors.slateGray;

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
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: subTextColor, size: 20),
                  const SizedBox(width: 12),
                  Text(title, style: PrimeCareTheme.typography.h3.copyWith(color: textColor)),
                ],
              ),
              Row(
                children: [
                  Text(initialPct, style: PrimeCareTheme.typography.label.copyWith(color: subTextColor)),
                  const SizedBox(width: 16),
                  Text(value, style: PrimeCareTheme.typography.h2.copyWith(color: textColor, fontWeight: FontWeight.bold)),
                ],
              )
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
                border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.arrowDown, color: PrimeCareTheme.colors.emeraldTeal, size: 16),
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

  Widget _buildChannelBreakdown() {
    return ClinicalGlassPanel(
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
              Icon(LucideIcons.pieChart, color: PrimeCareTheme.colors.slateGray, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _buildChannelRow('Organic Search', 45, PrimeCareTheme.colors.emeraldTeal),
          const SizedBox(height: 24),
          _buildChannelRow('Paid Social (Meta)', 30, PrimeCareTheme.colors.navyIndigo),
          const SizedBox(height: 24),
          _buildChannelRow('Google Ads (PPC)', 15, PrimeCareTheme.colors.emeraldTeal.withValues(alpha: 0.6)),
          const SizedBox(height: 24),
          _buildChannelRow('Referrals', 10, PrimeCareTheme.colors.slateGray),
          
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
    );
  }

  Widget _buildChannelRow(String name, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.w600)),
            Text('${percentage.toInt()}%', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
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
                  color: (isPositive ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.errorContainer).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: isPositive ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.errorContainer,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
