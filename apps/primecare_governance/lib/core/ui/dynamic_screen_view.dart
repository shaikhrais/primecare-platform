import 'package:primecare_ui/primecare_ui.dart';
import '../governance/screen_registry.dart';

class DynamicScreenView extends GovernedStatelessWidget {
  final ScreenMetadata metadata;

  const DynamicScreenView({required this.metadata, super.key});

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;

    // Determine status and aesthetics based on lifecycle
    final String statusText;
    final Color statusColor;
    final IconData statusIcon;

    switch (metadata.lifecycleStatus) {
      case LifecycleStatus.completed:
        statusText = 'IMPLEMENTED';
        statusColor = Colors.green;
        statusIcon = LucideIcons.checkCircle;
        break;
      case LifecycleStatus.generation:
      case LifecycleStatus.testing:
        statusText = 'STUBBED';
        statusColor = Colors.orange;
        statusIcon = LucideIcons.hammer;
        break;
      case LifecycleStatus.backlog:
      default:
        statusText = 'DECLARED';
        statusColor = theme.colors.warning;
        statusIcon = LucideIcons.fileSearch;
    }

    return Container(
      color: theme.colors.surfaceContainerLowest,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: context.s(1200)),
            padding: EdgeInsets.symmetric(
              horizontal: context.s(48),
              vertical: context.s(64),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Status Header
                Container(
                  padding: EdgeInsets.all(context.s(32)),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: context.s(80)),
                ),
                SizedBox(height: context.s(24)),
                Text(
                  metadata.title,
                  style: theme.typography.h1.copyWith(fontSize: context.s(40)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.s(12)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.s(24),
                    vertical: context.s(12),
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(context.s(100)),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: context.s(8),
                        height: context.s(8),
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: context.s(12)),
                      Text(
                        'governance.dynamic_screen.governance_status'.tr(
                          args: [
                            ('governance.sidebar_mapping.status.${statusText.toLowerCase()}')
                                .tr(),
                          ],
                        ),
                        style: theme.typography.bodyLarge.copyWith(
                          color: statusColor,
                          fontSize: context.s(16),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),

                if (metadata.lifecycleStatus == LifecycleStatus.design)
                  Padding(
                    padding: EdgeInsets.only(top: context.s(24.0)),
                    child: Container(
                      padding: EdgeInsets.all(context.s(16)),
                      decoration: BoxDecoration(
                        color: theme.colors.errorContainer.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(context.s(12)),
                        border: Border.all(
                          color: theme.colors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.alertTriangle,
                              color: theme.colors.error, size: context.s(20)),
                          SizedBox(width: context.s(12)),
                          Text(
                            'REGISTERED: Implementation of high-fidelity code is pending.',
                            style: theme.typography.bodyMedium.copyWith(
                              color: theme.colors.error,
                              fontSize: context.s(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: context.s(64)),

                // Content Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Details
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            theme,
                            'governance.dynamic_screen.development_lifecycle'
                                .tr(),
                          ),
                          const SizedBox(height: 16),
                          _buildLifecycleStepper(
                            theme,
                            metadata.lifecycleStatus,
                          ),
                          const SizedBox(height: 48),
                          _buildSectionHeader(
                            theme,
                            'governance.dynamic_screen.screen_specifications'
                                .tr(),
                          ),
                          const SizedBox(height: 16),
                          _buildSpecsTable(theme, metadata),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    // Right Column: Platform Components
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            theme,
                            'governance.dynamic_screen.platform_architecture_status'
                                .tr(),
                          ),
                          const SizedBox(height: 16),
                          _buildArchitectureStatus(theme, statusText),
                          const SizedBox(height: 48),
                          _buildAuditActions(theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(PrimeThemeData theme, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.typography.labelMedium.copyWith(
            color: theme.colors.onSurfaceVariant,
            fontSize: context.s(12),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: context.s(8)),
        Container(width: context.s(40), height: context.s(3), color: theme.colors.primary),
      ],
    );
  }

  Widget _buildLifecycleStepper(PrimeThemeData theme, LifecycleStatus current) {
    final steps = LifecycleStatus.values;
    return Container(
      padding: EdgeInsets.all(context.s(24)),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(context.s(theme.radiusLg)),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        children: steps.map((s) {
          final isPast = s.index < current.index;
          final isCurrent = s == current;
          final color = isPast
              ? Colors.green
              : (isCurrent
                    ? theme.colors.primary
                    : theme.colors.onSurfaceVariant.withValues(alpha: 0.3));

          return Padding(
            padding: EdgeInsets.symmetric(vertical: context.s(8.0)),
            child: Row(
              children: [
                Icon(
                  isPast
                      ? LucideIcons.checkCircle2
                      : (isCurrent
                            ? LucideIcons.circleDot
                            : LucideIcons.circle),
                  size: context.s(20),
                  color: color,
                ),
                SizedBox(width: context.s(16)),
                Text(
                  s.name.toUpperCase(),
                  style: theme.typography.bodyMedium.copyWith(
                    color: isCurrent
                        ? theme.colors.onSurface
                        : theme.colors.onSurfaceVariant,
                    fontSize: context.s(14),
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isCurrent)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.s(8),
                      vertical: context.s(2),
                    ),
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(context.s(4)),
                    ),
                    child: Text(
                      'governance.dynamic_screen.current'.tr(),
                      style: theme.typography.labelSmall.copyWith(
                        color: theme.colors.primary,
                        fontSize: context.s(8),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpecsTable(PrimeThemeData theme, ScreenMetadata metadata) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(context.s(theme.radiusLg)),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        children: [
          _buildSpecRow(
            theme,
            'governance.dynamic_screen.identifier'.tr(),
            metadata.id,
          ),
          _buildSpecRow(
            theme,
            'governance.dynamic_screen.feature'.tr(),
            metadata.featureName,
          ),
          _buildSpecRow(
            theme,
            'governance.dynamic_screen.route_path'.tr(),
            metadata.routePath,
          ),
          _buildSpecRow(
            theme,
            'governance.dynamic_screen.office'.tr(),
            metadata.office,
          ),
          _buildSpecRow(
            theme,
            'governance.dynamic_screen.security'.tr(),
            metadata.securityLevel.name.toUpperCase(),
          ),
          _buildSpecRow(
            theme,
            'governance.dynamic_screen.story_points'.tr(),
            metadata.storyPoints.toString(),
          ),
          if (metadata.designSize != null)
            _buildSpecRow(
              theme,
              'DESIGN TARGET',
              '${metadata.designSize!.width.toInt()} x ${metadata.designSize!.height.toInt()} (4K Ultra HD)',
              isLast: true,
            )
          else
            _buildSpecRow(
              theme,
              'DESIGN TARGET',
              'Responsive (Mobile/Tab/Desktop)',
              isLast: true,
            ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(
    PrimeThemeData theme,
    String label,
    String value, {
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s(24),
        vertical: context.s(16),
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: theme.colors.outlineVariant),
              ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
              fontSize: context.s(14),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: context.s(14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureStatus(PrimeThemeData theme, String screenStatus) {
    final bool isImplemented = screenStatus == 'IMPLEMENTED';

    return Column(
      children: [
        _buildArchCard(
          theme,
          'governance.dynamic_screen.sidebar_navigation'.tr(),
          isImplemented ? 'IMPLEMENTED' : 'DECLARED',
          LucideIcons.layoutPanelLeft,
        ),
        SizedBox(height: context.s(12)),
        _buildArchCard(
          theme,
          'governance.dynamic_screen.platform_top_bar'.tr(),
          isImplemented ? 'IMPLEMENTED' : 'DECLARED',
          LucideIcons.layoutPanelTop,
        ),
        SizedBox(height: context.s(12)),
        _buildArchCard(
          theme,
          'governance.dynamic_screen.main_content_area'.tr(),
          screenStatus,
          LucideIcons.layout,
        ),
      ],
    );
  }

  Widget _buildArchCard(
    PrimeThemeData theme,
    String label,
    String status,
    IconData icon,
  ) {
    Color statusColor;
    switch (status.toUpperCase()) {
      case 'IMPLEMENTED':
        statusColor = Colors.green;
        break;
      case 'DECLARED':
        statusColor = theme.colors.primary;
        break;
      case 'STUBBED':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = theme.colors.onSurfaceVariant;
    }

    return Container(
      padding: EdgeInsets.all(context.s(20)),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(context.s(theme.radiusLg)),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colors.primary, size: context.s(24)),
          SizedBox(width: context.s(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.typography.labelSmall.copyWith(
                    fontSize: context.s(11),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.s(4)),
                Text(
                  ('governance.sidebar_mapping.status.${status.toLowerCase()}')
                      .tr(),
                  style: theme.typography.bodySmall.copyWith(
                    color: statusColor,
                    fontSize: context.s(12),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.checkCircle2,
            color: statusColor.withValues(alpha: 0.3),
            size: context.s(20),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditActions(PrimeThemeData theme) {
    return Container(
      padding: EdgeInsets.all(context.s(24)),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(context.s(theme.radiusLg)),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'governance.dynamic_screen.governance_actions'.tr(),
            style: theme.typography.labelSmall.copyWith(
              fontSize: context.s(11),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.s(16)),
          SizedBox(
            width: double.infinity,
            child: PrimeButton.primary(
              label: 'governance.dynamic_screen.initiate_development'.tr(),
              icon: LucideIcons.code,
              onPressed: () {},
            ),
          ),
          SizedBox(height: context.s(12)),
          SizedBox(
            width: double.infinity,
            child: PrimeButton.secondary(
              label: 'governance.dynamic_screen.file_correction_ticket'.tr(),
              icon: LucideIcons.ticket,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
