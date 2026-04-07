import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DailyOperationsScreen extends StatelessWidget {
  const DailyOperationsScreen({super.key});

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
                            _buildLiveServiceStatus(context),
                            const SizedBox(height: 24),
                            _buildActiveBranches(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildOpenIssues(context),
                            const SizedBox(height: 24),
                            _buildQuickActions(context),
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
              'Daily Operations',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Franchise daily overview, service health, and active branches',
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
              LucideIcons.refreshCcw,
              'Refresh Data',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.fileText,
              'End of Day Report',
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
            'Daily Dispatches',
            '1,420',
            LucideIcons.truck,
            '+45 vs yesterday',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Active Branches',
            '14/15',
            LucideIcons.building,
            '1 Under Maintenance',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Open Support Tickets',
            '12',
            LucideIcons.ticket,
            '3 High Priority',
            Colors.redAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'On-Time Service',
            '96.5%',
            LucideIcons.clock,
            '+1.2% this week',
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
    String subtitle,
    Color color,
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
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveServiceStatus(BuildContext context) {
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
                'Live Service Status Distribution',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildOptiBar(
            'In Progress (Active Care)',
            0.45,
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildOptiBar('In Transit (En Route)', 0.25, Colors.blue),
          const SizedBox(height: 16),
          _buildOptiBar('Completed', 0.20, Colors.grey),
          const SizedBox(height: 16),
          _buildOptiBar('Delayed / Pending', 0.10, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildOptiBar(String category, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveBranches(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Branch Operational Status',
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
                DataColumn(label: Text('Branch Name')),
                DataColumn(label: Text('Region')),
                DataColumn(label: Text('Daily Load')),
                DataColumn(label: Text('Staffing Health')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _buildDataRow(
                  'Downtown Core',
                  'Central',
                  '94%',
                  PrimeCareTheme.emeraldTeal,
                  'Stable',
                  PrimeCareTheme.emeraldTeal,
                ),
                _buildDataRow(
                  'North Suburbs',
                  'North',
                  '105%',
                  Colors.orange,
                  'At Capacity',
                  Colors.orange,
                ),
                _buildDataRow(
                  'East End Clinic',
                  'East',
                  '88%',
                  PrimeCareTheme.emeraldTeal,
                  'Stable',
                  PrimeCareTheme.emeraldTeal,
                ),
                _buildDataRow(
                  'Westside Ops',
                  'West',
                  '--',
                  Colors.redAccent,
                  'System Maint.',
                  Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String name,
    String region,
    String load,
    Color healthColor,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(region, style: const TextStyle(color: Colors.white70))),
        DataCell(
          Text(load, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: healthColor,
                ),
              ),
              const SizedBox(width: 8),
              Text('Monitoring', style: TextStyle(color: healthColor)),
            ],
          ),
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

  Widget _buildOpenIssues(BuildContext context) {
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
                    LucideIcons.alertTriangle,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Critical Operations Issues',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildExceptionItem(
            'Westside Outage',
            'Power failure reported. Re-routing dispatch to Central.',
            Colors.redAccent,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildExceptionItem(
            'Staff Shortage',
            '3 Call-outs in North Suburbs. Need immediate coverage.',
            Colors.orange,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildExceptionItem(
            'Equipment Delay',
            'O2 delivery late for Route B. Updating client ETAs.',
            Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _buildExceptionItem(String title, String desc, Color badgeColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(shape: BoxShape.circle, color: badgeColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.zap, color: Colors.amber, size: 24),
              const SizedBox(width: 12),
              Text(
                'Control Center',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActionBtn(
            'Issue Fleet Alert',
            LucideIcons.radio,
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildActionBtn(
            'Re-route Pending (North)',
            LucideIcons.gitMerge,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildActionBtn(
            'Manually Assign Shift',
            LucideIcons.userPlus,
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, IconData icon, Color highlightColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: highlightColor.withValues(alpha: 0.1),
          foregroundColor: highlightColor,
          elevation: 0,
          side: BorderSide(color: highlightColor.withValues(alpha: 0.3)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {},
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
