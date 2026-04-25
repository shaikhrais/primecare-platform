// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing health summary and vital trends for the patient.
class HealthSummaryHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const HealthSummaryHeatmap({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personal Wellness Index', style: theme.typography.h3),
                  Text(
                    'Consolidated health summary and vital signs trajectory',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(label: 'STABLE', type: BadgeType.success),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A grid tracking care plan progress and upcoming health events.
class CarePlanProgressGrid extends StatelessWidget {
  const CarePlanProgressGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Care Plan Progress', style: theme.typography.h3),
          Text(
            'Real-time tracking of wellness goals and clinical milestones',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Goal', 'Milestone', 'Progress', 'Status'],
            rows: [
              _buildRow('Mobility', 'Daily Walk', '80%', 'SUCCESS'),
              _buildRow('Nutrition', 'Diet Compliance', '100%', 'SUCCESS'),
              _buildRow('Hydration', 'Fluids Target', '65%', 'INFO'),
              _buildRow('Medication', 'Daily Regimen', '100%', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String goal,
    String milestone,
    String progress,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(goal)),
        DataCell(Text(milestone)),
        DataCell(
          Text(progress, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

/// Patient action hub for the Patient.
class PatientActionHub extends StatelessWidget {
  const PatientActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Request Meds',
          icon: LucideIcons.pill,
          route: '/patient/meds/request',
        ),
        PrimeCareActionItem(
          title: 'Message Nurse',
          icon: LucideIcons.messageSquare,
          route: '/patient/messages',
        ),
        PrimeCareActionItem(
          title: 'Care Plan',
          icon: LucideIcons.fileText,
          route: '/patient/care-plan',
        ),
        PrimeCareActionItem(
          title: 'Vitals Log',
          icon: LucideIcons.activity,
          route: '/patient/vitals',
        ),
      ],
    );
  }
}
