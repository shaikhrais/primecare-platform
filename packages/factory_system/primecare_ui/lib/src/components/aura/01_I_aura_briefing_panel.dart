import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/registry/01_I_screen_registry.dart';
import 'package:primecare_ui/src/components/01_I_primecare_button.dart';
import 'package:primecare_ui/src/components/scheduler/01_I_aura_insight_card.dart';
import 'package:primecare_ui/src/theme/01_I_primecare_theme.dart';

class AuraBriefingPanel extends ConsumerWidget {
  const AuraBriefingPanel({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Aura Briefing',
      barrierColor: Colors.black.withValues(alpha: 0.1),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (ctx, anim1, anim2) => const AuraBriefingPanel(),
      transitionBuilder: (ctx, anim1, anim2, child) {
        final curve = CurveTween(curve: Curves.easeOutQuart).animate(anim1);
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curve),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final activeRoute = ref.watch(auraContextProvider);
    final screen = activeRoute != null
        ? ScreenRegistry.getScreen(activeRoute)
        : null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 420,
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.colors.surface.withValues(alpha: 0.95),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 40,
                offset: const Offset(-10, 0),
              ),
            ],
            border: Border(
              left: BorderSide(
                color: theme.colors.borderLight.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context, theme, screen),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(theme.spacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGovernanceBlueprint(context, theme, screen),
                      SizedBox(height: theme.spacing.xl),
                      _buildDailySummary(context, theme),
                      SizedBox(height: theme.spacing.xl),
                      _buildInsightSection(context, theme),
                    ],
                  ),
                ),
              ),
              _buildFooter(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGovernanceBlueprint(
    BuildContext context,
    PrimeCareThemeData theme,
    PrimeCareScreen? screen,
  ) {
    if (screen == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              LucideIcons.shieldCheck,
              color: theme.colors.success,
              size: 20,
            ),
            SizedBox(width: theme.spacing.sm),
            Text(
              'aura.auditors_blueprint'.tr(),
              style: theme.typography.labelMedium.copyWith(
                color: theme.colors.success,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        Container(
          padding: EdgeInsets.all(theme.spacing.lg),
          decoration: BoxDecoration(
            color: theme.colors.success.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colors.success.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'aura.structural_contract'.tr(),
                style: theme.typography.labelSmall.copyWith(
                  color: theme.colors.success.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: theme.spacing.sm),
              Text(
                screen.structuralPlan,
                style: theme.typography.bodyMedium.copyWith(
                  color: theme.colors.onSurface,
                  height: 1.5,
                ),
              ),
              SizedBox(height: theme.spacing.lg),
              Text(
                'aura.verified_components'.tr(),
                style: theme.typography.labelSmall.copyWith(
                  color: theme.colors.success.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: theme.spacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: screen.componentLabels.map((label) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colors.success.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      label,
                      style: theme.typography.labelSmall.copyWith(
                        color: theme.colors.success,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    PrimeCareThemeData theme,
    PrimeCareScreen? screen,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        theme.spacing.xl,
        theme.spacing.xxl,
        theme.spacing.lg,
        theme.spacing.xl,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colors.borderLight.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                screen?.title.toUpperCase() ?? 'aura.intelligence'.tr(),
                style: theme.typography.h2.copyWith(
                  letterSpacing: -0.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'aura.daily_briefing'.tr(
                  args: [
                    DateFormat.yMMMMd(
                      context.locale.toString(),
                    ).format(DateTime.now()),
                  ],
                ),
                style: theme.typography.labelSmall,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LucideIcons.x),
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummary(BuildContext context, PrimeCareThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.sparkles, color: theme.colors.primary, size: 20),
            SizedBox(width: theme.spacing.sm),
            Text(
              'aura.executive_overview'.tr(),
              style: theme.typography.labelMedium.copyWith(
                color: theme.colors.primary,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        Text(
          'aura.operational_summary'.tr(),
          style: theme.typography.bodyLarge.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildInsightSection(BuildContext context, PrimeCareThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'aura.critical_insights'.tr(),
          style: theme.typography.labelMedium.copyWith(letterSpacing: 1.2),
        ),
        SizedBox(height: theme.spacing.md),
        AuraInsightCard(
          event: AuraEvent(
            id: 'staff_retention',
            type: AuraEventType.hrPolicyAlert,
            title: 'aura.staff_retention_alert'.tr(),
            impact: InsightImpact.warning,
            description: 'aura.staff_retention_desc'.tr(),
            timestamp: DateTime.now(),
          ),
          actionLabel: 'aura.view_retention_plan'.tr(),
          onAction: () {},
        ),
        SizedBox(height: theme.spacing.md),
        AuraInsightCard(
          event: AuraEvent(
            id: 'marketing_roi',
            type: AuraEventType.marketingConversion,
            title: 'aura.marketing_roi_surge'.tr(),
            impact: InsightImpact.growth,
            description: 'aura.marketing_roi_desc'.tr(),
            timestamp: DateTime.now(),
          ),
          actionLabel: 'aura.adjust_budget'.tr(),
          onAction: () {},
        ),
        SizedBox(height: theme.spacing.md),
        AuraInsightCard(
          event: AuraEvent(
            id: 'supply_chain',
            type: AuraEventType.franchiseSync,
            title: 'aura.supply_chain_sync'.tr(),
            impact: InsightImpact.info,
            description: 'aura.supply_chain_desc'.tr(),
            timestamp: DateTime.now(),
          ),
          actionLabel: 'aura.see_report'.tr(),
          onAction: () {},
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, PrimeCareThemeData theme) {
    return Container(
      padding: EdgeInsets.all(theme.spacing.xl),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colors.borderLight.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: PrimeCareButton(
        label: 'aura.full_system_audit'.tr(),
        onPressed: () {},
        type: PrimeCareButtonType.primary,
        icon: LucideIcons.shieldCheck,
      ),
    );
  }
}
