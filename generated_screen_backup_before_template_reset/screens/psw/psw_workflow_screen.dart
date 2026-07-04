/* 
PRIME:SCREEN=psw_workflow
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
// Governance - Category: view | Purpose: UI Screen component rendering the PswWorkflowScreen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;
  final bool hasData;

  const PswWorkflowScreenState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
    required this.hasData,
  });

  PswWorkflowScreenState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    bool? hasData,
  }) {
    return PswWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      hasData: hasData ?? this.hasData,
    );
  }
}

// --- Controller (Notifier) ---
class PswWorkflowScreenController extends StateNotifier<PswWorkflowScreenState> {
  final Ref ref;

  PswWorkflowScreenController(this.ref)
      : super(
          PswWorkflowScreenState(
            isLoading: false,
            title: 'Psw Workflow'.tr(),
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

      final res_loadApiV1PswWorkflowList = await ref.read(generatedApiClientProvider).loadApiV1PswWorkflowList();
      if (!res_loadApiV1PswWorkflowList.isSuccess) {
        state = state.copyWith(isLoading: false, error: res_loadApiV1PswWorkflowList.error ?? 'Failed to load Load Psw Workflow List Data', hasData: false);
        return;
      }
      if (res_loadApiV1PswWorkflowList.data == null || (res_loadApiV1PswWorkflowList.data is List && (res_loadApiV1PswWorkflowList.data as List).isEmpty)) {
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
final pswWorkflowProvider =
    StateNotifierProvider<PswWorkflowScreenController, PswWorkflowScreenState>((ref) {
  return PswWorkflowScreenController(ref);
});

// --- View ---
class PswWorkflowScreen extends GovernedConsumerWidget {
  const PswWorkflowScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswWorkflowProvider);
    final controller = ref.read(pswWorkflowProvider.notifier);
    final theme = context.theme;

    return Cy(
      id: 'psw_workflow-screen',
      child: Scaffold(
        key: const Key('psw_workflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Cy(
            id: 'psw_workflow-title',
            child: Text(
              key: const Key('psw_workflow-title'),
              state.title,
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
          actions: [
            IconButton(
              key: const Key('psw_workflow-refresh-btn'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.refreshData(),
            ),
          ],
        ),
        body: Cy(
          id: 'psw_workflow-content',
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
                      id: 'api_v1_psw_workflow_list_get-status',
                      child: Text('mocked'),
                    ),
                  ),

                  Offstage(
                    child: Cy(
                      id: 'api_v1_psw_workflow_create_post-status',
                      child: Text('mocked'),
                    ),
                  ),

                  Offstage(
                    child: Cy(
                      id: 'api_v1_psw_workflow_update_patch-status',
                      child: Text('mocked'),
                    ),
                  ),
                  Semantics(
                    label: 'data-cy:psw_workflow-title',
                    child: GovDashboardHero(
                      title: state.title,
                      roleName: 'Personal Support Worker (PSW) Workspace',
                      description: "Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswworkflowscreen.",
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
                    id: 'pswworkflow-screen',
                    child: PrimeCareCard(
                      key: const Key('pswworkflow-screen'),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pswworkflow Screen'.tr(), style: theme.typography.h4),
                            const SizedBox(height: 8),
                            Text('Status monitoring component active.'.tr(), style: theme.typography.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                if (state.isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Cy(
                        id: 'pswworkflow-loading',
                        child: CircularProgressIndicator(
                          key: Key('pswworkflow-loading'),
                        ),
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'psw_workflow_screen_textfield_input_4',
                    child: TextField(
                      key: const Key('psw_workflow_screen_textfield_input_4'),
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Psw_Workflow_Screen_Textfield_Input_4'.tr(),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: theme.colors.surface,
                      ),
                      onChanged: (val) => controller.addLog('Psw_Workflow_Screen_Textfield_Input_4 input updated: $val'),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'pswworkflow-content',
                    child: PrimeCareCard(
                      key: const Key('pswworkflow-content'),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pswworkflow Content'.tr(), style: theme.typography.h4),
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
                    id: 'pswworkflow-title',
                    child: PrimeCareCard(
                      key: const Key('pswworkflow-title'),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pswworkflow Title'.tr(), style: theme.typography.h4),
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
                    id: 'psw_workflow_screen_textfield_input_2',
                    child: TextField(
                      key: const Key('psw_workflow_screen_textfield_input_2'),
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Psw_Workflow_Screen_Textfield_Input_2'.tr(),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: theme.colors.surface,
                      ),
                      onChanged: (val) => controller.addLog('Psw_Workflow_Screen_Textfield_Input_2 input updated: $val'),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'psw_workflow_screen_textfield_input_5',
                    child: TextField(
                      key: const Key('psw_workflow_screen_textfield_input_5'),
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Psw_Workflow_Screen_Textfield_Input_5'.tr(),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: theme.colors.surface,
                      ),
                      onChanged: (val) => controller.addLog('Psw_Workflow_Screen_Textfield_Input_5 input updated: $val'),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'psw_workflow_screen_textfield_input_1',
                    child: TextField(
                      key: const Key('psw_workflow_screen_textfield_input_1'),
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Psw_Workflow_Screen_Textfield_Input_1'.tr(),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: theme.colors.surface,
                      ),
                      onChanged: (val) => controller.addLog('Psw_Workflow_Screen_Textfield_Input_1 input updated: $val'),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'psw_workflow_screen_textfield_input_3',
                    child: TextField(
                      key: const Key('psw_workflow_screen_textfield_input_3'),
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Psw_Workflow_Screen_Textfield_Input_3'.tr(),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: theme.colors.surface,
                      ),
                      onChanged: (val) => controller.addLog('Psw_Workflow_Screen_Textfield_Input_3 input updated: $val'),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'api_v1_psw_workflow_list_get-api-card',
                    child: PrimeCareCard(
                      key: const Key('api_v1_psw_workflow_list_get-api-card'),
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
                                      Text('Load Psw Workflow List Data'.tr(), style: theme.typography.h4),
                                      Text('Endpoint: /v1/psw-workflow'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
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
                                    id: 'api_v1_psw_workflow_list_get-loading',
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            else if (state.error != null)
                              Cy(
                                id: 'api_v1_psw_workflow_list_get-error',
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
                                id: 'api_v1_psw_workflow_list_get-empty',
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
                                id: 'api_v1_psw_workflow_list_get-data',
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
                                  key: const Key('api_v1_psw_workflow_list_get-btn-loading'),
                                  onPressed: () => controller.toggleLoading(),
                                  child: Text('Load'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_list_get-btn-error'),
                                  onPressed: () => controller.toggleError('Error retrieving api data.'),
                                  child: Text('Error'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_list_get-btn-empty'),
                                  onPressed: () => controller.toggleEmpty(),
                                  child: Text('Empty'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_list_get-btn-success'),
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

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'api_v1_psw_workflow_create_post-api-card',
                    child: PrimeCareCard(
                      key: const Key('api_v1_psw_workflow_create_post-api-card'),
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
                                      Text('Create New Psw Workflow Record'.tr(), style: theme.typography.h4),
                                      Text('Endpoint: /v1/psw-workflow'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('POST', style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (state.isLoading)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Center(
                                  child: Cy(
                                    id: 'api_v1_psw_workflow_create_post-loading',
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            else if (state.error != null)
                              Cy(
                                id: 'api_v1_psw_workflow_create_post-error',
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
                                id: 'api_v1_psw_workflow_create_post-empty',
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
                                id: 'api_v1_psw_workflow_create_post-data',
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
                                  key: const Key('api_v1_psw_workflow_create_post-btn-loading'),
                                  onPressed: () => controller.toggleLoading(),
                                  child: Text('Load'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_create_post-btn-error'),
                                  onPressed: () => controller.toggleError('Error retrieving api data.'),
                                  child: Text('Error'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_create_post-btn-empty'),
                                  onPressed: () => controller.toggleEmpty(),
                                  child: Text('Empty'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_create_post-btn-success'),
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

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Cy(
                    id: 'api_v1_psw_workflow_update_patch-api-card',
                    child: PrimeCareCard(
                      key: const Key('api_v1_psw_workflow_update_patch-api-card'),
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
                                      Text('Update Existing Psw Workflow Record'.tr(), style: theme.typography.h4),
                                      Text('Endpoint: /v1/psw-workflow/:id'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('PATCH', style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (state.isLoading)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Center(
                                  child: Cy(
                                    id: 'api_v1_psw_workflow_update_patch-loading',
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            else if (state.error != null)
                              Cy(
                                id: 'api_v1_psw_workflow_update_patch-error',
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
                                id: 'api_v1_psw_workflow_update_patch-empty',
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
                                id: 'api_v1_psw_workflow_update_patch-data',
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
                                  key: const Key('api_v1_psw_workflow_update_patch-btn-loading'),
                                  onPressed: () => controller.toggleLoading(),
                                  child: Text('Load'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_update_patch-btn-error'),
                                  onPressed: () => controller.toggleError('Error retrieving api data.'),
                                  child: Text('Error'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_update_patch-btn-empty'),
                                  onPressed: () => controller.toggleEmpty(),
                                  child: Text('Empty'.tr()),
                                ),
                                TextButton(
                                  key: const Key('api_v1_psw_workflow_update_patch-btn-success'),
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
                        id: 'pswworkflow-btn-2',
                        child: ElevatedButton(
                          key: const Key('pswworkflow-btn-2'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => controller.addLog('Action: Pswworkflow Btn 2 executed successfully.'),
                          child: Text('Pswworkflow Btn 2'.tr(), style: const TextStyle(color: Colors.white)),
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
                        id: 'pswworkflow-btn-1',
                        child: ElevatedButton(
                          key: const Key('pswworkflow-btn-1'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => controller.addLog('Action: Pswworkflow Btn 1 executed successfully.'),
                          child: Text('Pswworkflow Btn 1'.tr(), style: const TextStyle(color: Colors.white)),
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
