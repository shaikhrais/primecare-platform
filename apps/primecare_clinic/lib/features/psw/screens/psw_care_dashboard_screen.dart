// Governance - Category: view | Purpose: UI Screen component rendering the Psw Care Dashboard workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswCareDashboardState {
  final String status;
  final int criticalAlerts;

  const PswCareDashboardState({
    required this.status,
    required this.criticalAlerts,
  });
}

// --- Controller ---
class PswCareDashboardController extends StateNotifier<PswCareDashboardState> {
  final Ref _ref;
  PswCareDashboardController(this._ref)
      : super(const PswCareDashboardState(status: 'idle', criticalAlerts: 1));

  void updatePatientRecord() {
    print('Governance action: updatePatientRecord executed.');
  }

  void generateReport() {
    print('Governance action: generateReport executed.');
  }

  void collaborateWithTeam() {
    print('Governance action: collaborateWithTeam executed.');
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
        route: '/psw/care/dashboard',
        eventType: 'collaborate',
        metadata: {'action': 'chat_opened'},
      );
    } catch (_) {}
  }
}

final pswCareDashboardControllerProvider = StateNotifierProvider<PswCareDashboardController, PswCareDashboardState>((ref) {
  return PswCareDashboardController(ref);
});

// --- View ---
class PswCareDashboardScreen extends GovernedConsumerWidget {
  const PswCareDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswCareDashboardControllerProvider);
    final controller = ref.read(pswCareDashboardControllerProvider.notifier);

    return Semantics(
      label: 'data-cy:psw-dashboard-btn-update-record',
      container: true,
      child: Scaffold(
        key: const Key('psw-dashboard-btn-update-record'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Clinical Care Dashboard',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswcaredashboard-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswcaredashboard-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics overview split layout
                ResponsiveSplitDashboard(
                  metrics: [
                    GovMetricCard(
                      title: 'Active Clients',
                      value: '3 Patients',
                      trendLabel: 'In progress',
                      progress: 0.75,
                      icon: LucideIcons.user,
                      brandColor: theme.colors.primary,
                    ),
                    const GovMetricCard(
                      title: 'Medication Adherence',
                      value: '100%',
                      trendLabel: 'Optimal',
                      progress: 1.0,
                      icon: LucideIcons.shieldCheck,
                      brandColor: Colors.green,
                    ),
                  ],
                  mainContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active Action Cards
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              key: const Key('psw-dashboard-btn-collaborate'),
                              onPressed: () => controller.collaborateWithTeam(),
                              child: const Text('Collaborate'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              key: const Key('psw-dashboard-btn-generate-report'),
                              onPressed: () => controller.generateReport(),
                              child: const Text('Generate Report'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
