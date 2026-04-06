import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class TerritoryAreaPerformanceScreen extends ConsumerStatefulWidget {
  const TerritoryAreaPerformanceScreen({super.key});

  @override
  ConsumerState<TerritoryAreaPerformanceScreen> createState() => _TerritoryAreaPerformanceScreenState();
}

class _TerritoryAreaPerformanceScreenState extends ConsumerState<TerritoryAreaPerformanceScreen> {
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
            _buildMetricsOverview(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildFranchisePerformanceList(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: _buildTargetPacing(),
                ),
              ],
            ),
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
              'Area Performance',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Territory-wide roll-up of sales metrics and franchise health.',
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
              icon: LucideIcons.download,
              label: 'Export Roll-Up',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsOverview() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Territory Revenue (QTD)',
            value: '\$1.24M',
            trend: '+8.2%',
            positiveTrend: true,
            icon: LucideIcons.dollarSign,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Active Patients (Territory)',
            value: '18,450',
            trend: '+4.1%',
            positiveTrend: true,
            icon: LucideIcons.users,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Revenue per Patient',
            value: '\$67.20',
            trend: '+1.5%',
            positiveTrend: true,
            icon: LucideIcons.activity,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Avg Churn Rate',
            value: '4.2%',
            trend: '+0.5%',
            positiveTrend: false, // higher churn is bad
            icon: LucideIcons.userMinus,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({required String title, required String value, required String trend, required bool positiveTrend, required IconData icon}) {
    Color trendColor = positiveTrend ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed;
    IconData trendIcon = positiveTrend ? LucideIcons.trendingUp : LucideIcons.trendingDown;

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
              Icon(icon, size: 16, color: PrimeCareTheme.colors.surfaceContainerHighest),
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
          Row(
            children: [
              Icon(trendIcon, size: 16, color: trendColor),
              const SizedBox(width: 4),
              Text(
                '$trend vs. Prior Qtr',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: trendColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetPacing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Pacing (QTD)',
          style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPacingRow(label: 'Revenue Target', current: 1.24, target: 1.5, unit: 'M'),
              const SizedBox(height: 24),
              _buildPacingRow(label: 'New Patient Target', current: 1200, target: 1500, unit: ''),
              const SizedBox(height: 24),
              _buildPacingRow(label: 'Consult Conv. Target', current: 28, target: 35, unit: '%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPacingRow({required String label, required double current, required double target, required String unit}) {
    double progress = (current / target).clamp(0.0, 1.0);
    bool onTrack = progress >= 0.8; // Simplistic on track logic
    Color progressColor = onTrack ? PrimeCareTheme.colors.emeraldTeal : Colors.amber.shade700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
            Text('${current.toStringAsFixed(1)}$unit / ${target.toStringAsFixed(1)}$unit', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('${(progress * 100).toStringAsFixed(0)}% Pacing', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: progressColor, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }

  Widget _buildFranchisePerformanceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Franchise Clinic Breakdown',
              style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.navyIndigo),
            ),
            Row(
              children: [
                Icon(LucideIcons.listFilter, size: 20, color: PrimeCareTheme.colors.slateGray),
                const SizedBox(width: 8),
                Text('Sort by: Revenue', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        ClinicalGlassPanel(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildFranchiseTableHeader(),
              _buildFranchiseRow(name: 'Oakville Center', status: 'At Risk', revenue: '\$240k', patCounts: '3,200', churn: '6.1%', m2mRev: '-2.4%'),
              Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
              _buildFranchiseRow(name: 'Maplewood Clinic', status: 'Healthy', revenue: '\$410k', patCounts: '5,100', churn: '3.2%', m2mRev: '+5.1%'),
              Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
              _buildFranchiseRow(name: 'Cedar Point', status: 'Healthy', revenue: '\$350k', patCounts: '4,800', churn: '3.9%', m2mRev: '+2.1%'),
              Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
              _buildFranchiseRow(name: 'Pine Valley', status: 'Caution', revenue: '\$240k', patCounts: '5,350', churn: '4.8%', m2mRev: '+0.5%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFranchiseTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('CLINIC', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('REVENUE (QTD)', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('PATIENTS', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('CHURN RATE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('M/M REV GROWTH', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildFranchiseRow({
    required String name,
    required String status,
    required String revenue,
    required String patCounts,
    required String churn,
    required String m2mRev,
  }) {
    Color statusColor;
    if (status == 'Healthy') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Caution') {
      statusColor = Colors.amber.shade700;
    } else {
      statusColor = PrimeCareTheme.colors.coralRed;
    }

    bool isRevUp = m2mRev.startsWith('+');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: PrimeCareTheme.typography.h4.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(status, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(revenue, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(patCounts, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ),
          Expanded(
            flex: 2,
            child: Text(churn, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  isRevUp ? LucideIcons.arrowUp : LucideIcons.arrowDown,
                  size: 14,
                  color: isRevUp ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed,
                ),
                const SizedBox(width: 4),
                Text(m2mRev, style: PrimeCareTheme.typography.body.copyWith(color: isRevUp ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.coralRed, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(LucideIcons.chevronRight, color: PrimeCareTheme.colors.slateGray),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
