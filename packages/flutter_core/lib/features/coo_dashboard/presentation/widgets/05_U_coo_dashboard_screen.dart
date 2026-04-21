// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened COO Operational Excellence Dashboard
/// Focuses on daily operations, labor efficiency, supply chain, and incident response.
class CooDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const CooDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hardened Internal Header
            PrimeCareCard(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Operations Command Center',
                        style: typography.h2.copyWith(color: colors.primary),
                      ),
                      Text(
                        'Real-time Institutional Flow • May 2026',
                        style: typography.body.copyWith(color: colors.slateGray),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PrimeCareButton(
                    label: 'Supply Reorder',
                    icon: LucideIcons.package,
                    onPressed: () {},
                    type: PrimeCareButtonType.secondary,
                  ),
                  SizedBox(width: theme.spacing.md),
                  PrimeCareButton(
                    label: 'Dispatch Audit',
                    icon: LucideIcons.truck,
                    onPressed: () {},
                    type: PrimeCareButtonType.primary,
                  ),
                ],
              ),
            ),
            SizedBox(height: theme.spacing.xl),
            
            _buildOperationalPulse(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildEfficiencyMatrix(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildLogisticsHeatmap(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildOperationalIncidents(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationalPulse(BuildContext context, PrimeCareThemeData theme) {
    final colors = theme.colors;
    return Row(
      children: [
        _buildPulseCard(theme, 'Labor Utilization', '92%', 'Optimal', LucideIcons.users, colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildPulseCard(theme, 'Supply Availability', '88%', 'Monitoring', LucideIcons.packageCheck, colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildPulseCard(theme, 'Avg Dispatch Time', '14m', '-2m Today', LucideIcons.clock, colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildPulseCard(theme, 'Incident Resolve Rate', '99.2%', 'Exceeding', LucideIcons.checkCircle2, colors.success),
      ],
    );
  }

  Widget _buildPulseCard(
    PrimeCareThemeData theme,
    String label, 
    String value, 
    String status, 
    IconData icon, 
    Color color
  ) {
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Expanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: theme.spacing.md),
            Text(
              value,
              style: typography.h2.copyWith(fontWeight: FontWeight.w900, color: color),
            ),
            SizedBox(height: theme.spacing.xs),
            Text(
              label,
              style: typography.body.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              status,
              style: typography.labelSmall.copyWith(color: colors.slateGray),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEfficiencyMatrix(BuildContext context, PrimeCareThemeData theme) {
    final colors = theme.colors;
    
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Departmental Efficiency Matrix', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEfficiencyGauge(theme, 'Clinical Flow', 0.94, colors.success),
              _buildEfficiencyGauge(theme, 'Logistics', 0.82, colors.primary),
              _buildEfficiencyGauge(theme, 'Admin Throughput', 0.76, colors.warning),
              _buildEfficiencyGauge(theme, 'Procurement', 0.88, colors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyGauge(PrimeCareThemeData theme, String label, double value, Color color) {
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 8,
            backgroundColor: colors.surfaceContainerHighest,
            color: color,
          ),
        ),
        SizedBox(height: theme.spacing.md),
        Text(label, style: typography.body.copyWith(fontWeight: FontWeight.bold)),
        Text('${(value * 100).toInt()}%', style: typography.h3.copyWith(color: color)),
      ],
    );
  }

  Widget _buildLogisticsHeatmap(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Supply Chain Health', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildSupplyRow(theme, 'PPE Inventory (Global)', 0.95, 'Healthy'),
          _buildSupplyRow(theme, 'Medication Stock (Ontario)', 0.42, 'Critical Redirection'),
          _buildSupplyRow(theme, 'Medical Devices (Western)', 0.78, 'Replenishing'),
          _buildSupplyRow(theme, 'Consumables (Quebec)', 0.85, 'Stable'),
        ],
      ),
    );
  }

  Widget _buildSupplyRow(PrimeCareThemeData theme, String label, double level, String status) {
    final colors = theme.colors;
    final typography = theme.typography;
    
    final color = level < 0.5 ? colors.error : (level < 0.8 ? colors.warning : colors.success);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: typography.body.copyWith(fontWeight: FontWeight.w600)),
                Text(status, style: typography.labelSmall.copyWith(color: color)),
              ],
            ),
          ),
          SizedBox(width: theme.spacing.lg),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: colors.surfaceContainerHighest,
              color: color,
              minHeight: 12,
              borderRadius: BorderRadius.circular(theme.radii.md),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Text('${(level * 100).toInt()}%', style: typography.body.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOperationalIncidents(BuildContext context, PrimeCareThemeData theme) {
    final colors = theme.colors;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Blockers', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildIncidentCard(theme, 'Vehicle Breakdown', 'H-102 (Toronto)', '2h ago', colors.error),
          SizedBox(height: theme.spacing.md),
          _buildIncidentCard(theme, 'Shift Gap', 'RN Night Shift (London)', '30m ago', colors.warning),
          SizedBox(height: theme.spacing.md),
          _buildIncidentCard(theme, 'IT Outage', 'Regional API Node (NW)', '5m ago', colors.error),
        ],
      ),
    );
  }

  Widget _buildIncidentCard(PrimeCareThemeData theme, String title, String location, String time, Color color) {
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Container(
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(theme.radii.lg),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.xs),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: const Icon(LucideIcons.alertCircle, color: Colors.white, size: 16),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: typography.body.copyWith(fontWeight: FontWeight.bold)),
                Text('$location • $time', style: typography.labelSmall.copyWith(color: colors.slateGray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
