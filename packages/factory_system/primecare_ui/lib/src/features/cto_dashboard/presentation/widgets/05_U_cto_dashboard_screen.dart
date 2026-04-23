// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CtoDashboardScreen extends ConsumerWidget {
  const CtoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(ctoDashboardAdapterProvider);

    return state.when(
      data: (result) => result.fold(
        (viewModel) => _buildContent(context, theme, viewModel),
        (err) => DashboardErrorWidget(
          message: 'Domain Logistics Failure: $err',
          onRetry: () => ref.refresh(ctoDashboardAdapterProvider),
        ),
      ),
      loading: () => const DashboardLoadingWidget(),
      error: (Object e, StackTrace st) => DashboardErrorWidget(
        message: 'Governance Exception: $e',
        onRetry: () => ref.refresh(ctoDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CtoDashboardViewModel vm,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1200;
        final horizontalPadding = isDesktop ? theme.spacing.xl : theme.spacing.lg;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: theme.spacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, theme),
              SizedBox(height: theme.spacing.xl),
              
              // 16-Column Command Horizon Grid (Simulated via LayoutBuilder)
              if (isDesktop)
                _buildDesktopGrid(context, theme, vm)
              else
                _buildMobileStack(context, theme, vm),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMMAND HORIZON',
                style: theme.typography.h1.copyWith(
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00FFCC),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: theme.spacing.xs),
                  Text(
                    'SYSTEM INTEGRITY OPTIMAL • ALL REGIONS ACTIVE',
                    style: theme.typography.label.copyWith(
                      color: theme.colors.slateGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PrimeCareButton(
          label: 'System Re-Index',
          icon: LucideIcons.refreshCcw,
          type: PrimeCareButtonType.secondary,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDesktopGrid(
    BuildContext context,
    PrimeCareThemeData theme,
    CtoDashboardViewModel vm,
  ) {
    return Column(
      children: [
        // Top Row: Briefing & Quick KPIs
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10, // 10/16 Columns
              child: CtoBriefingPanel(insights: vm.insights),
            ),
            SizedBox(width: theme.spacing.xl),
            Expanded(
              flex: 6, // 6/16 Columns
              child: Column(
                children: [
                  SystemHealthCard(
                    label: 'Core API Latency',
                    value: 42,
                    unit: 'ms',
                    icon: LucideIcons.zap,
                    color: const Color(0xFF00FFCC),
                  ),
                  SizedBox(height: theme.spacing.lg),
                  SystemHealthCard(
                    label: 'DB Thread Pool',
                    value: 12,
                    unit: '%',
                    icon: LucideIcons.database,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xl),
        
        // Bottom Row: System Health Details & Audit
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8, // 8/16 Columns
              child: SizedBox(
                height: 400,
                child: SecurityAuditLog(activities: vm.metrics.recentActivity),
              ),
            ),
            SizedBox(width: theme.spacing.xl),
            Expanded(
              flex: 8, // 8/16 Columns
              child: SizedBox(
                height: 400,
                child: PrimeCareCard(
                  padding: EdgeInsets.all(theme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ARCHITECTURAL LOAD', style: theme.typography.label),
                      const Spacer(),
                      const Center(child: Text('Load Distribution Graph Placeholder')),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileStack(
    BuildContext context,
    PrimeCareThemeData theme,
    CtoDashboardViewModel vm,
  ) {
    return Column(
      children: [
        CtoBriefingPanel(insights: vm.insights),
        SizedBox(height: theme.spacing.lg),
        SystemHealthCard(
          label: 'Core API Latency',
          value: 42,
          unit: 'ms',
          icon: LucideIcons.zap,
        ),
        SizedBox(height: theme.spacing.lg),
        SizedBox(
          height: 300,
          child: SecurityAuditLog(activities: vm.metrics.recentActivity),
        ),
      ],
    );
  }
}
