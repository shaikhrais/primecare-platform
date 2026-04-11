import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_adapters/primecare_adapters.dart' hide billingAdminDashboardAdapterProvider, billingAdminDashboardDataProvider, ceoDashboardAdapterProvider, ceoDashboardDataProvider, cfoDashboardAdapterProvider, cfoDashboardDataProvider, clientDashboardAdapterProvider, clientDashboardDataProvider, clinicDashboardAdapterProvider, clinicDashboardDataProvider, communityOutreachDashboardAdapterProvider, communityOutreachDashboardDataProvider, complianceManagerDashboardAdapterProvider, complianceManagerDashboardDataProvider, cooDashboardAdapterProvider, cooDashboardDataProvider, ctoDashboardAdapterProvider, ctoDashboardDataProvider, customerSupportDashboardAdapterProvider, customerSupportDashboardDataProvider, familyDashboardAdapterProvider, familyDashboardDataProvider, franchiseOwnerDashboardAdapterProvider, franchiseOwnerDashboardDataProvider, franchiseSalesManagerDashboardAdapterProvider, franchiseSalesManagerDashboardDataProvider, generalManagerDashboardAdapterProvider, generalManagerDashboardDataProvider, guestDashboardAdapterProvider, guestDashboardDataProvider, headOfBusDevDashboardAdapterProvider, headOfBusDevDashboardDataProvider, headOfMarketingDashboardAdapterProvider, headOfMarketingDashboardDataProvider, hrHiringDashboardAdapterProvider, hrHiringDashboardDataProvider, intakeDashboardAdapterProvider, intakeDashboardDataProvider, localMarketingManagerDashboardAdapterProvider, localMarketingManagerDashboardDataProvider, operationsManagerDashboardAdapterProvider, operationsManagerDashboardDataProvider, ownerDashboardAdapterProvider, ownerDashboardDataProvider, partnershipManagerDashboardAdapterProvider, partnershipManagerDashboardDataProvider, patientDashboardAdapterProvider, patientDashboardDataProvider, qaDashboardAdapterProvider, qaDashboardDataProvider, regionalManagerOntarioDashboardAdapterProvider, regionalManagerOntarioDashboardDataProvider, regionalManagerUsaDashboardAdapterProvider, regionalManagerUsaDashboardDataProvider, schedulerDashboardAdapterProvider, schedulerDashboardDataProvider, scrumMasterDashboardAdapterProvider, scrumMasterDashboardDataProvider, supportDashboardAdapterProvider, supportDashboardDataProvider, territoryExpansionManagerDashboardAdapterProvider, territoryExpansionManagerDashboardDataProvider, territorySalesManagerDashboardAdapterProvider, territorySalesManagerDashboardDataProvider, trainingCoordinatorDashboardAdapterProvider, trainingCoordinatorDashboardDataProvider, trainingDirectorDashboardAdapterProvider, trainingDirectorDashboardDataProvider;
import 'package:primecare_ui/src/components/page_template.dart';

import 'sections/operations_manager_kpi_section.dart';

class OperationsManagerDashboardScreen extends ConsumerWidget {
  const OperationsManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(
      operationsManagerDashboardAdapterProvider,
    );

    return PageTemplate(
      title: 'Operations Manager Dashboard',
      subtitle: 'Real-time overview fetched natively via API.',
      kpiCards: metricsAsyncValue.when(
        loading: () => [
          const Center(
            child: CircularProgressIndicator(color: Colors.tealAccent),
          ),
        ],
        error: (error, stackTrace) => [
          Container(
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
                    'Failed to load live metrics: \n$error',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
        data: (liveData) => OperationsManagerKpiSection.buildCards(liveData),
      ),
      bodySections: const [
        // Advanced components (Charts, Maps, Grids) go here based on role
      ],
    );
  }
}
