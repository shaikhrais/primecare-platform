import 'package:primecare_ui/primecare_ui.dart';
import 'patient_dashboard_controller.dart';
import 'patient_dashboard_model.dart';

class PatientDashboardView extends ConsumerWidget {
  const PatientDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(patientDashboardAdapterProvider);
    final controller = PatientDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          error: (e, st) => DashboardErrorWidget(
            message: 'Patient Error: $e',
            onRetry: controller.refresh,
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: controller.refresh,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    PatientDashboardViewModel vm,
    PatientDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient Command Center', style: theme.typography.h2),
                  Text(
                    'Personal wellness and care plan overview',
                    style: theme.typography.bodyLarge,
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          const PatientActionHub(),
          SizedBox(height: theme.spacing.xl),
          const CarePlanProgressGrid(),
        ],
      ),
    );
  }
}

class CarePlanProgressGrid extends StatelessWidget {
  const CarePlanProgressGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Care Plan Progress', style: theme.typography.h3),
          Text(
            'Real-time tracking of wellness goals and clinical milestones',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Goal', 'Milestone', 'Progress', 'Status'],
            rows: [
              _buildRow('Mobility', 'Daily Walk', '80%', 'SUCCESS'),
              _buildRow('Nutrition', 'Diet Compliance', '100%', 'SUCCESS'),
              _buildRow('Hydration', 'Fluids Target', '65%', 'INFO'),
              _buildRow('Medication', 'Daily Regimen', '100%', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String goal,
    String milestone,
    String progress,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(goal)),
        DataCell(Text(milestone)),
        DataCell(
          Text(progress, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

class PatientActionHub extends StatelessWidget {
  const PatientActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_request_meds.tr(),
          icon: LucideIcons.pill,
          route: '/patient/meds/request',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_message_nurse.tr(),
          icon: LucideIcons.messageSquare,
          route: '/patient/messages',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_care_plan.tr(),
          icon: LucideIcons.fileText,
          route: '/patient/care-plan',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_vitals_log.tr(),
          icon: LucideIcons.activity,
          route: '/patient/vitals',
        ),
      ],
    );
  }
}

class PatientDashboardIntent extends PrimeCareScreen {
  PatientDashboardIntent() : super(title: "PatientDashboard");

  @override
  Widget build(BuildContext context) => const PatientDashboardView();
}


