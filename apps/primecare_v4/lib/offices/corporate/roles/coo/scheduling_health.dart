import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SchedulingHealthScreen extends StatelessWidget {
  const SchedulingHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildCoverageTable(context),
                            const SizedBox(height: 24),
                            _buildTurnoverRate(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildUrgentGaps(context),
                            const SizedBox(height: 24),
                            _buildAttendanceMetrics(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduling Health',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Monitor franchise-wide shift coverage, attendance, and staffing gaps',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(
              context,
              LucideIcons.calendarRange,
              'Date Range',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.download,
              'Export Metrics',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(
    BuildContext context,
    IconData icon,
    String tooltip,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildKPIUnit(
            context,
            'Global Coverage',
            '96.5%',
            LucideIcons.calendarCheck,
            '+1.5%',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Avg Attendance',
            '98.1%',
            LucideIcons.userCheck,
            '+0.2%',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Caregiver Turnover',
            '12.4%',
            LucideIcons.userMinus,
            '-2.1%',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Urgent Shift Gaps',
            '8',
            LucideIcons.alertTriangle,
            '+3',
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildKPIUnit(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String trend,
    Color trendColor,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: PrimeCareTheme.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    color: trendColor,
                    fontSize: 12,
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

  Widget _buildCoverageTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Branch Coverage Status',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(LucideIcons.moreHorizontal, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Branch')),
                DataColumn(label: Text('Coverage Req.')),
                DataColumn(label: Text('Actual Fill')),
                DataColumn(label: Text('Health Status')),
              ],
              rows: [
                _buildDataRow(
                  'Toronto Central',
                  '1,200 hrs',
                  '98%',
                  'Healthy',
                  PrimeCareTheme.emeraldTeal,
                ),
                _buildDataRow(
                  'Vancouver West',
                  '850 hrs',
                  '95%',
                  'Stable',
                  Colors.white,
                ),
                _buildDataRow(
                  'Calgary North',
                  '600 hrs',
                  '82%',
                  'At Risk',
                  Colors.orange,
                ),
                _buildDataRow(
                  'Montreal Hub',
                  '1,100 hrs',
                  '99%',
                  'Healthy',
                  PrimeCareTheme.emeraldTeal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String branch,
    String req,
    String fill,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(branch, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(req, style: const TextStyle(color: Colors.white70))),
        DataCell(
          Text(fill, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUrgentGaps(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.alertCircle,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Urgent Shift Gaps',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '8',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildGapItem(
            'Calgary North',
            'RN - ICU Certified',
            'Starts in 4h',
            Colors.redAccent,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildGapItem('Vancouver West', 'PSW', 'Starts in 6h', Colors.orange),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                foregroundColor: Colors.white,
                elevation: 0,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text('Broadcast Emergency Shifts'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGapItem(
    String location,
    String role,
    String urgency,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              role,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              urgency,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          location,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTurnoverRate(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.users,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Caregiver Turnover Breakdown',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(
                child: _TurnoverBar(label: 'PSW', value: 0.15, isHigh: true),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _TurnoverBar(label: 'RN', value: 0.08, isHigh: false),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _TurnoverBar(label: 'RPN', value: 0.12, isHigh: false),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _TurnoverBar(label: 'Admin', value: 0.05, isHigh: false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceMetrics(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.activity,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Attendance Overview',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMetricRow('On-Time Arrivals', '92%'),
          const SizedBox(height: 12),
          _buildMetricRow('Late Starts (Avg 14m)', '6%'),
          const SizedBox(height: 12),
          _buildMetricRow('No-Shows', '2%'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TurnoverBar extends StatelessWidget {
  final String label;
  final double value;
  final bool isHigh;

  const _TurnoverBar({
    required this.label,
    required this.value,
    required this.isHigh,
  });

  @override
  Widget build(BuildContext context) {
    Color barColor = isHigh ? Colors.orange : PrimeCareTheme.emeraldTeal;
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 40,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                heightFactor: value * 3, // scale for visual
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${(value * 100).toInt()}%',
          style: TextStyle(
            color: barColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }
}
