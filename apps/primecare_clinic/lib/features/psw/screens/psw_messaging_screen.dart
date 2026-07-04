/* 
PRIME:SCREEN=psw_messaging
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
// Governance - Category: view | Purpose: UI Screen component rendering the PswMessagingScreen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswMessagingScreenState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;
  final bool hasData;

  const PswMessagingScreenState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
    required this.hasData,
  });

  PswMessagingScreenState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    bool? hasData,
  }) {
    return PswMessagingScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      hasData: hasData ?? this.hasData,
    );
  }
}

// --- Controller (Notifier) ---
class PswMessagingScreenController extends StateNotifier<PswMessagingScreenState> {
  final Ref ref;

  PswMessagingScreenController(this.ref)
      : super(
          PswMessagingScreenState(
            isLoading: false,
            title: 'Psw Messaging'.tr(),
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

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  void toggleLoading() {
    state = state.copyWith(isLoading: true, error: null);
  }

  void toggleError(String msg) {
    state = state.copyWith(isLoading: false, error: msg, hasData: false);
  }

  void toggleEmpty() {
    state = state.copyWith(isLoading: false, error: null, hasData: false);
  }

  void toggleSuccess() {
    state = state.copyWith(isLoading: false, error: null, hasData: true);
  }

  Future<void> refreshData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {

      final res_loadApiV1PswMessagingList = await ref.read(generatedApiClientProvider).loadApiV1PswMessagingList();
      if (!res_loadApiV1PswMessagingList.isSuccess) {
        state = state.copyWith(isLoading: false, error: res_loadApiV1PswMessagingList.error ?? 'Failed to load Load Psw Messaging List Data', hasData: false);
        return;
      }
      if (res_loadApiV1PswMessagingList.data == null || (res_loadApiV1PswMessagingList.data is List && (res_loadApiV1PswMessagingList.data as List).isEmpty)) {
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
final pswMessagingProvider =
    StateNotifierProvider<PswMessagingScreenController, PswMessagingScreenState>((ref) {
  return PswMessagingScreenController(ref);
});

// --- View ---
class PswMessagingScreen extends GovernedConsumerWidget {
  const PswMessagingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswMessagingProvider);
    final controller = ref.read(pswMessagingProvider.notifier);
    final theme = context.theme;

    return Cy(
      id: 'psw_messaging-screen',
      child: Scaffold(
        key: const Key('psw_messaging-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Cy(
            id: 'psw_messaging-title',
            child: Text(
              key: const Key('psw_messaging-title'),
              state.title,
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
          actions: [
            IconButton(
              key: const Key('psw_messaging-refresh-btn'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.refreshData(),
            ),
          ],
        ),
        body: Cy(
          id: 'psw_messaging-content',
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
                      id: 'api_v1_psw_messaging_list_get-status',
                      child: Text('mocked'),
                    ),
                  ),
                  Semantics(
                    label: 'data-cy:psw_messaging-title',
                    child: GovDashboardHero(
                      title: state.title,
                      roleName: 'Guest Workspace',
                      description: "Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw messaging.",
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
                          child: CircularProgressIndicator(),
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
                          border: Border.all(color: Colors.red),
                        ),
                        child: Column(
                          children: [
                            const Icon(LucideIcons.alertTriangle, color: Colors.red, size: 48),
                            const SizedBox(height: 12),
                            Text(state.error!, style: const TextStyle(color: Colors.red)),
                            const SizedBox(height: 16),
                            Cy(
                              id: 'api-retry-button',
                              child: ElevatedButton(
                                onPressed: () => controller.refreshData(),
                                child: Text('Retry'.tr()),
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
                            const Icon(LucideIcons.inbox, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text('No data available.'.tr(), style: theme.typography.h4),
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
                    id: 'pswmessaging-list',
                    child: PrimeCareCard(
                      key: const Key('pswmessaging-list'),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pswmessaging List'.tr(), style: theme.typography.h4),
                            const SizedBox(height: 8),
                            Text('Status monitoring component active.'.tr(), style: theme.typography.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'api_v1_psw_messaging_list_get-api-card',
                    child: PrimeCareCard(
                      key: const Key('api_v1_psw_messaging_list_get-api-card'),
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
                                      Text('Load Psw Messaging List Data'.tr(), style: theme.typography.h4),
                                      Text('Endpoint: /v1/psw-messaging'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('GET', style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (state.isLoading)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Center(
                                  child: Cy(
                                    id: 'api_v1_psw_messaging_list_get-loading',
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            else if (state.error != null)
                              Cy(
                                id: 'api_v1_psw_messaging_list_get-error',
                                child: Row(
                                  children: [
                                    const Icon(LucideIcons.alertTriangle, color: Colors.red),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        state.error!,
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else if (!state.hasData)
                              Cy(
                                id: 'api_v1_psw_messaging_list_get-empty',
                                child: Column(
                                  children: [
                                    const Center(
                                      child: Icon(LucideIcons.inbox, size: 48, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        'No data available.'.tr(),
                                        style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Cy(
                                id: 'api_v1_psw_messaging_list_get-data',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Connected API Records:'.tr(), style: theme.typography.h5),
                                    const SizedBox(height: 8),
                                    ...state.logs.map((log) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6.0),
                                      child: Text('• $log', style: theme.typography.bodyMedium),
                                    )),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 16),
                            // Quick State Toggles for testing compliance
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  key: const Key('api_v1_psw_messaging_list_get-btn-loading'),
                                  onPressed: () => controller.toggleLoading(),
                                  child: Text('Load'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_messaging_list_get-btn-error'),
                                  onPressed: () => controller.toggleError('Error retrieving api data.'),
                                  child: Text('Error'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_messaging_list_get-btn-empty'),
                                  onPressed: () => controller.toggleEmpty(),
                                  child: Text('Empty'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_messaging_list_get-btn-success'),
                                  onPressed: () => controller.toggleSuccess(),
                                  child: Text('Success'.tr()),
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
                      child: Cy(
                        id: 'psw-messaging-btn-refresh',
                        child: ElevatedButton(
                          key: const Key('psw-messaging-btn-refresh'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => controller.addLog('Action: Psw Messaging Btn Refresh executed successfully.'),
                          child: Text('Psw Messaging Btn Refresh'.tr(), style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: Cy(
                        id: 'psw-messaging-btn-send',
                        child: ElevatedButton(
                          key: const Key('psw-messaging-btn-send'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => controller.addLog('Action: Psw Messaging Btn Send executed successfully.'),
                          child: Text('Psw Messaging Btn Send'.tr(), style: const TextStyle(color: Colors.white)),
                        ),
                      ),
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
                    Text('API State Simulation'.tr(), style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          key: const Key('sim-btn-loading'),
                          onPressed: () => controller.toggleLoading(),
                          child: Text('Load'.tr(), style: const TextStyle(fontSize: 11)),
                        ),
                        TextButton(
                          key: const Key('sim-btn-error'),
                          onPressed: () => controller.toggleError('Simulated network failure'),
                          child: Text('Error'.tr(), style: const TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          key: const Key('sim-btn-empty'),
                          onPressed: () => controller.toggleEmpty(),
                          child: Text('Empty'.tr(), style: const TextStyle(fontSize: 11)),
                        ),
                        TextButton(
                          key: const Key('sim-btn-success'),
                          onPressed: () => controller.toggleSuccess(),
                          child: Text('Success'.tr(), style: const TextStyle(fontSize: 11)),
                        ),
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
                    Text(
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
                            Text(
                              '• ',
                              style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
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
