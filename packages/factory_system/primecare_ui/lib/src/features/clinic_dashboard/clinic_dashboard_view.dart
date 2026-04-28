// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ClinicDashboardView extends ConsumerWidget {
  const ClinicDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicDashboardAdapterProvider);
    final controller = ClinicDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          (e) => DashboardErrorWidget(
            message: 'Clinic Error: $e',
            onRetry: () => ref.refresh(clinicalFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clinicalFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ClinicDashboardModel vm,
    ClinicDashboardController controller,
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
                  Text('Clinic Command Center', style: theme.typography.h2),
                  Text(
                    'Clinical outcomes and patient care overview',
                    style: theme.typography.bodyLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  PrimeCareButton(
                    onPressed: () => _showIntake(context),
                    text: 'New Intake',
                    icon: Icons.person_add_rounded,
                  ),
                  const SizedBox(width: 8),
                  PrimeCareButton(
                    onPressed: () => _showVitalsCapture(context),
                    text: 'Capture Vitals',
                    icon: Icons.favorite_rounded,
                    isPrimary: true,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: controller.refresh,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Operational Insights', style: theme.typography.h4),
                SizedBox(height: theme.spacing.md),
                const Divider(),
                if (vm.recentActivity.isEmpty)
                  const Center(child: Text('No recent activity'))
                else
                  ...vm.recentActivity.map(
                    (activity) => ListTile(
                      leading: Icon(
                        _getIconData(activity.icon),
                        color: _getColor(activity.color, theme),
                      ),
                      title: Text(activity.title),
                      subtitle: Text(activity.subtitle),
                      trailing: Text(activity.timestamp),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showIntake(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 900),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: PatientIntakeForm(
              onSuccess: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  void _showVitalsCapture(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: VitalsCaptureForm(
              onSuccess: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String? icon) {
    switch (icon) {
      case 'check_circle':
        return Icons.check_circle;
      case 'verified':
        return Icons.verified;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Color _getColor(String? color, PrimeCareThemeData theme) {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return theme.colors.textSecondary;
    }
  }
}

class ClinicDashboardIntent extends PrimeCareScreen {
  ClinicDashboardIntent() : super(title: 'ClinicDashboard');

  @override
  Widget build(BuildContext context) => const ClinicDashboardView();
}

class PatientIntakeForm extends StatelessWidget {
  final VoidCallback onSuccess;
  const PatientIntakeForm({required this.onSuccess, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PrimeCareTextField(
          label: 'Full Name',
          placeholder: 'Enter patient name',
        ),
        const SizedBox(height: 16),
        const PrimeCareTextField(
          label: 'Reason for Visit',
          placeholder: 'Enter reason',
        ),
        const SizedBox(height: 24),
        PrimeCareButton(onPressed: onSuccess, label: 'Submit Intake'),
      ],
    );
  }
}

class VitalsCaptureForm extends StatelessWidget {
  final VoidCallback onSuccess;
  const VitalsCaptureForm({required this.onSuccess, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PrimeCareTextField(
          label: 'Blood Pressure',
          placeholder: '120/80',
        ),
        const SizedBox(height: 16),
        const PrimeCareTextField(label: 'Temperature', placeholder: '36.6'),
        const SizedBox(height: 24),
        PrimeCareButton(onPressed: onSuccess, label: 'Save Vitals'),
      ],
    );
  }
}
