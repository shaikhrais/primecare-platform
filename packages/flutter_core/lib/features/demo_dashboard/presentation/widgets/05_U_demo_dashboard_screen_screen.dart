// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Demo Dashboard
/// Showcases the full capabilities of the PrimeCare V4 platform for stakeholders.
class DemoDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const DemoDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = PrimeCareTheme.of(context);
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShowcaseHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildFeatureHighlights(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildPerformanceAnalytics(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildModularPreview(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowcaseHeader(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.sparkles, color: theme.colors.primary, size: 40),
          ),
          SizedBox(width: theme.spacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PrimeCare V4 Platform Showcase',
                  style: theme.typography.h1.copyWith(
                    letterSpacing: -1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Explore the future of clinical operations management and real-time health tech.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Start Guided Tour',
            icon: LucideIcons.playCircle,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildFeatureCard(theme, 'Real-time Sync', '0.5ms Latency', LucideIcons.zap, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildFeatureCard(theme, 'Clinical AI', 'Predictive Analysis', LucideIcons.brainCircuit, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildFeatureCard(theme, 'Security', 'AES-256 Hardened', LucideIcons.shieldCheck, theme.colors.slateGray),
        SizedBox(width: theme.spacing.lg),
        _buildFeatureCard(theme, 'Scalability', 'Unlimited Nodes', LucideIcons.layers, theme.colors.amberWarning),
      ],
    );
  }

  Widget _buildFeatureCard(PrimeCareThemeData theme, String title, String subtitle, IconData icon, Color color) {
    return Expanded(
      child: ClinicalGlassPanel(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: theme.spacing.md),
            Text(title, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            Text(subtitle, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceAnalytics(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Global Platform Performance',
      padding: EdgeInsets.all(theme.spacing.xl),
      child: AspectRatio(
        aspectRatio: 21 / 9,
        child: Center(
          child: Text(
            'Interactive Performance Graph Placeholder',
            style: theme.typography.label.copyWith(color: theme.colors.slateGray),
          ),
        ),
      ),
    );
  }

  Widget _buildModularPreview(BuildContext context, PrimeCareThemeData theme) {
    return Column(
      children: [
        ClinicalGlassPanel(
          title: 'System Health',
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            children: [
              _buildHealthItem(theme, 'API Gateway', 1.0),
              _buildHealthItem(theme, 'Core Registry', 0.98),
              _buildHealthItem(theme, 'Edge Workers', 1.0),
              _buildHealthItem(theme, 'Database Cluster', 0.95),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.lg),
        ClinicalGlassPanel(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            children: [
              Text('Available Modules', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: theme.spacing.md),
              Wrap(
                spacing: theme.spacing.sm,
                runSpacing: theme.spacing.sm,
                children: [
                  _buildTag(theme, 'Billing'),
                  _buildTag(theme, 'Clinical'),
                  _buildTag(theme, 'Logistics'),
                  _buildTag(theme, 'HR'),
                  _buildTag(theme, 'Analytics'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthItem(PrimeCareThemeData theme, String label, double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.typography.bodySmall)),
          SizedBox(
            width: 60,
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: theme.colors.surfaceContainerHighest,
              color: value > 0.99 ? theme.colors.emeraldTeal : theme.colors.amberWarning,
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: theme.spacing.sm),
          Text('${(value * 100).toInt()}%', style: theme.typography.labelSmall),
        ],
      ),
    );
  }

  Widget _buildTag(PrimeCareThemeData theme, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.xs),
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(theme.spacing.xxs),
      ),
      child: Text(label, style: theme.typography.labelSmall),
    );
  }
}
