// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Table displaying the current patient waitlist with priority status.
class PatientWaitlistTable extends StatelessWidget {
  const PatientWaitlistTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Intake Waitlist', style: theme.typography.h3),
          Text(
            'Prioritized list of pending referrals and admissions',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Patient', 'Priority', 'Assigned To', 'Status'],
            rows: [
              _buildRow('Alice Johnson', 'URGENT', 'Nurse Sarah', 'PENDING'),
              _buildRow('Bob Wilson', 'ROUTINE', 'Nurse Mike', 'REVIEWING'),
              _buildRow('Charlie Davis', 'HIGH', 'Unassigned', 'NEW'),
              _buildRow('Diana Prince', 'ROUTINE', 'Nurse Sarah', 'WAITING'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String patient,
    String priority,
    String assigned,
    String status,
  ) {
    BadgeType priorityType;
    switch (priority) {
      case 'URGENT':
        priorityType = BadgeType.danger;
        break;
      case 'HIGH':
        priorityType = BadgeType.warning;
        break;
      default:
        priorityType = BadgeType.info;
    }

    return DataRow(
      cells: [
        DataCell(
          Text(patient, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(PrimeCareStatusBadge(text: priority, type: priorityType)),
        DataCell(Text(assigned)),
        DataCell(
          PrimeCareStatusBadge(
            text: status,
            type: status == 'NEW' ? BadgeType.info : BadgeType.neutral,
          ),
        ),
      ],
    );
  }
}

/// Chart showing intake volume and processing trends.
class IntakeVolumeChart extends StatelessWidget {
  final AnalyticsChart chart;

  const IntakeVolumeChart({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Referral Volume Trends', style: theme.typography.h3),
          Text(
            'Intake processing velocity over the last 7 days',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// Action hub for Intake Coordinator oversight.
class IntakeActionHub extends StatelessWidget {
  const IntakeActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Add Referral',
          icon: LucideIcons.userPlus,
          route: '/intake/referral/new',
        ),
        PrimeCareActionItem(
          title: 'Waitlist Mgmt',
          icon: LucideIcons.list,
          route: '/intake/waitlist',
        ),
        PrimeCareActionItem(
          title: 'Assign Staff',
          icon: LucideIcons.users,
          route: '/intake/staffing',
        ),
        PrimeCareActionItem(
          title: 'Intake Reports',
          icon: LucideIcons.barChart,
          route: '/intake/reports',
        ),
      ],
    );
  }
}
