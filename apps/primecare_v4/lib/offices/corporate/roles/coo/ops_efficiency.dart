import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OpsEfficiencyScreen extends StatelessWidget {
  const OpsEfficiencyScreen({super.key});

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
                            _buildEfficiencyTable(context),
                            const SizedBox(height: 24),
                            _buildResourceUtilization(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildLogisticsOverhead(context),
                            const SizedBox(height: 24),
                            _buildBottlenecksCard(context),
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
              'Operations Efficiency',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Analyze cost per shift, equipment use, and identifying workflow bottlenecks',
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
              LucideIcons.calendar,
              'Select Quarter',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.fileSpreadsheet,
              'Export Data',
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
            'Avg Cost Per Shift',
            '\$145.20',
            LucideIcons.dollarSign,
            '-4.1%',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Equipment Util.',
            '88%',
            LucideIcons.stethoscope,
            '+5%',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Logistics Overhead',
            '14.2%',
            LucideIcons.truck,
            '+1.5%',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Workflow Delay',
            '18m',
            LucideIcons.clock,
            '-2m',
            PrimeCareTheme.emeraldTeal,
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
    bool isPositive = trendColor == PrimeCareTheme.emeraldTeal;
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
                child: Row(
                  children: [
                    Icon(
                      isPositive
                          ? LucideIcons.trendingDown
                          : LucideIcons.trendingUp,
                      size: 12,
                      color: trendColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trend,
                      style: TextStyle(
                        color: trendColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Branch Efficiency Matrix',
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
                DataColumn(label: Text('Cost/Shift')),
                DataColumn(label: Text('Eq Use')),
                DataColumn(label: Text('Overhead')),
              ],
              rows: [
                _buildDataRow(
                  'Toronto Central',
                  '\$142.10',
                  '92%',
                  '12.5%',
                  PrimeCareTheme.emeraldTeal,
                ),
                _buildDataRow(
                  'Vancouver West',
                  '\$155.00',
                  '85%',
                  '15.2%',
                  Colors.orange,
                ),
                _buildDataRow(
                  'Calgary North',
                  '\$160.40',
                  '80%',
                  '18.4%',
                  Colors.redAccent,
                ),
                _buildDataRow(
                  'Montreal Hub',
                  '\$138.90',
                  '95%',
                  '11.0%',
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
    String cost,
    String eqUse,
    String overhead,
    Color efficiencyColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(branch, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(cost)),
        DataCell(Text(eqUse)),
        DataCell(
          Text(
            overhead,
            style: TextStyle(
              color: efficiencyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogisticsOverhead(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.truck, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              Text(
                'Logistics Overhead',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildOverheadItem(
            'Transport Fuel',
            '45% of total overhead',
            0.45,
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildOverheadItem(
            'Maintenance',
            '30% of total overhead',
            0.3,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildOverheadItem(
            'Expedited Shipping',
            '15% of total overhead',
            0.15,
            Colors.redAccent,
          ),
          const SizedBox(height: 16),
          _buildOverheadItem(
            'Storage Fees',
            '10% of total overhead',
            0.1,
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildOverheadItem(
    String title,
    String desc,
    double percentage,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(desc, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildBottlenecksCard(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.hourglass,
                color: Colors.redAccent,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Workflow Bottlenecks',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildBottleneckItem(
            'Intake Processing',
            '+15m delay avg',
            'Documentation backlog at reception.',
            Colors.redAccent,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildBottleneckItem(
            'Shift Handoff',
            '+8m delay avg',
            'Inefficient verbal handover process.',
            Colors.orange,
          ),
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
              child: const Text('View All Workflow Insights'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottleneckItem(
    String phase,
    String delay,
    String desc,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              phase,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                delay,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildResourceUtilization(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Capital Equipment Utilization',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(LucideIcons.moreHorizontal, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(
                child: _UtilizationBar(label: 'Mobile Clinics', value: 0.92),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _UtilizationBar(label: 'Remote Monitors', value: 0.85),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _UtilizationBar(label: 'Specialty Gear', value: 0.65),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _UtilizationBar(label: 'Fleet Vehicles', value: 0.88),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UtilizationBar extends StatelessWidget {
  final String label;
  final double value;

  const _UtilizationBar({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    Color barColor = value > 0.85
        ? PrimeCareTheme.emeraldTeal
        : (value > 0.7 ? Colors.orange : Colors.redAccent);
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
                heightFactor: value,
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
