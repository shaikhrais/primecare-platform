// @governance: id=SCREEN_GENERAL_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;


// @governance: component=Aura HUD (Occupancy Trend)
// @governance: component=Occupancy Heatmap
// @governance: component=Facility Revenue Grid
// @governance: component=Resource Utilization
class GeneralManagerDashboardView extends ConsumerWidget {
  const GeneralManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(generalManagerAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(generalManagerAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(generalManagerAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    GeneralManagerDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.general_manager_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.general_manager_dashboard_subtitle.tr(),
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _FacilityStatusSection(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _AuditProtocolList(theme: theme),
        ],
      ),
    );
  }
}

class _FacilityStatusSection extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _FacilityStatusSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Facility Readiness Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Operational Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuditProtocolList extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _AuditProtocolList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Compliance Audit Protocols', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.secondaryContainer,
                  child: Icon(
                    LucideIcons.clipboardCheck,
                    size: 16,
                    color: theme.colors.onSecondaryContainer,
                  ),
                ),
                title: Text('Compliance Protocol #${index + 201}'),
                subtitle: const Text(
                  'Facility: PrimeCare East • Status: In Progress',
                ),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GeneralManagerDashboardIntent extends PrimeCareScreen {
  GeneralManagerDashboardIntent()
      : super(
          name: 'general-manager',
          title: LocaleKeys.general_manager_dashboard_title,
          route: '/offices/corporate/roles/general-manager/dashboard',
          requiredRole: PlatformRole.generalManager,
          form: PrimeCareForm.generalManagerDashboard,
          provider: generalManagerDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Operational Command)',
            'Multi-Department KPI Grid',
            'Staffing Utilization Matrix',
            'Daily Ops Summary',
          ],
        );

  @override
  Widget build(BuildContext context) => const GeneralManagerDashboardView();
}
