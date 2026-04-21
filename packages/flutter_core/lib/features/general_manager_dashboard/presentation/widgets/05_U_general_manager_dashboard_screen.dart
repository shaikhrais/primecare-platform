// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity General Manager Dashboard
/// Focuses on site-wide efficiency, staff morale, resident satisfaction, and facility operations.
class GeneralManagerDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const GeneralManagerDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = PrimeCareTheme.of(context);
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildSitePulse(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildOccupancyTrends(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildServiceEfficiency(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildCommunitySentiment(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
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
                  'Facility Command Center',
                  style: theme.typography.h2,
                ),
                Text(
                  'Operational Excellence • Community Well-being',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Service Request',
            icon: LucideIcons.wrench,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'Shift Briefing',
            icon: LucideIcons.messageSquare,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSitePulse(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildSiteCard(theme, 'Current Occupancy', '96%', '2 Rooms Available', LucideIcons.home, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildSiteCard(theme, 'Staffing Level', '98%', 'Optimal', LucideIcons.users, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildSiteCard(theme, 'Pending Maintenance', '8', '3 Urgent', LucideIcons.wrench, theme.colors.amberWarning),
        SizedBox(width: theme.spacing.lg),
        _buildSiteCard(theme, 'Guest Satisfaction', '4.9', 'Top Rated', LucideIcons.star, theme.colors.emeraldTeal),
      ],
    );
  }

  Widget _buildSiteCard(PrimeCareThemeData theme, String label, String value, String status, IconData icon, Color color) {
    return Expanded(
      child: ClinicalGlassPanel(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(theme.spacing.sm),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(theme.spacing.sm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: theme.spacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.typography.h3.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                Text(status, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOccupancyTrends(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Site Occupancy Trends (6 Months)',
      padding: EdgeInsets.all(theme.spacing.xl),
      child: SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBar(theme, 'Jan', 0.85),
            _buildBar(theme, 'Feb', 0.88),
            _buildBar(theme, 'Mar', 0.92),
            _buildBar(theme, 'Apr', 0.94),
            _buildBar(theme, 'May', 0.95),
            _buildBar(theme, 'Jun', 0.96),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(PrimeCareThemeData theme, String label, double value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 150 * value,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [theme.colors.primary, theme.colors.primary.withValues(alpha: 0.6)],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(theme.spacing.xs)),
          ),
        ),
        SizedBox(height: theme.spacing.sm),
        Text(label, style: theme.typography.labelSmall),
      ],
    );
  }

  Widget _buildServiceEfficiency(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Departmental Service Efficiency',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildEfficiencyRow(theme, 'Meal Service', 0.98, '32m avg delivery'),
          _buildEfficiencyRow(theme, 'Housekeeping', 0.92, '24 rooms/day'),
          _buildEfficiencyRow(theme, 'Maintenance Response', 0.85, '1.4h avg turnaround'),
          _buildEfficiencyRow(theme, 'Event Participation', 0.78, '42 residents/avg'),
        ],
      ),
    );
  }

  Widget _buildEfficiencyRow(PrimeCareThemeData theme, String label, double score, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Text(label, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(detail, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: score,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: score > 0.9 ? theme.colors.emeraldTeal : theme.colors.primary,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunitySentiment(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Community Sentiment',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildSentimentItem(theme, 'Staff Morale', LucideIcons.smile, theme.colors.emeraldTeal, 'High'),
          Divider(height: theme.spacing.xl),
          _buildSentimentItem(theme, 'Resident Joy', LucideIcons.heart, theme.colors.emeraldTeal, 'Elite'),
          Divider(height: theme.spacing.xl),
          _buildSentimentItem(theme, 'Family Feedback', LucideIcons.thumbsUp, theme.colors.primary, 'Positive'),
          Divider(height: theme.spacing.xl),
          _buildSentimentItem(theme, 'Noise Levels', LucideIcons.volume2, theme.colors.amberWarning, 'Moderate'),
        ],
      ),
    );
  }

  Widget _buildSentimentItem(PrimeCareThemeData theme, String label, IconData icon, Color color, String status) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: theme.spacing.md),
        Text(label, style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray)),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xxs),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(theme.spacing.xxs),
          ),
          child: Text(
            status,
            style: theme.typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
