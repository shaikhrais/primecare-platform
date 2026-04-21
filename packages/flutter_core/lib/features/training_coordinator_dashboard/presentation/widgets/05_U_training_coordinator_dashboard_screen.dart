
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';
import '../providers/03_D_providers.dart';

class TrainingCoordinatorDashboardScreen extends ConsumerWidget {
  const TrainingCoordinatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingCoordinatorDashboardProvider);

    return state.when(
      loading: () => const Center(child: DashboardLoadingWidget()),
      error: (error, _) => Center(child: DashboardErrorWidget(message: error.toString())),
      data: (metrics) => SingleChildScrollView(
        padding: const EdgeInsets.all(MetricTokens.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareSectionHeader(
              title: 'Training Coordinator Dashboard',
              subtitle: 'Manage curriculum and coordinate training sessions',
              trailing: Text(
                'Last updated: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                style: const TextStyle(color: PrimeCareColors.slate400),
              ),
            ),
            const SizedBox(height: MetricTokens.spacingL),
            
            _buildHighFidelityGrid(context, metrics),
            
            const SizedBox(height: MetricTokens.spacingL),
            _buildActivitySection(context, metrics),
          ],
        ),
      ),
    );
  }

  Widget _buildHighFidelityGrid(BuildContext context, DashboardMetrics metrics) {
    return PrimeCareResponsiveKpiGrid(
      children: metrics.keyValuePairs.entries.map((MapEntry<String, dynamic> e) {
        return PrimeCareKpiCard(
          title: e.key,
          value: e.value?.toString() ?? '0', // ignore: avoid_dynamic_calls
          subtitle: 'Active coordinated sessions',
          icon: LucideIcons.bookOpen,
          onPinToggle: () <String, dynamic>{},
        );
      }).toList(),
    );
  }

  Widget _buildActivitySection(BuildContext context, DashboardMetrics metrics) {
    return DashboardSection(
      title: 'Coordination Overview',
      child: Column(
        children: itemsFromMetrics(metrics).map((item) => DashboardListItem(item: item)).toList(),
      ),
    );
  }

  List<DashboardItem> itemsFromMetrics(DashboardMetrics metrics) {
    return metrics.keyValuePairs.entries.map((MapEntry<String, dynamic> e) {
      return DashboardItem(
        title: e.key,
        value: e.value?.toString() ?? '0', // ignore: avoid_dynamic_calls
        type: DashboardItemType.info,
      );
    }).toList();
  }
}
