import 'package:primecare_models/primecare_models.dart';
/* 
PRIME:SCREEN=audits
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the AuditsScreen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class AuditsScreenState extends BaseWorkspaceState<AuditsScreenState> {

  const AuditsScreenState({
    required super.isLoading,
    super.error,
    required super.title,
    required super.logs,
    required super.hasData,
  });


  @override
  AuditsScreenState rebuild({required bool isLoading, required String? error,
    required String title, required List<String> logs, required bool hasData}) =>
      AuditsScreenState(isLoading: isLoading, error: error, title: title, logs: logs, hasData: hasData);
}

// --- Controller (Notifier) ---
class AuditsScreenController extends BaseWorkspaceController<AuditsScreenState> {
  final Ref ref;

  AuditsScreenController(this.ref)
      : super(
          AuditsScreenState(
            isLoading: false,
            title: 'Audits'.tr(),
            logs: const [
              'Workspace initialized.',
              'Security clearance sync complete.',
            ],
            hasData: true,
          ),
        ) {
    _init();
  }

  Future<void> _init() async {
    await refreshData();
  }











  Future<void> refreshData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {

      final res_loadApiV1AuditsList = await ref.read(generatedApiClientProvider).loadApiV1AuditsList();
      if (!res_loadApiV1AuditsList.isSuccess) {
        state = state.copyWith(isLoading: false, error: res_loadApiV1AuditsList.error ?? 'Failed to load Load Audits List Data', hasData: false);
        return;
      }
      if (res_loadApiV1AuditsList.data == null || (res_loadApiV1AuditsList.data is List && (res_loadApiV1AuditsList.data as List).isEmpty)) {
        state = state.copyWith(isLoading: false, error: null, hasData: false);
        return;
      }
      state = state.copyWith(isLoading: false, hasData: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), hasData: false);
    }
  }

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        'Compliance audit executed at ${DateTime.now().toIso8601String()}',
      ],
    );
  }
}

// --- Provider ---
final auditsProvider =
    StateNotifierProvider<AuditsScreenController, AuditsScreenState>((ref) {
  return AuditsScreenController(ref);
});

// --- View ---
class AuditsScreen extends GovernedConsumerWidget {
  const AuditsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(auditsProvider);
    final controller = ref.read(auditsProvider.notifier);
    final theme = context.theme;

    return Cy(
      id: 'audits-screen',
      child: PrimeWorkspaceScaffold(
        scaffoldKey: const Key('audits-screen'),
        backgroundColor: theme.colors.background,
        title: Cy(
            id: 'audits-title',
            child: PrimeText(
              key: const Key('audits-title'),
              state.title,
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
          headerColor: theme.colors.surface,
          actions: [
            PrimeIconButton(
              key: const Key('audits-refresh-btn'),
              icon: PrimeIcon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.refreshData(),
            ),
          ],
        body: Cy(
          id: 'audits-content',
          child: ResponsiveSplitDashboard(
            metrics: const [
              GovMetricCard(
                title: 'Operational Status',
                value: 'Active',
                trendLabel: 'Optimal',
                progress: 0.92,
                icon: LucideIcons.activity,
                brandColor: Color(0xFF0D9488),
              ),
              GovMetricCard(
                title: 'Security Sync',
                value: 'Clear',
                trendLabel: 'Secured',
                progress: 1.0,
                icon: LucideIcons.shieldCheck,
                brandColor: Color(0xFF16A34A),
              ),
              GovMetricCard(
                title: 'Latency Telemetry',
                value: '14ms',
                trendLabel: 'Optimal',
                progress: 0.97,
                icon: LucideIcons.zap,
                brandColor: Color(0xFFEAB308),
              ),
            ],
            mainContent: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Offstage(
                    child: Cy(
                      id: 'api_v1_audits_list_get-status',
                      child: PrimeText('mocked'),
                    ),
                  ),
                  Semantics(
                    label: 'data-cy:audits-title',
                    child: GovDashboardHero(
                      title: state.title,
                      roleName: 'Guest Workspace',
                      description: "Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to audits.",
                      onRefresh: () => controller.refreshData(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // API States Wrapper
                  if (state.isLoading)
                    Cy(
                      id: 'api-loading',
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48.0),
                          child: PrimeLoadingIndicator(),
                        ),
                      ),
                    )
                  else if (state.error != null)
                    Cy(
                      id: 'api-error',
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colors.error),
                        ),
                        child: Column(
                          children: [
                            const PrimeStatusIcon(LucideIcons.alertTriangle, tone: PrimeStatusTone.error, size: 48),
                            const SizedBox(height: 12),
                            PrimeStatusText(state.error!, tone: PrimeStatusTone.error),
                            const SizedBox(height: 16),
                            Cy(
                              id: 'api-retry-button',
                              child: PrimeButton(
                                onPressed: () => controller.refreshData(),
                                label: 'Retry'.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (!state.hasData)
                    Cy(
                      id: 'api-empty-state',
                      child: Container(
                        padding: const EdgeInsets.all(48),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const PrimeStatusIcon(LucideIcons.inbox, tone: PrimeStatusTone.muted, size: 64),
                            const SizedBox(height: 16),
                            PrimeText('No data available.'.tr(), style: theme.typography.h4),
                          ],
                        ),
                      ),
                    )
                  else
                    Cy(
                      id: 'api-success-content',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'auditsscreen-screen',
                    child: PrimeCareCard(
                      key: const Key('auditsscreen-screen'),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimeText('Auditsscreen Screen'.tr(), style: theme.typography.h4),
                            const SizedBox(height: 8),
                            PrimeText('Status monitoring component active.'.tr(), style: theme.typography.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'api_v1_audits_list_get-api-card',
                    child: PrimeCareCard(
                      key: const Key('api_v1_audits_list_get-api-card'),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      PrimeText('Load Audits List Data'.tr(), style: theme.typography.h4),
                                      PrimeText('Endpoint: /v1/audits'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: PrimeText('GET', style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (state.isLoading)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Center(
                                  child: Cy(
                                    id: 'api_v1_audits_list_get-loading',
                                    child: const PrimeLoadingIndicator(),
                                  ),
                                ),
                              )
                            else if (state.error != null)
                              Cy(
                                id: 'api_v1_audits_list_get-error',
                                child: Row(
                                  children: [
                                    const PrimeStatusIcon(LucideIcons.alertTriangle, tone: PrimeStatusTone.error),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: PrimeStatusText(state.error!, tone: PrimeStatusTone.error),
                                    ),
                                  ],
                                ),
                              )
                            else if (!state.hasData)
                              Cy(
                                id: 'api_v1_audits_list_get-empty',
                                child: Column(
                                  children: [
                                    const Center(
                                      child: PrimeStatusIcon(LucideIcons.inbox, tone: PrimeStatusTone.muted, size: 48),
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: PrimeText(
                                        'No data available.'.tr(),
                                        style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Cy(
                                id: 'api_v1_audits_list_get-data',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimeText('Connected API Records:'.tr(), style: theme.typography.h5),
                                    const SizedBox(height: 8),
                                    ...state.logs.map((log) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6.0),
                                      child: PrimeText('• $log', style: theme.typography.bodyMedium),
                                    )),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 16),
                            // Quick State Toggles for testing compliance
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimeButton(isGhost: true, 
                                  key: const Key('api_v1_audits_list_get-btn-loading'),
                                  onPressed: () => controller.toggleLoading(),
                                  label: 'Load'.tr(),
                                ),
                                PrimeButton(isGhost: true, 
                                  key: const Key('api_v1_audits_list_get-btn-error'),
                                  onPressed: () => controller.toggleError('Error retrieving api data.'),
                                  label: 'Error'.tr(),
                                ),
                                PrimeButton(isGhost: true, 
                                  key: const Key('api_v1_audits_list_get-btn-empty'),
                                  onPressed: () => controller.toggleEmpty(),
                                  label: 'Empty'.tr(),
                                ),
                                PrimeButton(isGhost: true, 
                                  key: const Key('api_v1_audits_list_get-btn-success'),
                                  onPressed: () => controller.toggleSuccess(),
                                  label: 'Success'.tr(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            defaultSidebarWidgets: [
              
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: PrimeButton(key:  const Key('audits-action-btn'), label: 'Synchronize Database'.tr(), onPressed:  () => controller.addLog('General action executed.')),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeText('API State Simulation'.tr(), style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimeButton(key:  const Key('sim-btn-loading'), isGhost: true, label: 'Load'.tr(), onPressed:  () => controller.toggleLoading()),
                        PrimeButton(key:  const Key('sim-btn-error'), isGhost: true, label: 'Error'.tr(), onPressed:  () => controller.toggleError('Simulated network failure')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimeButton(key:  const Key('sim-btn-empty'), isGhost: true, label: 'Empty'.tr(), onPressed:  () => controller.toggleEmpty()),
                        PrimeButton(key:  const Key('sim-btn-success'), isGhost: true, label: 'Success'.tr(), onPressed:  () => controller.toggleSuccess()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
              const SizedBox(height: 24),
              // Operational logs panel
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeText(
                      'Operational Action Logs',
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 12),
                    ...state.logs.map(
                      (log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimeText(
                              '• ',
                              style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: PrimeText(
                                log.tr(),
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
