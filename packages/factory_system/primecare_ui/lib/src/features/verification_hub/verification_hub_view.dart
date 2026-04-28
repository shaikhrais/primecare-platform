// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class VerificationHubView extends ConsumerWidget {
  const VerificationHubView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(verificationHubAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_verification_hub.tr(),
      subtitle: 'Verification Status',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(verificationHubAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuraDashboardHud(),
                const SizedBox(height: 24),
                PrimeCareResponsiveKpiGrid(
                  children: data.metrics.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('verify')) return Icons.verified_user_outlined;
    if (t.contains('pending')) return Icons.pending_actions_outlined;
    if (t.contains('reject')) return Icons.gpp_bad_outlined;
    return Icons.fact_check_outlined;
  }
}

class VerificationHubIntent extends PrimeCareScreen {
  VerificationHubIntent() : super(title: 'VerificationHub');

  @override
  Widget build(BuildContext context) => const VerificationHubView();
}
