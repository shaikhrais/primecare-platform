import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class RegionalCampaignsScreen extends ConsumerStatefulWidget {
  const RegionalCampaignsScreen({super.key});

  @override
  ConsumerState<RegionalCampaignsScreen> createState() => _RegionalCampaignsScreenState();
}

class _RegionalCampaignsScreenState extends ConsumerState<RegionalCampaignsScreen> {
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
                Expanded(flex: 3, child: _buildRegionalPerformanceTable()),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: _buildRegionalHeatmapPlaceholder()),
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
              'Regional Campaigns Dashboard',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze clinic marketing performance, budget allocation, and ROI by geographic territory.',
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
              icon: LucideIcons.filter,
              label: 'Filter by Territory',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'New Regional Push',
              isActive: true,
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
            'Total Regional Budget',
            '\$2.4M',
            'Q1 - Q4 Allocation',
            LucideIcons.dollarSign,
            PrimeCareTheme.colors.slateGray,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Top Performing Region',
            'US Northeast',
            '+14% above projection',
            LucideIcons.award,
            PrimeCareTheme.colors.navyIndigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Average Regional CPA',
            '\$145',
            'Target: < \$150',
            LucideIcons.target,
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            'Active Local Pushes',
            '42',
            'Across 12 territories',
            LucideIcons.map,
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

  Widget _buildRegionalPerformanceTable() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Territory Performance',
                  style: PrimeCareTheme.typography.h2.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalSearchTextField(hintText: 'Search regions...'),
              ],
            ),
          ),
          _buildTableHeader(),
          _buildTableRow(
            region: 'US Northeast',
            leads: 1450,
            spend: 180000,
            budget: 200000,
            roi: '4.2x',
            status: 'Optimal',
          ),
          _buildTableRow(
            region: 'US South',
            leads: 920,
            spend: 110000,
            budget: 150000,
            roi: '2.8x',
            status: 'Monitoring',
          ),
          _buildTableRow(
            region: 'EU West',
            leads: 1100,
            spend: 95000,
            budget: 120000,
            roi: '3.5x',
            status: 'Optimal',
          ),
          _buildTableRow(
            region: 'APAC Region',
            leads: 450,
            spend: 80000,
            budget: 90000,
            roi: '1.4x',
            status: 'Underperforming',
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          top: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('REGION / TERRITORY', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 2, child: Text('LEADS', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 3, child: Text('SPEND VS BUDGET', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 2, child: Text('ROI', style: PrimeCareTheme.typography.label)),
          Expanded(flex: 2, child: Text('STATUS', style: PrimeCareTheme.typography.label)),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required String region,
    required int leads,
    required double spend,
    required double budget,
    required String roi,
    required String status,
  }) {
    Color statusColor;
    if (status == 'Optimal') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Monitoring') {
      statusColor = Colors.amber.shade700;
    } else {
      statusColor = PrimeCareTheme.colors.coralRed;
    }

    final budgetPct = (spend / budget).clamp(0.0, 1.0);

    String formatCurrency(double val) {
      if (val >= 1000) return '\$${(val / 1000).toStringAsFixed(0)}k';
      return '\$${val.toStringAsFixed(0)}';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Icon(LucideIcons.mapPin, size: 16, color: PrimeCareTheme.colors.navyIndigo),
                const SizedBox(width: 8),
                Text(
                  region,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              leads.toString(),
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${formatCurrency(spend)} / ${formatCurrency(budget)}',
                      style: PrimeCareTheme.typography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: budgetPct,
                  backgroundColor: PrimeCareTheme.colors.surfaceContainerLow,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    budgetPct > 0.9 ? PrimeCareTheme.colors.errorContainer : PrimeCareTheme.colors.navyIndigo,
                  ),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                roi,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: PrimeCareTheme.colors.emeraldTeal,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalHeatmapPlaceholder() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Geographic Penetration',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(LucideIcons.globe, color: PrimeCareTheme.colors.slateGray, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.map, size: 48, color: PrimeCareTheme.colors.slateGray.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text(
                    'Interactive Map View',
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Top Growth Markets',
            style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 16),
          _buildMarketRow('1. Texas, US', '+28%'),
          _buildMarketRow('2. Ontario, CA', '+22%'),
          _buildMarketRow('3. London, UK', '+15%'),
        ],
      ),
    );
  }

  Widget _buildMarketRow(String market, String growth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(market, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          Text(growth, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.emeraldTeal, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
