// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class InfectionTelemetryHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const InfectionTelemetryHeatmap({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Infection Telemetry', style: theme.typography.h3),
              const PrimeCareStatusBadge(text: 'LIVE', type: BadgeType.info),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          AspectRatio(
            aspectRatio: 1.7,
            child: PrimeCareLineChart(chart: chart),
          ),
        ],
      ),
    );
  }
}

class OutbreakStatusGrid extends StatelessWidget {
  const OutbreakStatusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Outbreak Monitoring', style: theme.typography.h3),
        SizedBox(height: theme.spacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 768 ? 2 : 1;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: theme.spacing.md,
              crossAxisSpacing: theme.spacing.md,
              childAspectRatio: 3,
              children: [
                _buildOutbreakCard(
                  context,
                  'Unit 4B - Influenza',
                  'Confirmed: 3 | Suspected: 5',
                  'QUARANTINE',
                  theme.colors.error,
                ),
                _buildOutbreakCard(
                  context,
                  'Sector 7 - MRSA',
                  'Confirmed: 1 | Suspected: 2',
                  'MONITORED',
                  theme.colors.warning,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildOutbreakCard(
    BuildContext context,
    String title,
    String subtitle,
    String tag,
    Color color,
  ) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Row(
        children: [
          Container(
            width: 4,
            height: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.typography.labelLarge),
                Text(subtitle, style: theme.typography.labelSmall),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              tag,
              style: theme.typography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfectionActionHub extends StatelessWidget {
  const InfectionActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Expanded(
          child: PrimeCareButton(
            label: 'Report Outbreak',
            onPressed: () {},
            type: PrimeCareButtonType.primary,
            icon: LucideIcons.alertTriangle,
          ),
        ),
        SizedBox(width: theme.spacing.md),
        Expanded(
          child: PrimeCareButton(
            label: 'Audit PPE',
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
            icon: LucideIcons.shieldCheck,
          ),
        ),
      ],
    );
  }
}
