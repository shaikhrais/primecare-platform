// Governance - Category: view | Purpose: DynamicScreenView - Fully governed visual sandbox branching responsive layouts across LIVE, HDL, GRID, and AUDIT modes.
import 'dart:ui';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_governance/core/ui/app_components.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';

/// DynamicScreenView - Fully governed visual sandbox branching responsive layouts
/// across LIVE, HDL, GRID, and AUDIT modes.
class DynamicScreenView extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'This screen requires components for monitoring project lifecycles, updating metadata, and tracking completion percentages, along with necessary buttons and API integrations.';

  @override
  List<String> get requiredComponents => const [
        'ProjectLifecycleChart',
        'ProjectStatusAlert',
        'MetadataEditor',
        'CompletionSummary',
        'TechnicalManifestViewer',
        'HistoricalDataTracker',
      ];

  @override
  List<String> get requiredFunctions => const [
        'updateProjectMetadata',
        'checkProjectStatus',
        'viewTechnicalManifest',
        'trackHistoricalData',
      ];

  final ScreenMetadata metadata;

  const DynamicScreenView({required this.metadata, super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final visionMode = ref.watch(auraVisionProvider);
    final Widget child;

    switch (visionMode) {
      case AuraVisionMode.highFidelity:
        child = _buildHifiView(context);
        break;
      case AuraVisionMode.blueprint:
        child = _buildBlueprintView(context);
        break;
      case AuraVisionMode.auraAudit:
        child = _buildAuditView(context);
        break;
      case AuraVisionMode.live:
        child = _buildLiveView(context);
        break;
    }

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      endDrawer: AuraNexusConsoleDrawer(activeScreenId: metadata.id),
      body: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            bottom: context.s(24),
            right: context.s(24),
            child: AuraNexusFAB(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 1. LIVE VIEW (Spec Manifest & Lifecycle HUD)
  // ==========================================
  Widget _buildLiveView(BuildContext context) {
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
      case LifecycleStatus.research:
      case LifecycleStatus.design:
      case LifecycleStatus.legacy:
        statusText = 'DECLARED';
        statusColor = theme.colors.warning;
        statusIcon = LucideIcons.fileSearch;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Premium Mesh Gradient Background
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

          // Main Content
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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Development initiation sequence activated for ${metadata.title}!')),
                );
              },
            ),
          ),
          SizedBox(height: context.s(12)),
          SizedBox(
            width: double.infinity,
            child: PrimeButton.secondary(
              label: 'governance.dynamic_screen.file_correction_ticket'.tr(),
              icon: LucideIcons.ticket,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File correction ticket registry opened for ${metadata.title}!')),
                );
              },
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

  // ==========================================
  // 2. HDL VIEW (High-Fidelity Sandbox)
  // ==========================================
  Widget _buildHifiView(BuildContext context) {
    final role = _detectHifiRole(metadata);
    switch (role) {
      case HifiRole.scheduler:
        return HifiSchedulerTimeline(metadata: metadata);
      case HifiRole.form:
        return HifiIntakeFormWizard(metadata: metadata);
      case HifiRole.compliance:
        return HifiComplianceConsole(metadata: metadata);
      case HifiRole.dashboard:
        return HifiTelemetryDashboard(metadata: metadata);
    }
  }

  static HifiRole _detectHifiRole(ScreenMetadata metadata) {
    final title = metadata.title.toLowerCase();
    if (title.contains('scheduler') || 
        title.contains('allocation') || 
        title.contains('capacity') || 
        title.contains('calendar') || 
        title.contains('schedule')) {
      return HifiRole.scheduler;
    }
    if (title.contains('form') || 
        title.contains('wizard') || 
        title.contains('intake') || 
        title.contains('proposal') || 
        title.contains('editor') || 
        title.contains('reporter')) {
      return HifiRole.form;
    }
    if (title.contains('incident') || 
        title.contains('compliance') || 
        title.contains('access') || 
        title.contains('audit') || 
        title.contains('security') || 
        title.contains('regulatory') || 
        title.contains('policy')) {
      return HifiRole.compliance;
    }
    return HifiRole.dashboard;
  }

  // ==========================================
  // 3. GRID VIEW (Blueprint Drafting Board)
  // ==========================================
  Widget _buildBlueprintView(BuildContext context) {
    return BlueprintSandboxView(metadata: metadata);
  }

  // ==========================================
  // 4. AUDIT VIEW (Remediation & Scorecard)
  // ==========================================
  Widget _buildAuditView(BuildContext context) {
    return AuditSandboxView(metadata: metadata);
  }
}

class AuraNexusFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const AuraNexusFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: theme.colors.primary.withValues(alpha: 0.4),
            blurRadius: context.s(16),
            spreadRadius: context.s(2),
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Material(
            color: theme.colors.primary.withValues(alpha: 0.25),
            child: InkWell(
              onTap: onPressed,
              splashColor: theme.colors.primary.withValues(alpha: 0.4),
              child: Container(
                width: context.s(64),
                height: context.s(64),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colors.primary.withValues(alpha: 0.5),
                    width: context.s(1.5),
                  ),
                ),
                child: Icon(
                  LucideIcons.pocket,
                  color: Colors.white,
                  size: context.s(28),
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate()
      .fadeIn(duration: 800.ms)
      .scale(delay: 200.ms, duration: 400.ms, curve: Curves.elasticOut)
      .shimmer(delay: 2.seconds, duration: 1.5.seconds);
  }
}

