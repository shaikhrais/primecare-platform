
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';
import '../providers/03_D_providers.dart';

class TrainingCoordinatorDashboardScreen extends ConsumerWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = PrimeCareTheme.of(context);
    final state = ref.watch(trainingCoordinatorDashboardProvider);

    return state.when(
      loading: () => const Center(child: DashboardLoadingWidget()),
      error: (error, _) => Center(child: DashboardErrorWidget(message: error.toString())),
      data: (metrics) => SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClinicalGlassPanel(
              title: 'Training Coordinator Dashboard',
              headerTrailing: ClinicalGlassButton(
                onPressed: () {},
                label: 'Coordination Mode',
                variant: ClinicalButtonVariant.outline,
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.md),
                child: Text(
                  'Manage curriculum and coordinate training sessions',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray),
                ),
              ),
            ),
            SizedBox(height: theme.spacing.xl),
            _buildHighFidelityGrid(context, metrics.metrics),
            SizedBox(height: theme.spacing.xl),
            _buildActivitySection(context, metrics.metrics),
          ],
        ),
      ),
    );
  }

  Widget _buildHighFidelityGrid(BuildContext context, DashboardMetrics metrics) {
    return PrimeCareResponsiveKpiGrid(
      children: metrics.kpis.map((kpi) {
        return PrimeCareKpiCard(
          title: kpi.title,
          value: kpi.value,
          subtitle: kpi.subtitle ?? 'Active session',
          icon: LucideIcons.bookOpen,
          onPinToggle: () {},
        );
      }).toList(),
    );
  }

  Widget _buildActivitySection(BuildContext context, DashboardMetrics metrics) {
    final theme = PrimeCareTheme.of(context);
    return ClinicalGlassPanel(
      title: 'Coordination Overview',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: metrics.kpis.map((kpi) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
            child: Row(
              children: [
                Text(kpi.title, style: theme.typography.bodyMedium),
                const Spacer(),
                Text(kpi.value, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
