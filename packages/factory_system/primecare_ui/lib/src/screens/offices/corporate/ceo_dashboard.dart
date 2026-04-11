import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart' hide billingAdminDashboardAdapterProvider, billingAdminDashboardDataProvider, ceoDashboardAdapterProvider, ceoDashboardDataProvider, cfoDashboardAdapterProvider, cfoDashboardDataProvider, clientDashboardAdapterProvider, clientDashboardDataProvider, clinicDashboardAdapterProvider, clinicDashboardDataProvider, communityOutreachDashboardAdapterProvider, communityOutreachDashboardDataProvider, complianceManagerDashboardAdapterProvider, complianceManagerDashboardDataProvider, cooDashboardAdapterProvider, cooDashboardDataProvider, ctoDashboardAdapterProvider, ctoDashboardDataProvider, customerSupportDashboardAdapterProvider, customerSupportDashboardDataProvider, familyDashboardAdapterProvider, familyDashboardDataProvider, franchiseOwnerDashboardAdapterProvider, franchiseOwnerDashboardDataProvider, franchiseSalesManagerDashboardAdapterProvider, franchiseSalesManagerDashboardDataProvider, generalManagerDashboardAdapterProvider, generalManagerDashboardDataProvider, guestDashboardAdapterProvider, guestDashboardDataProvider, headOfBusDevDashboardAdapterProvider, headOfBusDevDashboardDataProvider, headOfMarketingDashboardAdapterProvider, headOfMarketingDashboardDataProvider, hrHiringDashboardAdapterProvider, hrHiringDashboardDataProvider, intakeDashboardAdapterProvider, intakeDashboardDataProvider, localMarketingManagerDashboardAdapterProvider, localMarketingManagerDashboardDataProvider, operationsManagerDashboardAdapterProvider, operationsManagerDashboardDataProvider, ownerDashboardAdapterProvider, ownerDashboardDataProvider, partnershipManagerDashboardAdapterProvider, partnershipManagerDashboardDataProvider, patientDashboardAdapterProvider, patientDashboardDataProvider, qaDashboardAdapterProvider, qaDashboardDataProvider, regionalManagerOntarioDashboardAdapterProvider, regionalManagerOntarioDashboardDataProvider, regionalManagerUsaDashboardAdapterProvider, regionalManagerUsaDashboardDataProvider, schedulerDashboardAdapterProvider, schedulerDashboardDataProvider, scrumMasterDashboardAdapterProvider, scrumMasterDashboardDataProvider, supportDashboardAdapterProvider, supportDashboardDataProvider, territoryExpansionManagerDashboardAdapterProvider, territoryExpansionManagerDashboardDataProvider, territorySalesManagerDashboardAdapterProvider, territorySalesManagerDashboardDataProvider, trainingCoordinatorDashboardAdapterProvider, trainingCoordinatorDashboardDataProvider, trainingDirectorDashboardAdapterProvider, trainingDirectorDashboardDataProvider;
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CeoDashboard extends ConsumerWidget {
  const CeoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(ceoDashboardDataProvider('ceo'));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ceo Dashboard'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            metricsAsyncValue.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(64.0),
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                ),
              ),
              error: (error, stackTrace) => Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent.withAlpha(76)),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.alertTriangle, color: Colors.redAccent),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Failed to load metrics: \n$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (CeoDashboardViewModel liveData) {
                return AssemblyLine(
                  blueprints: liveData.blueprints,
                  isOfflineFallback: liveData.isOfflineFallback,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
