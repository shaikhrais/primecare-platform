// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened CTO Technology & Infrastructure Dashboard
/// Focuses on system uptime, security hygiene, and engineering velocity.
class CtoDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const CtoDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hardened Internal Header
            PrimeCareCard(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Technology Command Hub',
                        style: typography.h2.copyWith(color: colors.primary),
                      ),
                      Text(
                        'Global Infrastructure State • Live Telemetry',
                        style: typography.bodyMedium.copyWith(color: colors.slateGray),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PrimeCareButton(
                    label: 'System Logs',
                    icon: LucideIcons.terminal,
                    onPressed: () {},
                  ),
                  SizedBox(width: theme.spacing.md),
                  PrimeCareButton(
                    label: 'Infrastructure Deploy',
                    icon: LucideIcons.rocket,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: theme.spacing.xl),

            _buildInfrastructureOverview(context),
            SizedBox(height: theme.spacing.xl),
            _buildSecurityPosture(context),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildEngineeringVelocity(context)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildAIDeploymentStats(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfrastructureOverview(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    return Row(
      children: [
        _buildStatusCard(context, 'API Uptime', PrimeCareFormatters.formatPercentage(0.9999), 'Operational', LucideIcons.activity, colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildStatusCard(context, 'Avg Latency', '42ms', '-5ms Today', LucideIcons.zap, colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildStatusCard(context, 'Database Load', PrimeCareFormatters.formatPercentage(0.24), 'Stable', LucideIcons.database, colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildStatusCard(context, 'Cloud Spend', PrimeCareFormatters.formatCurrency(42100, isCompact: true), '+2% Budget', LucideIcons.cloud, colors.warning),
      ],
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    String label, 
    String value, 
    String health, 
    IconData icon, 
    Color color
  ) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Expanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(theme.radii.md),
                  ),
                  child: Text(
                    health,
                    style: typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.lg),
            Text(
              value,
              style: typography.h2.copyWith(fontWeight: FontWeight.w900, color: colors.primary),
            ),
            SizedBox(height: theme.spacing.xxs),
            Text(
              label,
              style: typography.labelSmall.copyWith(color: colors.slateGray),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityPosture(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cybersecurity Threat Level: LOW', style: theme.typography.labelLarge),
          SizedBox(height: theme.spacing.lg),
          Row(
            children: [
              _buildSecurityMetric(context, 'Active Threats', '0', colors.success),
              const Spacer(),
              _buildSecurityMetric(context, 'Firewall Blocks', PrimeCareFormatters.formatCompactValue(1200000), colors.primary),
              const Spacer(),
              _buildSecurityMetric(context, 'SSL Expiry', '182 Days', colors.success),
              const Spacer(),
              _buildSecurityMetric(context, 'Open CVEs', '2 (Patching)', colors.warning),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityMetric(BuildContext context, String label, String value, Color color) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Column(
      children: [
        Text(value, style: typography.h3.copyWith(color: color, fontWeight: FontWeight.bold)),
        SizedBox(height: theme.spacing.xxs),
        Text(label, style: typography.labelSmall.copyWith(color: colors.slateGray)),
      ],
    );
  }

  Widget _buildEngineeringVelocity(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('V4 Platform Engineering Velocity', style: theme.typography.labelLarge),
          SizedBox(height: theme.spacing.md),
          _buildVelocityRow(context, 'Current Sprint (PC-V4.2)', 0.75, colors.primary),
          _buildVelocityRow(context, 'Test Coverage', 0.88, colors.success),
          _buildVelocityRow(context, 'Hydration Batch 4', 0.92, colors.primary),
          _buildVelocityRow(context, 'Technical Debt', 0.12, colors.error),
        ],
      ),
    );
  }

  Widget _buildVelocityRow(BuildContext context, String label, double value, Color color) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(label, style: typography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('${(value * 100).toInt()}%', style: typography.labelSmall),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: value,
            backgroundColor: colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(theme.radii.sm),
          ),
        ],
      ),
    );
  }

  Widget _buildAIDeploymentStats(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Aura AI Engine Health', style: theme.typography.labelLarge),
          SizedBox(height: theme.spacing.md),
          _buildAIMetric(context, 'Model Accuracy', PrimeCareFormatters.formatPercentage(0.982), LucideIcons.brainCircuit, colors.success),
          const Divider(),
          _buildAIMetric(context, 'Daily Inferences', PrimeCareFormatters.formatCompactValue(142000), LucideIcons.cpu, colors.primary),
          const Divider(),
          _buildAIMetric(context, 'Training Status', 'Optimized', LucideIcons.refreshCw, colors.success),
        ],
      ),
    );
  }

  Widget _buildAIMetric(BuildContext context, String label, String value, IconData icon, Color color) {
    final theme = context.theme;
    final colors = theme.colors;
    final typography = theme.typography;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: theme.spacing.md),
          Text(label, style: typography.bodyMedium.copyWith(color: colors.slateGray)),
          const Spacer(),
          Text(value, style: typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

