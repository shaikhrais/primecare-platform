// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/engine/automated_audit_engine.dart';
import 'package:primecare_ui/src/widgets/system_health_badge.dart';
import 'package:flutter/foundation.dart';

// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

class DynamicRoleDashboardScreen extends ConsumerWidget {
  final String role;

  const DynamicRoleDashboardScreen({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dynamicRoleDashboardAdapterProvider(role));

    return state.when(
      data: (result) => result.fold(
        (vm) => _buildContent(context, theme, vm, ref),
        (e) => DashboardErrorWidget(
          message: 'Governance Error: $e',
          onRetry: () => ref.refresh(dynamicRoleDashboardAdapterProvider(role)),
        ),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (e, st) => DashboardErrorWidget(
        message: 'Connection Error: $e',
        onRetry: () => ref.refresh(dynamicRoleDashboardAdapterProvider(role)),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DynamicRoleDashboardScreenViewModel vm,
    WidgetRef ref,
  ) {
    final authState = ref.watch(authProvider);
    final isDemoMode = authState.token == 'demo-token';

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDemoMode) _buildDemoBanner(theme),
          _buildHeader(theme, vm, ref),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _buildInsightsSection(context, theme, vm),
        ],
      ),
    );
  }

  Widget _buildDemoBanner(PrimeCareThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.lg,
        vertical: theme.spacing.sm,
      ),
      margin: EdgeInsets.only(bottom: theme.spacing.lg),
      decoration: BoxDecoration(
        color: theme.colors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(theme.radii.md),
        border: Border.all(
          color: theme.colors.warning.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.flaskConical, color: theme.colors.warning, size: 16),
          SizedBox(width: theme.spacing.sm),
          Text(
            'DEMO MODE ACTIVE',
            style: theme.typography.labelSmall.copyWith(
              color: theme.colors.warning,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const Spacer(),
          Text(
            'Local Sandbox • No Data Persistence',
            style: theme.typography.labelSmall.copyWith(
              color: theme.colors.warning.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    PrimeCareThemeData theme,
    DynamicRoleDashboardScreenViewModel vm,
    WidgetRef ref,
  ) {
    final portalConfig = ref.watch(portalConfigProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                portalConfig.title,
                style: theme.typography.h1.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                ),
              ),
              SizedBox(height: theme.spacing.xs),
              Text(
                '${role.toUpperCase()} • Dynamic Role Command Center • Platform Fluidity',
                style: theme.typography.bodyLarge.copyWith(
                  color: theme.colors.slate400,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        if (kDebugMode)
          SystemHealthBadge(
            score: AutomatedAuditEngine.calculateHealthScore(),
            compact: true,
            onTap: () {
              // In a real app, this would navigate to the Verification Center
              // but here we just refresh or log
            },
          ),
      ],
    );
  }

  Widget _buildInsightsSection(
    BuildContext context,
    PrimeCareThemeData theme,
    DynamicRoleDashboardScreenViewModel vm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Insights', style: theme.typography.h3),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          color: theme.colors.surfaceContainerLow,
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: vm.insights.isEmpty
                ? [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'No critical anomalies detected for this sector.',
                        ),
                      ),
                    ),
                  ]
                : vm.insights
                    .map(
                      (insight) => DashboardInsightRow(
                        title: insight.title.translate(context),
                        description: insight.summary.translate(context),
                        type: insight.type.name,
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class DynamicRoleDashboardIntent extends PrimeCareScreen {
  final String role;
  DynamicRoleDashboardIntent({required this.role})
    : super(
        title: 'Dynamic Dashboard',
        route: '/offices/roles/$role/dashboard',
        componentLabels: const [
          'Aura HUD',
          'Permission Set Builder',
          'Role Inheritance Map',
          'User Role Audit',
        ],
      );

  @override
  Widget build(BuildContext context) => DynamicRoleDashboardScreen(role: role);
}
