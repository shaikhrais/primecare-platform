import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class CeoAlertsAndRisksScreen extends ConsumerStatefulWidget {
  const CeoAlertsAndRisksScreen({super.key});

  @override
  ConsumerState<CeoAlertsAndRisksScreen> createState() =>
      _CeoAlertsAndRisksScreenState();
}

class _CeoAlertsAndRisksScreenState
    extends ConsumerState<CeoAlertsAndRisksScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildKPIs(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildActionRequiredTable()),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: Column(children: [_buildRiskMatrixWidget()]),
              ),
            ],
          ),
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
            Row(
              children: [
                Icon(
                  LucideIcons.alertTriangle,
                  color: Colors.amber.shade700,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Corporate Alerts & Risks',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Monitor enterprise-level critical alerts, operational risks, and compliance breaches.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.filter,
                    size: 18,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Critical Only',
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    LucideIcons.chevronDown,
                    size: 18,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.bellRing,
              label: 'Acknowledge All',
              isActive: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPIs() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            title: 'Critical Alerts',
            value: '3',
            icon: LucideIcons.alertOctagon,
            trend: 'Requires immediate attention',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Active Enterprise Risks',
            value: '12',
            icon: LucideIcons.shieldAlert,
            trend: '4 High, 8 Medium',
            isWarning: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Compliance Breaches',
            value: '0',
            icon: LucideIcons.shieldCheck,
            trend: 'Across all regions',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildMetricCard(
            title: 'Days Since Major Incident',
            value: '142',
            icon: LucideIcons.calendarCheck,
            trend: 'Target: 365 Days',
            isPositive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required String trend,
    bool isWarning = false,
    bool isPositive = false,
    bool isNeutral = false,
  }) {
    Color trendColor = PrimeCareTheme.colors.slateGray;
    Color iconColor = PrimeCareTheme.colors.navyIndigo;
    Color valueColor = PrimeCareTheme.colors.navyIndigo;

    if (isWarning) {
      trendColor = Colors.amber.shade700;
      iconColor = Colors.amber.shade700;
      valueColor = Colors.amber.shade700;
      if (value == '3' || value == '12') {
        valueColor = Colors.amber.shade700;
        trendColor = Colors.amber.shade700;
      }
    } else if (isPositive) {
      trendColor = PrimeCareTheme.colors.emeraldTeal;
      iconColor = PrimeCareTheme.colors.emeraldTeal;
      valueColor = PrimeCareTheme.colors.navyIndigo;
    } else if (isNeutral) {
      trendColor = PrimeCareTheme.colors.navyIndigo;
    }

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
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: PrimeCareTheme.typography.h1.copyWith(color: valueColor),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: PrimeCareTheme.typography.label.copyWith(
              color: trendColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRequiredTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Executive Action Required',
                      style: PrimeCareTheme.typography.h3.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Alerts requiring immediate CEO or Board-level review.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: PrimeCareTheme.colors.surfaceContainerLow,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'SEVERITY',
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
                    'ALERT TYPE',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'CONTEXT / DETAILS',
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'TIME',
                    textAlign: TextAlign.right,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontSize: 11,
                      color: PrimeCareTheme.colors.slateGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildAlertRow(
            'Critical',
            'Financial Variance',
            'Revenue in Region 3 fell 15% below projected target for Q3.',
            '2 hrs ago',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildAlertRow(
            'Critical',
            'Regulatory Audit',
            'Notice received: Unannounced state health audit in California branches upcoming.',
            '5 hrs ago',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildAlertRow(
            'High',
            'Contract Expiry',
            'Major hospital partnership contract (H-245) expiring in 30 days without renewal draft.',
            '1 day ago',
          ),
          Divider(
            height: 1,
            color: PrimeCareTheme.colors.surfaceContainerHighest,
          ),
          _buildAlertRow(
            'Medium',
            'System Performance',
            'PrimeCare Core API latency spiked above SLA thresholds during peak hours.',
            '2 days ago',
          ),
        ],
      ),
    );
  }

  Widget _buildAlertRow(
    String severity,
    String type,
    String details,
    String time,
  ) {
    Color sevColor = PrimeCareTheme.colors.slateGray;
    if (severity == 'Critical') sevColor = const Color(0xFFE11D48); // Ruby Red
    if (severity == 'High') sevColor = Colors.amber.shade700;
    if (severity == 'Medium') sevColor = PrimeCareTheme.colors.navyIndigo;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: sevColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  severity.toUpperCase(),
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: sevColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              type,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              details,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              time,
              textAlign: TextAlign.right,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskMatrixWidget() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Risk Matrix Overview',
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              Icon(
                LucideIcons.grid,
                color: PrimeCareTheme.colors.slateGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildRiskItem('Legal / Regulatory', 'High', const Color(0xFFE11D48)),
          const SizedBox(height: 16),
          _buildRiskItem(
            'Financial Stability',
            'Medium',
            Colors.amber.shade700,
          ),
          const SizedBox(height: 16),
          _buildRiskItem(
            'Operational Execution',
            'Medium',
            Colors.amber.shade700,
          ),
          const SizedBox(height: 16),
          _buildRiskItem(
            'Technology / Cyber',
            'Low',
            PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildRiskItem(
            'Reputational',
            'Low',
            PrimeCareTheme.colors.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String category, String level, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            category,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            level.toUpperCase(),
            style: PrimeCareTheme.typography.label.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
