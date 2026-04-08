import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StaffCoordinationScreen extends StatelessWidget {
  const StaffCoordinationScreen({super.key});

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
                            _buildStaffAvailabilityTable(context),
                            const SizedBox(height: 24),
                            _buildShiftMarketBoard(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildCommunicationChannels(context),
                            const SizedBox(height: 24),
                            _buildRecentAssignments(context),
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
              'Staff Coordination',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage staff availability, open market shifts, and team communications',
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
              LucideIcons.radio,
              'Broadcast Alert',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.users,
              'Roster Directory',
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
            'Available Now',
            '18',
            LucideIcons.userCheck,
            'On-call & idle',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Open Market Shifts',
            '12',
            LucideIcons.shoppingBag,
            'Needs pickup',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Pending Sick Leaves',
            '3',
            LucideIcons.thermometer,
            'Needs coverage',
            Colors.redAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Msg Read Rate',
            '95%',
            LucideIcons.messageCircle,
            'Last 24 hours',
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

  Widget _buildStaffAvailabilityTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live Staff Availability',
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
                      'Filter: On-Call',
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
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Current Zone')),
                DataColumn(label: Text('Max H/Wk')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Action')),
              ],
              rows: [
                _buildDataRow(
                  'Sarah Jenkins',
                  'RN',
                  'Downtown Core',
                  '36 hr / 40 hr',
                  PrimeCareTheme.emeraldTeal,
                  'Available Now',
                ),
                _buildDataRow(
                  'Mike Ross',
                  'PSW',
                  'North Suburbs',
                  '40 hr / 40 hr',
                  Colors.orange,
                  'At Capacity',
                ),
                _buildDataRow(
                  'Lisa Wong',
                  'LPN',
                  'East End',
                  '12 hr / 24 hr',
                  PrimeCareTheme.emeraldTeal,
                  'On Call',
                ),
                _buildDataRow(
                  'John Smith',
                  'PSW',
                  'Westside Ops',
                  '--',
                  Colors.redAccent,
                  'Do Not Disturb',
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
    String zone,
    String hours,
    Color statusColor,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(role)),
        DataCell(Text(zone, style: const TextStyle(color: Colors.white70))),
        DataCell(
          Text(
            hours,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
        DataCell(
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () {},
            child: const Text(
              'Assign',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShiftMarketBoard(BuildContext context) {
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
                    LucideIcons.shoppingBag,
                    color: Colors.blue,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Open Shift Market',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Text(
                'View All',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMarketItem(
            'Night Shift - Ward B (Urgent)',
            'RN Required • Oct 16, 23:00 - 07:00',
            '+ \$50 Bonus',
            Colors.orange,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildMarketItem(
            'Home Care Route 4',
            'PSW Required • Oct 17, 08:00 - 16:00',
            'Standard Rate',
            PrimeCareTheme.emeraldTeal,
          ),
          const Divider(color: Colors.white12, height: 32),
          _buildMarketItem(
            'Weekend Relief',
            'LPN Required • Oct 20, 07:00 - 19:00',
            '1.5x Overtime',
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildMarketItem(
    String title,
    String details,
    String incentive,
    Color badgeColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                details,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            incentive,
            style: TextStyle(
              color: badgeColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunicationChannels(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.messageSquare,
                color: PrimeCareTheme.emeraldTeal,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Recent Comms',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildCommItem(
            'All Staff (Downtown)',
            'Urgent: Weather Alert for Route B',
            '10m ago',
          ),
          const SizedBox(height: 16),
          _buildCommItem(
            'RN Group',
            'New protocols for Ward C uploaded.',
            '2h ago',
          ),
          const SizedBox(height: 16),
          _buildCommItem(
            'Sarah Jenkins (DM)',
            'I can pick up the night shift on Dec 12.',
            '3h ago',
          ),
        ],
      ),
    );
  }

  Widget _buildCommItem(String channel, String preview, String time) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                channel,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            preview,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAssignments(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.gitCommit, color: Colors.blue, size: 24),
              const SizedBox(width: 12),
              Text(
                'Recent Assignments',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAssignmentItem(
            'Shift Covered',
            'T. Hanks picked up Ward B Night.',
            'Just now',
          ),
          const SizedBox(height: 16),
          _buildAssignmentItem(
            'Reassignment',
            'E. Stone moved to Route 4.',
            '1h ago',
          ),
          const SizedBox(height: 16),
          _buildAssignmentItem(
            'Sick Leave Approved',
            'A. Kendrick for Oct 18.',
            '3h ago',
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentItem(String title, String details, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.checkCircle,
            size: 16,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                details,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