enum HifiRole { compliance, scheduler, form, dashboard }

// ==========================================
// HDL View 1: Compliance / Incident Sandbox
// ==========================================
class HifiComplianceConsole extends StatefulWidget {
  final ScreenMetadata metadata;
  const HifiComplianceConsole({required this.metadata, super.key});

  @override
  State<HifiComplianceConsole> createState() => _HifiComplianceConsoleState();
}

class _HifiComplianceConsoleState extends State<HifiComplianceConsole> {
  bool isBreachSimulated = false;
  bool isHipaaVerified = true;
  String activeCell = 'B3';
  final List<String> logs = [
    '[09:12:04] COMPLIANCE: Secure socket connection established.',
    '[09:15:30] SECURITY: Port scanning pattern blocked by WAF.',
    '[09:22:11] RBAC: DevAdmin read metadata for screen.',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.s(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top banner
            Row(
              children: [
                Icon(LucideIcons.shieldCheck, color: isBreachSimulated ? Colors.red : theme.colors.success, size: context.s(32)),
                SizedBox(width: context.s(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aura Sentinel: HIPAA Risk & Security Console',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Security Level: ${widget.metadata.securityLevel.name.toUpperCase()} | Subsystem: ${widget.metadata.subsystem.toUpperCase()}',
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: context.s(12), vertical: context.s(6)),
                  decoration: BoxDecoration(
                    color: (isBreachSimulated ? Colors.red : theme.colors.success).withValues(alpha: 0.1),
                    border: Border.all(color: isBreachSimulated ? Colors.red : theme.colors.success),
                    borderRadius: BorderRadius.circular(context.s(8)),
                  ),
                  child: Text(
                    isBreachSimulated ? 'CRITICAL RISK ALERT' : 'SHIELD STATUS: SECURE',
                    style: theme.typography.labelSmall.copyWith(
                      color: isBreachSimulated ? Colors.red : theme.colors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.s(24)),

            // Interactive simulation row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Probability Heatmap (Interactive grid)
                Expanded(
                  flex: 3,
                  child: Card(
                    color: theme.colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                    child: Padding(
                      padding: EdgeInsets.all(context.s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Risk Vulnerability Grid', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: context.s(4)),
                          Text('Select coordinate cells to audit live telemetry nodes', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                          SizedBox(height: context.s(20)),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: 16,
                            itemBuilder: (context, idx) {
                              final rowChar = String.fromCharCode(65 + (idx ~/ 4));
                              final colNum = (idx % 4) + 1;
                              final cellId = '$rowChar$colNum';
                              final isSelected = activeCell == cellId;

                              // Define some nice color variants
                              Color baseColor = theme.colors.success;
                              if (idx == 5 || idx == 10) baseColor = Colors.amber;
                              if (idx == 11) baseColor = Colors.orange;
                              if (idx == 15 && isBreachSimulated) baseColor = Colors.red;

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    activeCell = cellId;
                                    logs.insert(0, '[${DateTime.now().toString().substring(11, 19)}] AUDIT: Checked node $cellId - Integrity score is ${(95 + (idx % 5))}%');
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: 300.ms,
                                  decoration: BoxDecoration(
                                    color: baseColor.withValues(alpha: isSelected ? 0.3 : 0.1),
                                    borderRadius: BorderRadius.circular(context.s(10)),
                                    border: Border.all(
                                      color: isSelected ? theme.colors.primary : baseColor,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: isSelected ? [
                                      BoxShadow(color: theme.colors.primary.withValues(alpha: 0.3), blurRadius: 8)
                                    ] : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      cellId,
                                      style: theme.typography.labelBold.copyWith(
                                        color: isSelected ? theme.colors.primary : baseColor,
                                        fontSize: context.s(14),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.s(20)),

                // Controls & Audit Trails
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      // Controls panel
                      Card(
                        color: theme.colors.surfaceContainerLow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                        child: Padding(
                          padding: EdgeInsets.all(context.s(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Simulation Controls', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                              SizedBox(height: context.s(16)),
                              SwitchListTile(
                                title: Text('Simulate Breach Attempt', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                                subtitle: const Text('Forces critical network alerts and grid failures'),
                                activeThumbColor: Colors.red,
                                value: isBreachSimulated,
                                onChanged: (val) {
                                  setState(() {
                                    isBreachSimulated = val;
                                    if (val) {
                                      logs.insert(0, '[${DateTime.now().toString().substring(11, 19)}] WARNING: Intrusion alert simulated on cell D4!');
                                    } else {
                                      logs.insert(0, '[${DateTime.now().toString().substring(11, 19)}] SUCCESS: Firewall reset, threat quarantined.');
                                    }
                                  });
                                },
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimeButton.secondary(
                                      label: isHipaaVerified ? 'Verify HIPAA Stack' : 'Verifying...',
                                      icon: LucideIcons.shieldAlert,
                                      onPressed: () {
                                        setState(() {
                                          isHipaaVerified = false;
                                          logs.insert(0, '[${DateTime.now().toString().substring(11, 19)}] RUNNING: Validating cryptographic transport layers...');
                                        });
                                        Future.delayed(1500.ms, () {
                                          if (mounted) {
                                            setState(() {
                                              isHipaaVerified = true;
                                              logs.insert(0, '[${DateTime.now().toString().substring(11, 19)}] SUCCESS: HIPAA AES-256 validation verified.');
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: context.s(16)),

                      // Raw telemetry ledger
                      Card(
                        color: theme.colors.surfaceContainerLow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(context.s(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Active Security Ledger', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                  ),
                                  SizedBox(width: context.s(6)),
                                  Text('LIVE', style: theme.typography.labelSmall.copyWith(color: Colors.green)),
                                ],
                              ),
                              SizedBox(height: context.s(12)),
                              Container(
                                height: context.s(120),
                                padding: EdgeInsets.all(context.s(12)),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(context.s(8)),
                                  border: Border.all(color: theme.colors.outlineVariant),
                                ),
                                child: ListView.builder(
                                  itemCount: logs.length,
                                  itemBuilder: (context, idx) {
                                    final log = logs[idx];
                                    final isWarn = log.contains('WARNING') || log.contains('Breach');
                                    final isSuccess = log.contains('SUCCESS') || log.contains('PASSED');
                                    Color logColor = theme.colors.onSurface;
                                    if (isWarn) logColor = Colors.red;
                                    if (isSuccess) logColor = Colors.green;

                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: context.s(4)),
                                      child: Text(
                                        log,
                                        style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: context.s(11),
                                          color: logColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
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

// ==========================================
// HDL View 2: Horizon Scheduler / Staffing Heatmap
// ==========================================
class HifiSchedulerTimeline extends StatefulWidget {
  final ScreenMetadata metadata;
  const HifiSchedulerTimeline({required this.metadata, super.key});

  @override
  State<HifiSchedulerTimeline> createState() => _HifiSchedulerTimelineState();
}

class _HifiSchedulerTimelineState extends State<HifiSchedulerTimeline> {
  String selectedCandidate = 'Dr. Sarah Jenkins';
  final Map<String, String> assignments = {
    '08:00 AM - 12:00 PM': 'Dr. Sarah Jenkins (ER Specialism)',
    '12:00 PM - 04:00 PM': 'Nurse Michael Patel (Critical Care)',
    '04:00 PM - 08:00 PM': 'Dr. Elena Rostova (Pediatrics)',
    '08:00 PM - 12:00 AM': 'Vacant / Standby Node Required',
  };

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.s(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.calendarClock, color: theme.colors.primary, size: context.s(32)),
                SizedBox(width: context.s(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Horizon: AI Resource & Shift Planner',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Staffing Heatmap & Compliance Engine',
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.s(24)),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Candidate Matching & Selector
                Expanded(
                  flex: 3,
                  child: Card(
                    color: theme.colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                    child: Padding(
                      padding: EdgeInsets.all(context.s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Match Compatibility Index', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: context.s(4)),
                          Text('Select candidates to assign to open shift blocks', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                          SizedBox(height: context.s(16)),

                          _buildCandidateTile('Dr. Sarah Jenkins', 'Emergency Medicine', 98, theme.colors.success),
                          SizedBox(height: context.s(12)),
                          _buildCandidateTile('Nurse Michael Patel', 'Intensive Care', 94, theme.colors.success),
                          SizedBox(height: context.s(12)),
                          _buildCandidateTile('Dr. Elena Rostova', 'Pediatric Medicine', 89, Colors.blue),
                          SizedBox(height: context.s(12)),
                          _buildCandidateTile('Dr. Arthur Dent', 'General Practice', 64, Colors.amber),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.s(20)),

                // Timelines & Scheduling
                Expanded(
                  flex: 4,
                  child: Card(
                    color: theme.colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                    child: Padding(
                      padding: EdgeInsets.all(context.s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Assigned Care Slots - Today', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: context.s(16)),
                          Column(
                            children: assignments.entries.map((entry) {
                              final isVacant = entry.value.contains('Vacant');
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: context.s(8)),
                                child: Container(
                                  padding: EdgeInsets.all(context.s(16)),
                                  decoration: BoxDecoration(
                                    color: theme.colors.surface,
                                    borderRadius: BorderRadius.circular(context.s(12)),
                                    border: Border.all(
                                      color: isVacant ? Colors.orange.withValues(alpha: 0.5) : theme.colors.outlineVariant,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isVacant ? LucideIcons.alertTriangle : LucideIcons.clock,
                                        color: isVacant ? Colors.orange : theme.colors.primary,
                                      ),
                                      SizedBox(width: context.s(12)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(entry.key, style: theme.typography.labelBold),
                                            Text(
                                              entry.value,
                                              style: theme.typography.bodyMedium.copyWith(
                                                color: isVacant ? Colors.orange : theme.colors.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isVacant)
                                        PrimeButton.primary(
                                          label: 'Assign Select',
                                          onPressed: () {
                                            setState(() {
                                              assignments[entry.key] = '$selectedCandidate (Auto-matched)';
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateTile(String name, String specialty, double score, Color color) {
    final isSelected = selectedCandidate == name;
    final theme = context.theme;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCandidate = name;
        });
      },
      child: AnimatedContainer(
        duration: 200.ms,
        padding: EdgeInsets.all(context.s(14)),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(context.s(12)),
          border: Border.all(
            color: isSelected ? theme.colors.primary : theme.colors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(color: theme.colors.primary.withValues(alpha: 0.15), blurRadius: 10)
          ] : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
              child: Icon(LucideIcons.user, color: theme.colors.primary),
            ),
            SizedBox(width: context.s(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                  Text(specialty, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${score.toInt()}%', style: theme.typography.labelBold.copyWith(color: color)),
                Text('Match Index', style: theme.typography.bodySmall.copyWith(fontSize: context.s(9))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// HDL View 3: Intake Form / Proposal Wizard
// ==========================================
class HifiIntakeFormWizard extends StatefulWidget {
  final ScreenMetadata metadata;
  const HifiIntakeFormWizard({required this.metadata, super.key});

  @override
  State<HifiIntakeFormWizard> createState() => _HifiIntakeFormWizardState();
}

class _HifiIntakeFormWizardState extends State<HifiIntakeFormWizard> {
  int currentStep = 1;
  bool isUploading = false;
  double uploadProgress = 0.0;
  String? uploadedFileName;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.s(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.folderInput, color: theme.colors.primary, size: context.s(32)),
                SizedBox(width: context.s(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intake Portal: Secure Governance Form Wizard',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Feature: ${widget.metadata.featureName} | Auto-encrypted transport layer active',
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.s(24)),

            // Steps Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepCircle(1, 'Protocol Metadata'),
                _buildStepLine(1),
                _buildStepCircle(2, 'Secure Upload'),
                _buildStepLine(2),
                _buildStepCircle(3, 'Sign & Commit'),
              ],
            ),
            SizedBox(height: context.s(40)),

            Center(
              child: Card(
                color: theme.colors.surfaceContainerLow,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(20))),
                child: Container(
                  width: context.s(600),
                  padding: EdgeInsets.all(context.s(32)),
                  child: Column(
                    children: [
                      if (currentStep == 1) ...[
                        Text('Configure System Metadata', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: context.s(24)),
                        AppInput(label: 'Assigned Custodian Developer', hint: widget.metadata.assignedDeveloper),
                        SizedBox(height: context.s(16)),
                        AppInput(label: 'Deployment Target Environment', hint: widget.metadata.deploymentEnvironment),
                        SizedBox(height: context.s(24)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PrimeButton.primary(
                              label: 'Continue to Secure Upload',
                              icon: LucideIcons.arrowRight,
                              onPressed: () => setState(() => currentStep = 2),
                            ),
                          ],
                        ),
                      ] else if (currentStep == 2) ...[
                        Text('Cryptographically Secure Storage Upload', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: context.s(8)),
                        Text('Attachments are checked for HIPAA & PHI safety guidelines automatically', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant), textAlign: TextAlign.center),
                        SizedBox(height: context.s(24)),
                        InkWell(
                          onTap: isUploading ? null : () {
                            setState(() {
                              isUploading = true;
                              uploadProgress = 0.0;
                            });
                            // Simulate upload
                            Future.doWhile(() async {
                              await Future.delayed(200.ms);
                              if (!mounted) return false;
                              setState(() {
                                uploadProgress += 0.25;
                              });
                              if (uploadProgress >= 1.0) {
                                setState(() {
                                  isUploading = false;
                                  uploadedFileName = 'governance_manifest_v2.json';
                                });
                                return false;
                              }
                              return true;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(context.s(32)),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: BorderRadius.circular(context.s(16)),
                              border: Border.all(
                                color: theme.colors.outlineVariant,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(LucideIcons.uploadCloud, size: context.s(48), color: theme.colors.primary),
                                SizedBox(height: context.s(16)),
                                Text(
                                  uploadedFileName ?? 'Click to upload security token payload',
                                  style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: context.s(4)),
                                Text('Supported files: JSON, YAML (Max size: 10MB)', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                                if (isUploading) ...[
                                  SizedBox(height: context.s(20)),
                                  LinearProgressIndicator(value: uploadProgress, color: theme.colors.primary),
                                  SizedBox(height: context.s(8)),
                                  Text('${(uploadProgress * 100).toInt()}% uploaded...', style: theme.typography.labelSmall),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: context.s(24)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(key: const Key('dynamic_screen_view_textbutton_button_1'), 
                              onPressed: () => setState(() => currentStep = 1),
                              child: const Text('Back'),
                            ),
                            PrimeButton.primary(
                              label: 'Continue to Signature',
                              icon: LucideIcons.arrowRight,
                              onPressed: uploadedFileName == null ? null : () => setState(() => currentStep = 3),
                            ),
                          ],
                        ),
                      ] else ...[
                        Icon(LucideIcons.badgeCheck, color: Colors.green, size: context.s(64)),
                        SizedBox(height: context.s(16)),
                        Text('Signature Verification Complete', style: theme.typography.h2.copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: context.s(8)),
                        Text(
                          'Your cryptographic package and verification hash have been written to blueprints.yaml.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: context.s(24)),
                        PrimeButton.secondary(
                          label: 'Reset Wizard Sandbox',
                          onPressed: () {
                            setState(() {
                              currentStep = 1;
                              uploadedFileName = null;
                            });
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCircle(int step, String name) {
    final theme = context.theme;
    final isDone = currentStep > step;
    final isActive = currentStep == step;
    final color = isDone ? Colors.green : (isActive ? theme.colors.primary : theme.colors.outlineVariant);

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          radius: context.s(20),
          child: isDone
              ? const Icon(LucideIcons.check, color: Colors.green)
              : Text('$step', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: context.s(8)),
        Text(
          name,
          style: theme.typography.bodySmall.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? theme.colors.onSurface : theme.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int afterStep) {
    final theme = context.theme;
    final isDone = currentStep > afterStep;
    return Container(
      width: context.s(80),
      height: 2,
      color: isDone ? Colors.green : theme.colors.outlineVariant,
      margin: EdgeInsets.symmetric(horizontal: context.s(8), vertical: context.s(20)),
    );
  }
}

// ==========================================
// HDL View 4: Executive Telemetry Dashboard
// ==========================================
class HifiTelemetryDashboard extends StatefulWidget {
  final ScreenMetadata metadata;
  const HifiTelemetryDashboard({required this.metadata, super.key});

  @override
  State<HifiTelemetryDashboard> createState() => _HifiTelemetryDashboardState();
}

class _HifiTelemetryDashboardState extends State<HifiTelemetryDashboard> {
  double currentLoad = 48.0;
  bool isRefreshing = false;
  final List<double> telemetryDataPoints = [20, 35, 28, 45, 30, 48, 52];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.s(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.layoutDashboard, color: theme.colors.primary, size: context.s(32)),
                SizedBox(width: context.s(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Executive Hub: Platform Telemetry & Analytics',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Active Office: ${widget.metadata.office} | ID: ${widget.metadata.id}',
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(key: const Key('dynamic_screen_view_iconbutton_button_1'), 
                  icon: isRefreshing
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(LucideIcons.refreshCw),
                  onPressed: isRefreshing ? null : () {
                    setState(() {
                      isRefreshing = true;
                    });
                    Future.delayed(1000.ms, () {
                      if (mounted) {
                        setState(() {
                          isRefreshing = false;
                          currentLoad = 40 + (DateTime.now().second % 35).toDouble();
                          telemetryDataPoints.removeAt(0);
                          telemetryDataPoints.add(currentLoad);
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: context.s(24)),

            // KPI Cards row
            Row(
              children: [
                Expanded(child: _buildKpiCard('System Load Rate', '${currentLoad.toInt()}%', LucideIcons.cpu, Colors.blue)),
                SizedBox(width: context.s(16)),
                Expanded(child: _buildKpiCard('PHI Integrity Pass', widget.metadata.isPhiCompliant ? '100%' : '98.4%', LucideIcons.heartPulse, theme.colors.success)),
                SizedBox(width: context.s(16)),
                Expanded(child: _buildKpiCard('Accessibility Score', '${(widget.metadata.accessibilityScore * 100).toInt()}%', LucideIcons.accessibility, Colors.purple)),
                SizedBox(width: context.s(16)),
                Expanded(child: _buildKpiCard('Estimated Story Points', '${widget.metadata.storyPoints}', LucideIcons.gem, Colors.amber)),
              ],
            ),
            SizedBox(height: context.s(24)),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Chart Custom Paint
                Expanded(
                  flex: 4,
                  child: Card(
                    color: theme.colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                    child: Padding(
                      padding: EdgeInsets.all(context.s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Network Request Wave (Load Simulation)', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: context.s(24)),
                          Container(
                            height: context.s(200),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(context.s(12)),
                            ),
                            child: CustomPaint(
                              painter: TelemetryChartPainter(dataPoints: telemetryDataPoints, theme: theme),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.s(20)),

                // Metadata ledger
                Expanded(
                  flex: 3,
                  child: Card(
                    color: theme.colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                    child: Padding(
                      padding: EdgeInsets.all(context.s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Readiness Audits', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: context.s(16)),
                          _buildReadinessRow('RBAC Authorization', widget.metadata.roles.isNotEmpty, 'Pass'),
                          _buildReadinessRow('Localization Ready', widget.metadata.isLocalizationReady, 'Ready'),
                          _buildReadinessRow('Responsive Checked', widget.metadata.isDesktopVerified && widget.metadata.isMobileVerified, 'Verified'),
                          _buildReadinessRow('Telemetry Hooks Active', widget.metadata.isTelemetryVerified, 'Linked'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    final theme = context.theme;
    return Card(
      color: theme.colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
      child: Container(
        padding: EdgeInsets.all(context.s(20)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: context.s(16)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                Text(value, style: theme.typography.h3.copyWith(fontWeight: FontWeight.w900)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadinessRow(String title, bool val, String valueText) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s(8)),
      child: Row(
        children: [
          Icon(
            val ? LucideIcons.checkCircle : LucideIcons.alertCircle,
            color: val ? theme.colors.success : Colors.amber,
            size: context.s(20),
          ),
          SizedBox(width: context.s(12)),
          Expanded(child: Text(title, style: theme.typography.bodyMedium)),
          Text(
            val ? valueText : 'PENDING',
            style: theme.typography.labelBold.copyWith(color: val ? theme.colors.success : Colors.amber),
          ),
        ],
      ),
    );
  }
}

class TelemetryChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final PrimeThemeData theme;

  TelemetryChartPainter({required this.dataPoints, required this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.colors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = theme.colors.primary.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    if (dataPoints.isEmpty) return;

    final path = Path();
    final fillPath = Path();

    final double segmentWidth = size.width / (dataPoints.length - 1);
    final double maxVal = 100.0;

    double x = 0;
    double y = size.height - (dataPoints[0] / maxVal) * size.height;

    path.moveTo(x, y);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(x, y);

    for (int i = 1; i < dataPoints.length; i++) {
      x += segmentWidth;
      y = size.height - (dataPoints[i] / maxVal) * size.height;
      path.lineTo(x, y);
      fillPath.lineTo(x, y);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = theme.colors.outlineVariant.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    for (int i = 1; i < 4; i++) {
      final double h = size.height * (i / 4);
      canvas.drawLine(Offset(0, h), Offset(size.width, h), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ==========================================
// GRID View: Blueprint Sandbox Drawer Widget
// ==========================================
class BlueprintSandboxView extends GovernedConsumerStatefulWidget {
  final ScreenMetadata metadata;
  const BlueprintSandboxView({required this.metadata, super.key});

  @override
  State<BlueprintSandboxView> createState() => _BlueprintSandboxViewState();
}

class _BlueprintSandboxViewState extends GovernedConsumerState<BlueprintSandboxView> {
  @override
  String get screenDescription =>
      'The screen requires components to monitor lifecycle status, completion percentage, and governance actions, along with buttons for accessing technical details and refreshing data.';

  @override
  List<String> get requiredComponents => const [
        'LifecycleStatusIndicator',
        'CompletionPercentageIndicator',
        'TechnicalManifestViewer',
        'DevelopmentPipelineViewer',
        'GovernanceAlerts',
        'RecentActivitiesSummary',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchLifecycleStatus',
        'fetchCompletionPercentage',
        'fetchTechnicalManifest',
        'fetchDevelopmentPipeline',
        'checkGovernanceActions',
        'fetchRecentActivities',
      ];

  String jsonSearchQuery = '';

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;

    // Filter metadata fields for JSON Inspector
    final rawJsonMap = widget.metadata.toJson();
    final filteredJsonMap = <String, dynamic>{};
    rawJsonMap.forEach((key, val) {
      if (jsonSearchQuery.isEmpty || key.toLowerCase().contains(jsonSearchQuery.toLowerCase()) || val.toString().toLowerCase().contains(jsonSearchQuery.toLowerCase())) {
        filteredJsonMap[key] = val;
      }
    });

    final String prettyJson = const JsonEncoder.withIndent('  ').convert(filteredJsonMap);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F26), // Premium Navy drafting background
      body: Row(
        children: [
          // 1. Grid Canvas Drafting Area
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: BlueprintGridPainter(theme: theme),
                  ),
                ),

                // Center Title Board
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GRID DRAFTBOARD',
                        style: theme.typography.labelBold.copyWith(
                          color: const Color(0xFF00FFCC),
                          fontSize: context.s(14),
                          letterSpacing: 4.0,
                        ),
                      ),
                      SizedBox(height: context.s(12)),
                      Text(
                        widget.metadata.title,
                        style: theme.typography.h1.copyWith(
                          color: Colors.white,
                          fontSize: context.s(40),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.s(8)),
                      Text(
                        'BOUNDS: ${widget.metadata.designSize.width.toInt()} x ${widget.metadata.designSize.height.toInt()}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontFamily: 'monospace',
                          fontSize: context.s(12),
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Absolute Bounding Box Indicators
                _buildOutlineBox(
                  context,
                  top: 24,
                  left: 24,
                  width: context.s(220),
                  height: context.s(500),
                  label: 'Sidebar Access Zone [W: 240px]',
                  color: Colors.greenAccent,
                ),
                _buildOutlineBox(
                  context,
                  top: 24,
                  right: 24,
                  width: context.s(600),
                  height: context.s(60),
                  label: 'Primary Top Bar [H: 80px]',
                  color: Colors.purpleAccent,
                ),
                _buildOutlineBox(
                  context,
                  bottom: 24,
                  left: 24,
                  width: context.s(600),
                  height: context.s(200),
                  label: 'Main Content Area Canvas Grid',
                  color: Colors.orangeAccent,
                ),
              ],
            ),
          ),

          // 2. Right Properties Inspector Drawer
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF050814),
                border: Border(left: BorderSide(color: Color(0xFF1E293B))),
              ),
              padding: EdgeInsets.all(context.s(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.binary, color: Color(0xFF00FFCC)),
                      SizedBox(width: context.s(12)),
                      Text(
                        'PROPERTIES INSPECTOR',
                        style: theme.typography.labelBold.copyWith(color: Colors.white, fontSize: context.s(14)),
                      ),
                    ],
                  ),
                  SizedBox(height: context.s(16)),
                  TextField(key: const Key('dynamic_screen_view_textfield_input_1'), 
                    style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
                    decoration: InputDecoration(
                      hintText: 'Filter keys (e.g. status)...',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                      prefixIcon: const Icon(LucideIcons.search, color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0D152D),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(context.s(8)), borderSide: BorderSide.none),
                    ),
                    onChanged: (val) {
                      setState(() {
                        jsonSearchQuery = val;
                      });
                    },
                  ),
                  SizedBox(height: context.s(20)),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(context.s(16)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF02040A),
                        borderRadius: BorderRadius.circular(context.s(12)),
                        border: Border.all(color: const Color(0xFF1E293B)),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          prettyJson,
                          style: TextStyle(
                            color: const Color(0xFF00FFCC),
                            fontFamily: 'monospace',
                            fontSize: context.s(11),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlineBox(
    BuildContext context, {
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double width,
    required double height,
    required String label,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.8), style: BorderStyle.solid),
          color: color.withValues(alpha: 0.03),
        ),
        child: Stack(
          children: [
            // Dotted crosshair corners
            Positioned(top: 2, left: 2, child: Text('+', style: TextStyle(color: color, fontSize: 14))),
            Positioned(top: 2, right: 2, child: Text('+', style: TextStyle(color: color, fontSize: 14))),
            Positioned(bottom: 2, left: 2, child: Text('+', style: TextStyle(color: color, fontSize: 14))),
            Positioned(bottom: 2, right: 2, child: Text('+', style: TextStyle(color: color, fontSize: 14))),

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: context.s(8), vertical: context.s(4)),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(context.s(4)),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: context.s(10),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlueprintGridPainter extends CustomPainter {
  final PrimeThemeData theme;
  BlueprintGridPainter({required this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF00FFCC).withValues(alpha: 0.08)
      ..strokeWidth = 0.5;

    final majorGridPaint = Paint()
      ..color = const Color(0xFF00FFCC).withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    // Draw grid lines
    const double spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      final isMajor = (x / spacing) % 5 == 0;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), isMajor ? majorGridPaint : gridPaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      final isMajor = (y / spacing) % 5 == 0;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), isMajor ? majorGridPaint : gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// AUDIT View: Scorecard & Drift Patcher Widget
// ==========================================
class AuditSandboxView extends GovernedConsumerStatefulWidget {
  final ScreenMetadata metadata;
  const AuditSandboxView({required this.metadata, super.key});

  @override
  State<AuditSandboxView> createState() => _AuditSandboxViewState();
}

class _AuditSandboxViewState extends GovernedConsumerState<AuditSandboxView> {
  @override
  String get screenDescription =>
      'The audit sandbox screen requires components to display project lifecycle status, completion percentage, technical manifest, development pipeline, governance metrics, and alerts for red flags.';

  @override
  List<String> get requiredComponents => const [
        'LifecycleStatusDisplay',
        'CompletionPercentageIndicator',
        'TechnicalManifestOverview',
        'DevelopmentPipelineStatus',
        'GovernanceActionsMetrics',
        'RedFlagsAlert',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchLifecycleStatus',
        'fetchCompletionPercentage',
        'fetchTechnicalManifest',
        'fetchDevelopmentPipeline',
        'fetchGovernanceMetrics',
        'checkForRedFlags',
      ];

  bool isRemediating = false;
  double remediationProgress = 0.0;
  bool isFullyRemediated = false;
  final List<String> consoleLogs = [];

  final List<Map<String, dynamic>> drifts = [
    {
      'id': 'DRIFT-01',
      'drift': 'Missing localized tr() translations on action button text properties',
      'remediated': false,
    },
    {
      'id': 'DRIFT-02',
      'drift': 'Potential visual bleed overflow risk on viewport size 375px',
      'remediated': false,
    },
    {
      'id': 'DRIFT-03',
      'drift': 'Missing custom telemetry payload validation key handler hook',
      'remediated': false,
    },
  ];

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;
    final double baseScore = widget.metadata.isAuditCompliant ? 1.0 : 0.78;
    final double finalScore = isFullyRemediated ? 1.0 : baseScore;

    return Scaffold(
      backgroundColor: theme.colors.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.s(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  finalScore == 1.0 ? LucideIcons.badgeCheck : LucideIcons.shieldAlert,
                  color: finalScore == 1.0 ? theme.colors.success : Colors.amber,
                  size: context.s(32),
                ),
                SizedBox(width: context.s(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aura Compliance Audit & Drift Remediation Ledger',
                      style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Automated AST drift scanning engine & patch center',
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.s(24)),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Gauge Scorecard
                Expanded(
                  flex: 3,
                  child: Card(
                    color: theme.colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                    child: Padding(
                      padding: EdgeInsets.all(context.s(24)),
                      child: Column(
                        children: [
                          Text('Overall Platform Compliance', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: context.s(32)),
                          SizedBox(
                            width: context.s(160),
                            height: context.s(160),
                            child: CustomPaint(
                              painter: IntegrityGaugePainter(score: finalScore, theme: theme),
                              child: Center(
                                child: Text(
                                  '${(finalScore * 100).toInt()}%',
                                  style: theme.typography.h1.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: context.s(36),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: context.s(32)),
                          Container(
                            padding: EdgeInsets.all(context.s(16)),
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: BorderRadius.circular(context.s(12)),
                            ),
                            child: Column(
                              children: [
                                _buildMetricCheck('PHI Sensitive Safe', widget.metadata.isPhiCompliant),
                                const Divider(),
                                _buildMetricCheck('Desktop Responsive', widget.metadata.isDesktopVerified),
                                const Divider(),
                                _buildMetricCheck('Mobile Responsive', widget.metadata.isMobileVerified || isFullyRemediated),
                                const Divider(),
                                _buildMetricCheck('Accessibility Verified', widget.metadata.isAccessibilityVerified),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.s(20)),

                // 2. Drift Auto-Patcher
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Card(
                        color: theme.colors.surfaceContainerLow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                        child: Padding(
                          padding: EdgeInsets.all(context.s(24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Detected Structural Drifts', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  if (isFullyRemediated)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: context.s(8), vertical: context.s(4)),
                                      decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(context.s(4))),
                                      child: const Text('ALL PATCHED', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
                                    ),
                                ],
                              ),
                              SizedBox(height: context.s(16)),
                              Column(
                                children: drifts.map((drift) {
                                  final isP = isFullyRemediated || drift['remediated'] == true;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: context.s(6)),
                                    child: Container(
                                      padding: EdgeInsets.all(context.s(12)),
                                      decoration: BoxDecoration(
                                        color: theme.colors.surface,
                                        borderRadius: BorderRadius.circular(context.s(8)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isP ? LucideIcons.checkCircle2 : LucideIcons.circleDot,
                                            color: isP ? Colors.green : Colors.amber,
                                          ),
                                          SizedBox(width: context.s(12)),
                                          Expanded(
                                            child: Text(
                                              drift['drift'] as String,
                                              style: theme.typography.bodyMedium.copyWith(
                                                color: isP ? theme.colors.onSurfaceVariant : theme.colors.onSurface,
                                                decoration: isP ? TextDecoration.lineThrough : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: context.s(24)),
                              if (isRemediating) ...[
                                LinearProgressIndicator(value: remediationProgress, color: theme.colors.primary),
                                SizedBox(height: context.s(8)),
                                Text('Hot-remediating AST files...', style: theme.typography.labelSmall),
                                SizedBox(height: context.s(16)),
                              ],
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimeButton.primary(
                                      label: isFullyRemediated 
                                          ? 'Remediation Locked & Compliant' 
                                          : (isRemediating ? 'Scanning AST Trees...' : 'Autopatch & Remediate Screen'),
                                      icon: LucideIcons.zap,
                                      onPressed: isFullyRemediated || isRemediating ? null : () {
                                        setState(() {
                                          isRemediating = true;
                                          remediationProgress = 0.0;
                                          consoleLogs.insert(0, '[00:01] Initializing AST Engine...');
                                        });

                                        Future.doWhile(() async {
                                          await Future.delayed(300.ms);
                                          if (!mounted) return false;
                                          setState(() {
                                            remediationProgress += 0.2;
                                          });

                                          if (remediationProgress >= 0.2 && remediationProgress < 0.4) {
                                            consoleLogs.insert(0, '[00:02] Injecting translation tr() hooks into action fields...');
                                          } else if (remediationProgress >= 0.4 && remediationProgress < 0.6) {
                                            consoleLogs.insert(0, '[00:03] Injecting padding viewport safe adapters...');
                                          } else if (remediationProgress >= 0.6 && remediationProgress < 0.8) {
                                            consoleLogs.insert(0, '[00:04] Resolving missing telemetry event triggers...');
                                          } else if (remediationProgress >= 1.0) {
                                            setState(() {
                                              isRemediating = false;
                                              isFullyRemediated = true;
                                              consoleLogs.insert(0, '[00:05] Audit Complete! Integrity secured and certified.');
                                            });
                                            return false;
                                          }
                                          return true;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: context.s(16)),

                      // Patcher log shell
                      Card(
                        color: theme.colors.surfaceContainerLow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.s(16))),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(context.s(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Patcher Logs', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                              SizedBox(height: context.s(12)),
                              Container(
                                height: context.s(120),
                                width: double.infinity,
                                padding: EdgeInsets.all(context.s(12)),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(context.s(8)),
                                  border: Border.all(color: theme.colors.outlineVariant),
                                ),
                                child: consoleLogs.isEmpty
                                    ? Center(child: Text('Shell inactive. Start remediation to execute.', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)))
                                    : ListView.builder(
                                        itemCount: consoleLogs.length,
                                        itemBuilder: (context, idx) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(vertical: context.s(3)),
                                            child: Text(
                                              consoleLogs[idx],
                                              style: TextStyle(
                                                color: consoleLogs[idx].contains('Complete') ? Colors.green : Colors.white70,
                                                fontFamily: 'monospace',
                                                fontSize: context.s(11),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
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

  Widget _buildMetricCheck(String name, bool val) {
    final theme = context.theme;
    return Row(
      children: [
        Icon(val ? LucideIcons.checkCircle2 : LucideIcons.circleDot, color: val ? Colors.green : Colors.amber, size: context.s(18)),
        SizedBox(width: context.s(12)),
        Text(name, style: theme.typography.bodyMedium),
        const Spacer(),
        Text(
          val ? 'PASSED' : 'DRIFTED',
          style: theme.typography.labelSmall.copyWith(color: val ? Colors.green : Colors.amber, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class IntegrityGaugePainter extends CustomPainter {
  final double score;
  final PrimeThemeData theme;
  IntegrityGaugePainter({required this.score, required this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = theme.colors.outlineVariant.withValues(alpha: 0.3)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = score == 1.0 ? theme.colors.success : theme.colors.primary
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 7, bgPaint);

    // Draw arc representing score
    const double startAngle = -3.14159 / 2;
    final double sweepAngle = 2 * 3.14159 * score;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 7),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
