import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

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
                            _buildActiveShiftsTable(context),
                            const SizedBox(height: 24),
                            _buildExceptionsList(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildPunctualityChart(context),
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
              'Attendance & Shifts',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Monitor branch staff attendance, clock-ins, and schedule adherence',
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
              'Select Date',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.download,
              'Export Timesheets',
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
            'Clocked In Now',
            '42',
            LucideIcons.userCheck,
            '88% of roster',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'No Shows / M.I.A',
            '1',
            LucideIcons.alertCircle,
            'Needs attention',
            Colors.redAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Late Arrivals',
            '3',
            LucideIcons.clock,
            'Avg 8m late',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Punctuality Score',
            '94%',
            LucideIcons.checkSquare,
            '+2% vs last week',
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

  Widget _buildActiveShiftsTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active & Upcoming Shifts (Today)',
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
                DataColumn(label: Text('Staff Member')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _buildDataRow(
                  'Sarah Jenkins',
                  'RN',
                  'General Ward A',
                  '07:00 - 15:00',
                  PrimeCareTheme.emeraldTeal,
                  'Clocked In',
                ),
                _buildDataRow(
                  'Mike Ross',
                  'PSW',
                  'Home Care Rt 2',
                  '08:00 - 16:00',
                  PrimeCareTheme.emeraldTeal,
                  'In Transit',
                ),
                _buildDataRow(
                  'Lisa Wong',
                  'LPN',
                  'Oncology Unit',
                  '08:30 - 16:30',
                  Colors.orange,
                  'Late (12m)',
                ),
                _buildDataRow(
                  'John Smith',
                  'PSW',
                  'General Ward B',
                  '15:00 - 23:00',
                  Colors.blue,
                  'Upcoming',
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
    String role,
    String location,
    String time,
    Color statusColor,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(role)),
        DataCell(Text(location, style: const TextStyle(color: Colors.white70))),
        DataCell(Text(time)),
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

  Widget _buildExceptionsList(BuildContext context) {
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
                    LucideIcons.alertOctagon,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Exceptions & Overrides',
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
            'Tom Hanks',
            'Missed Clock Out (yesterday)',
            'System auto-closed at 23:30. Manager review required.',
            Colors.orange,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildExceptionItem(
            'Emma Stone',
            'Sick Leave (Today)',
            'Called in sick. Shift reassigned to P. Parker.',
            PrimeCareTheme.emeraldTeal,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildExceptionItem(
            'Anna Kendrick',
            'GPS Mismatch',
            'Clocked in 2km away from client site. Awaiting explanation.',
            Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildExceptionItem(
    String name,
    String type,
    String desc,
    Color badgeColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            type,
            style: TextStyle(
              color: badgeColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
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

  Widget _buildPunctualityChart(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.pieChart,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Today\'s Arrival Distribution',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildOptiBar(
            'On Time (>5m early)',
            0.75,
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildOptiBar('Grace Period (<5m late)', 0.15, Colors.blue),
          const SizedBox(height: 16),
          _buildOptiBar('Late (>5m late)', 0.08, Colors.orange),
          const SizedBox(height: 16),
          _buildOptiBar('No Show', 0.02, Colors.redAccent),
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
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontSize: 12,
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
            minHeight: 8,
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
                'Quick Actions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActionBtn(
            'Review Timesheets (12 Pending)',
            LucideIcons.fileSignature,
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 12),
          _buildActionBtn(
            'Message Late Staff (3)',
            LucideIcons.messageSquare,
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildActionBtn(
            'Broadcast Empty Shift',
            LucideIcons.radio,
            Colors.blue,
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
