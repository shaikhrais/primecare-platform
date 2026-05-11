import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';


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
        statusColor = const Color(0xFF10B981); // Emerald 500
        statusIcon = LucideIcons.checkCircle2;
        break;
      case LifecycleStatus.generation:
      case LifecycleStatus.testing:
        statusText = 'STUBBED';
        statusColor = const Color(0xFFF59E0B); // Amber 500
        statusIcon = LucideIcons.hammer;
        break;
      case LifecycleStatus.backlog:
      default:
        statusText = 'DECLARED';
        statusColor = theme.colors.warning;
        statusIcon = LucideIcons.fileSearch;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. Premium Mesh Gradient Background
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colors.surface,
                    statusColor.withValues(alpha: 0.05),
                    theme.colors.surface,
                  ],
                ),
              ),
            ),
          ),

          // 2. Main Content
          SingleChildScrollView(
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
                    // Status Badge (Floating Glass)
                    Hero(
                      tag: 'status_${metadata.id}',
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.s(20),
                          vertical: context.s(10),
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
                            Icon(statusIcon, color: statusColor, size: context.s(16)),
                            SizedBox(width: context.s(12)),
                            Text(
                              statusText,
                              style: theme.typography.labelBold.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

                    SizedBox(height: context.s(40)),

                    // Title Section
                    Text(
                      metadata.title,
                      style: theme.typography.h1.copyWith(
                        fontSize: context.s(56),
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95)),

                    SizedBox(height: context.s(16)),

                    Text(
                      'Feature Architecture: ${metadata.featureName}',
                      style: theme.typography.bodyLarge.copyWith(
                        color: theme.colors.onSurfaceVariant,
                        fontSize: context.s(20),
                      ),
                    ).animate().fadeIn(delay: 400.ms),

                    SizedBox(height: context.s(64)),

                    // Completion HUD (The Big Progress Meter)
                    _buildCompletionHUD(context, theme, metadata.completionPercent)
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideY(begin: 0.1),

                    SizedBox(height: context.s(80)),

                    // Technical Specifications Grid
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Technical Specs
                        Expanded(
                          flex: 4,
                          child: _buildTechnicalManifest(context, theme, metadata)
                              .animate()
                              .fadeIn(delay: 800.ms)
                              .slideX(begin: -0.05),
                        ),
                        SizedBox(width: context.s(48)),
                        // Right: Governance Stack
                        Expanded(
                          flex: 3,
                          child: _buildGovernanceStack(context, theme, metadata)
                              .animate()
                              .fadeIn(delay: 1000.ms)
                              .slideX(begin: 0.05),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalManifest(BuildContext context, PrimeThemeData theme, ScreenMetadata metadata) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, theme, 'Technical Manifest'),
        SizedBox(height: context.s(32)),
        _buildSpecsTable(context, theme, metadata),
        SizedBox(height: context.s(48)),
        _buildSectionHeader(context, theme, 'Development Pipeline'),
        SizedBox(height: context.s(32)),
        _buildLifecycleStepper(context, theme, metadata.lifecycleStatus),
      ],
    );
  }

  Widget _buildGovernanceStack(BuildContext context, PrimeThemeData theme, ScreenMetadata metadata) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, theme, 'Platform Integrity'),
        SizedBox(height: context.s(32)),
        _buildArchitectureStatus(context, theme, metadata.lifecycleStatus.name.toUpperCase()),
        SizedBox(height: context.s(48)),
        _buildAuditActions(context, theme),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, PrimeThemeData theme, String title) {
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

  Widget _buildLifecycleStepper(BuildContext context, PrimeThemeData theme, LifecycleStatus current) {
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

  Widget _buildSpecsTable(BuildContext context, PrimeThemeData theme, ScreenMetadata metadata) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(context.s(theme.radiusLg)),
        border: Border.all(color: theme.colors.outlineVariant),
      ),
      child: Column(
        children: [
          _buildSpecRow(
            context,
            theme,
            'governance.dynamic_screen.identifier'.tr(),
            metadata.id,
          ),
          _buildSpecRow(
            context,
            theme,
            'governance.dynamic_screen.feature'.tr(),
            metadata.featureName,
          ),
          _buildSpecRow(
            context,
            theme,
            'governance.dynamic_screen.route_path'.tr(),
            metadata.routePath,
          ),
          _buildSpecRow(
            context,
            theme,
            'governance.dynamic_screen.office'.tr(),
            metadata.office,
          ),
          _buildSpecRow(
            context,
            theme,
            'governance.dynamic_screen.security'.tr(),
            metadata.securityLevel.name.toUpperCase(),
          ),
          _buildSpecRow(
            context,
            theme,
            'governance.dynamic_screen.story_points'.tr(),
            metadata.storyPoints.toString(),
          ),
          _buildSpecRow(
            context,
            theme,
            'DESIGN TARGET',
            '${metadata.designSize.width.toInt()} x ${metadata.designSize.height.toInt()} (4K Ultra HD)',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(
    BuildContext context,
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

  Widget _buildArchitectureStatus(BuildContext context, PrimeThemeData theme, String screenStatus) {
    final bool isImplemented = screenStatus == 'IMPLEMENTED';

    return Column(
      children: [
        _buildArchCard(
          context,
          theme,
          'governance.dynamic_screen.sidebar_navigation'.tr(),
          isImplemented ? 'IMPLEMENTED' : 'DECLARED',
          LucideIcons.layoutPanelLeft,
        ),
        SizedBox(height: context.s(12)),
        _buildArchCard(
          context,
          theme,
          'governance.dynamic_screen.platform_top_bar'.tr(),
          isImplemented ? 'IMPLEMENTED' : 'DECLARED',
          LucideIcons.layoutPanelTop,
        ),
        SizedBox(height: context.s(12)),
        _buildArchCard(
          context,
          theme,
          'governance.dynamic_screen.main_content_area'.tr(),
          screenStatus,
          LucideIcons.layout,
        ),
      ],
    );
  }

  Widget _buildArchCard(
    BuildContext context,
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

  Widget _buildAuditActions(BuildContext context, PrimeThemeData theme) {
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
  
  Widget _buildCompletionHUD(BuildContext context, PrimeThemeData theme, double percent) {
    final color = percent > 90 
        ? Colors.green 
        : (percent > 40 ? Colors.blue : Colors.orange);

    return Container(
      width: context.s(700),
      padding: EdgeInsets.all(context.s(32)),
      decoration: BoxDecoration(
        color: theme.colors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(context.s(24)),
        border: Border.all(color: theme.colors.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.s(24)),
        child: Stack(
          children: [
            // Decorative background gradient
            Positioned(
              right: -context.s(50),
              top: -context.s(50),
              child: Container(
                width: context.s(200),
                height: context.s(200),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      color.withValues(alpha: 0.1),
                      color.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.s(12)),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(context.s(12)),
                      ),
                      child: Icon(LucideIcons.activity, color: color, size: context.s(24)),
                    ),
                    SizedBox(width: context.s(20)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'governance.dynamic_screen.implementation_progress'.tr().toUpperCase(),
                            style: theme.typography.labelMedium.copyWith(
                              fontSize: context.s(13),
                              fontWeight: FontWeight.w900,
                              color: theme.colors.onSurfaceVariant,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            percent >= 100 
                                ? 'Architectural Parity Achieved' 
                                : 'Structural Hydration in Progress',
                            style: theme.typography.bodySmall.copyWith(
                              color: theme.colors.onSurfaceVariant.withValues(alpha: 0.7),
                              fontSize: context.s(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${percent.toInt()}%',
                          style: theme.typography.h2.copyWith(
                            color: color,
                            fontWeight: FontWeight.w900,
                            fontSize: context.s(32),
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.s(32)),
                Stack(
                  children: [
                    Container(
                      height: context.s(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colors.outlineVariant.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(context.s(100)),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      height: context.s(16),
                      width: (context.s(700) - context.s(64)) * (percent / 100),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.7),
                            color,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(context.s(100)),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.s(24)),
                Container(
                  padding: EdgeInsets.all(context.s(16)),
                  decoration: BoxDecoration(
                    color: theme.colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(context.s(16)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.shieldCheck, size: context.s(18), color: color),
                      SizedBox(width: context.s(12)),
                      Expanded(
                        child: Text(
                          percent >= 100 
                              ? 'This screen has passed all automated governance audits and is certified for production deployment.' 
                              : 'Current metadata reflects implementation status in blueprints.yaml. Automated drift detection is active.',
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.onSurface,
                            fontSize: context.s(12),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
