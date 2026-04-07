import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

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
                            _buildRosterCalendar(context),
                            const SizedBox(height: 24),
                            _buildCoverageLevels(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildCapacityAlerts(context),
                            const SizedBox(height: 24),
                            _buildPendingRequests(context),
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
              'Master Schedule',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage franchise roster, shift coverage, and time-off requests',
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
              LucideIcons.calendarPlus,
              'Create Shift',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.settingsSliders,
              'Optimization Rules',
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
            'Total Shifts (Week)',
            '428',
            LucideIcons.briefcase,
            '+12 vs last week',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Open / Unfilled',
            '8',
            LucideIcons.userMinus,
            'Action required',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Overtime Risk',
            '3',
            LucideIcons.alertTriangle,
            'Staff >40h',
            Colors.redAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Coverage Score',
            '96%',
            LucideIcons.checkSquare,
            'Optimal',
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

  Widget _buildRosterCalendar(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Snapshot (Oct 16 - 22)',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'View: Role',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
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
                DataColumn(label: Text('Staff')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Mon')),
                DataColumn(label: Text('Tue')),
                DataColumn(label: Text('Wed')),
                DataColumn(label: Text('Thu')),
                DataColumn(label: Text('Fri')),
              ],
              rows: [
                _buildRosterRow(
                  'Sarah Jenkins',
                  'RN',
                  '07:00-15:00',
                  '07:00-15:00',
                  'OFF',
                  '07:00-15:00',
                  '07:00-15:00',
                ),
                _buildRosterRow(
                  'Mike Ross',
                  'PSW',
                  'OFF',
                  '15:00-23:00',
                  '15:00-23:00',
                  '15:00-23:00',
                  '15:00-23:00',
                ),
                _buildRosterRow(
                  'Lisa Wong',
                  'LPN',
                  '08:00-16:00',
                  '08:00-16:00',
                  '08:00-16:00',
                  '08:00-16:00',
                  'OFF',
                ),
                _buildRosterRow(
                  'John Smith',
                  'PSW',
                  '23:00-07:00',
                  '23:00-07:00',
                  '23:00-07:00',
                  'OFF',
                  'OFF',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRosterRow(
    String name,
    String role,
    String d1,
    String d2,
    String d3,
    String d4,
    String d5,
  ) {
    Widget formatCell(String text) {
      if (text == 'OFF') {
        return Text(
          text,
          style: const TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: PrimeCareTheme.emeraldTeal,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(role, style: const TextStyle(color: Colors.white70))),
        DataCell(formatCell(d1)),
        DataCell(formatCell(d2)),
        DataCell(formatCell(d3)),
        DataCell(formatCell(d4)),
        DataCell(formatCell(d5)),
      ],
    );
  }

  Widget _buildCoverageLevels(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.barChart,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Daily Coverage Levels vs Demand',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _buildCategoryBar('Mon', 85, PrimeCareTheme.emeraldTeal),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildCategoryBar('Tue', 92, PrimeCareTheme.emeraldTeal),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildCategoryBar(
                  'Wed',
                  100,
                  PrimeCareTheme.emeraldTeal,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: _buildCategoryBar('Thu', 75, Colors.orange)),
              const SizedBox(width: 8),
              Expanded(child: _buildCategoryBar('Fri', 60, Colors.redAccent)),
              const SizedBox(width: 8),
              Expanded(
                child: _buildCategoryBar('Sat', 88, PrimeCareTheme.emeraldTeal),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildCategoryBar('Sun', 95, PrimeCareTheme.emeraldTeal),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar(String label, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${height.toInt()}%',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildCapacityAlerts(BuildContext context) {
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
                  const Icon(LucideIcons.siren, color: Colors.orange, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Capacity Alerts',
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
          _buildAlertItem(
            'Thursday Evening (PSW)',
            'Projected 25% under-staffed. 4 open shifts.',
            Colors.orange,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildAlertItem(
            'Friday Night (RN)',
            'Critical Level. 0 RNs currently scheduled for Ward B.',
            Colors.redAccent,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimeCareTheme.emeraldTeal.withValues(
                  alpha: 0.1,
                ),
                foregroundColor: PrimeCareTheme.emeraldTeal,
                elevation: 0,
                side: BorderSide(
                  color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.3),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text('Auto-Fill via Network'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String desc, Color badgeColor) {
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

  Widget _buildPendingRequests(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.mailWarning, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Time-off Approvals',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildRequestItem('A. Kendrick (PSW)', 'Vacation', 'Oct 20 - Oct 25'),
          const SizedBox(height: 12),
          _buildRequestItem('T. Hanks (RN)', 'Sick Leave (Retro)', 'Oct 14'),
          const SizedBox(height: 12),
          _buildRequestItem('E. Stone (LPN)', 'Personal Day', 'Oct 18'),
        ],
      ),
    );
  }

  Widget _buildRequestItem(String user, String reason, String dates) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$reason • $dates',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
                icon: const Icon(
                  LucideIcons.xCircle,
                  color: Colors.redAccent,
                  size: 20,
                ),
                onPressed: () {},
              ),
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
                icon: const Icon(
                  LucideIcons.checkCircle2,
                  color: PrimeCareTheme.emeraldTeal,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
