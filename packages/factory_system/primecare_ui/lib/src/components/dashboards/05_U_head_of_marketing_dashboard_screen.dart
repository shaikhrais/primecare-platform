// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// High-Fidelity Head of Marketing Dashboard
/// Focuses on brand growth, lead acquisition, and marketing ROI.
class HeadOfMarketingDashboardScreen extends ConsumerWidget {
  final HeadOfMarketingDashboardViewModel? data;

  const HeadOfMarketingDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // Fallback to empty if no data provided
    final viewModel = data ?? HeadOfMarketingDashboardViewModel.empty();
    final metrics = viewModel.metrics;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildGrowthSummary(context, theme),
            SizedBox(height: theme.spacing.xl),

            // Standardized KPI Grid (ROI, Leads, Conversion, CAC)
            PrimeCareResponsiveKpiGrid(metrics: metrics),

            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildCampaignROIChart(context, theme),
                ),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildLeadFunnel(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.lg,
        vertical: theme.spacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marketing Leadership Dashboard',
                  style: theme.typography.h2,
                ),
                Text(
                  'Brand Strategy • Q2 2026 • Marketing Office',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Campaign Report',
            icon: LucideIcons.barChart,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.sm),
          PrimeCareButton(
            label: 'New Campaign',
            icon: LucideIcons.plus,
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthSummary(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MARKET PENETRATION INDEX',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Growth Status: Rapid', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Organic leads increased by 24% this month. Brand awareness is at an all-time high.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildGauge(theme, 0.82, 'ROI Health'),
        ],
      ),
    );
  }

  Widget _buildGauge(PrimeCareThemeData theme, double value, String label) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: theme.colors.primary,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: theme.typography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignROIChart(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Campaign ROI', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildCampaignRow(
            theme,
            'Google Search Ads',
            0.92,
            theme.colors.success,
          ),
          _buildCampaignRow(
            theme,
            'Meta Retention',
            0.76,
            theme.colors.primary,
          ),
          _buildCampaignRow(
            theme,
            'Community Referral',
            0.88,
            theme.colors.success,
          ),
          _buildCampaignRow(theme, 'Direct Mail Q2', 0.42, theme.colors.error),
          _buildCampaignRow(
            theme,
            'Partner Webinars',
            0.65,
            theme.colors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignRow(
    PrimeCareThemeData theme,
    String name,
    double value,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(value)} ROI',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: value,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadFunnel(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lead Funnel (Last 30d)', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildFunnelItem(
            theme,
            'Inquiries',
            '1,240',
            LucideIcons.user,
            theme.colors.slateGray,
          ),
          const Divider(),
          _buildFunnelItem(
            theme,
            'Qualified Leads',
            '840',
            LucideIcons.checkCircle,
            theme.colors.primary,
          ),
          const Divider(),
          _buildFunnelItem(
            theme,
            'Consultations',
            '320',
            LucideIcons.messageSquare,
            theme.colors.warning,
          ),
          const Divider(),
          _buildFunnelItem(
            theme,
            'Conversions',
            '156',
            LucideIcons.award,
            theme.colors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelItem(
    PrimeCareThemeData theme,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.labelSmall),
              Text(value, style: theme.typography.h3),
            ],
          ),
        ],
      ),
    );
  }
}
