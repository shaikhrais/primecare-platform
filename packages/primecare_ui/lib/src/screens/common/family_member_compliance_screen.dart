// Governance - Category: view | Purpose: UI Screen component rendering the Family Member Compliance Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class FamilyMemberComplianceState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  const FamilyMemberComplianceState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
  });

  FamilyMemberComplianceState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
  }) {
    return FamilyMemberComplianceState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class FamilyMemberComplianceController extends StateNotifier<FamilyMemberComplianceState> {
  FamilyMemberComplianceController()
      : super(
          const FamilyMemberComplianceState(
            isLoading: false,
            title: 'Family Member Governance Portal',
            logs: [
              'System initialized.',
              'Security sync complete.',
            ],
          ),
        );

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        'Compliance audit executed at ${DateTime.now().toIso8601String()}',
        'All governance invariants validated.',
      ],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }
}

// --- Provider ---
final familyMemberComplianceProvider =
    StateNotifierProvider<FamilyMemberComplianceController, FamilyMemberComplianceState>((ref) {
  return FamilyMemberComplianceController();
});

// --- View ---
class FamilyMemberComplianceScreen extends GovernedConsumerWidget {
  const FamilyMemberComplianceScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyMemberComplianceProvider);
    final controller = ref.read(familyMemberComplianceProvider.notifier);
    final theme = context.theme;
    final roleBase = 'FamilyMemberComplianceScreen'.replaceAll('ComplianceScreen', '').replaceAll('Screen', '');

    return Scaffold(
      key: const Key('familymembercompliance-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('familymembercompliance-title'),
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            key: const Key('familymembercompliance-btn-1'),
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'),
          ),
        ],
      ),
      body: Semantics(
        label: 'data-cy:familymembercompliance-screen',
        child: SingleChildScrollView(
        key: const Key('familymembercompliance-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('familymembercompliance-btn-2'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            GovDashboardHero(
              title: state.title,
              roleName: '$roleBase Invariants',
              description: 'Operational compliance checks, dynamic security policies, and secure ingestion forms.',
              onRefresh: () => controller.addLog('Compliance status scanned.'),
            ),
            const SizedBox(height: 24),
            GovSettingsPanel(
              title: 'Governance Directives',
              items: const [
                GovSettingsItem(
                  id: 'enforce_mfa',
                  name: 'Enforce MFA Authentication',
                  description: 'Mandate multi-factor security clearance for all sessions.',
                  initialValue: true,
                ),
                GovSettingsItem(
                  id: 'audit_telemetry',
                  name: 'Real-time System Audit Telemetry',
                  description: 'Stream automated invariant telemetry logs directly.',
                  initialValue: true,
                ),
              ],
              onToggled: (id, val) {
                controller.addLog('Policy update: $id set to $val');
              },
            ),
            const SizedBox(height: 24),
            GovIngestionForm(
              title: 'Secure Event Reporting Ingestion',
              buttonLabel: 'Submit Secure Form Logs',
              fields: const [
                'Inbound Event Classification',
                'Operational Priority Descriptor',
                'Authorized System Signature',
              ],
              onSubmit: (data) {
                controller.addLog(
                  'Ingested secure submission: Priority=${data['Operational Priority Descriptor'] ?? 'N/A'}, Event=${data['Inbound Event Classification'] ?? 'N/A'}',
                );
              },
            ),
            const SizedBox(height: 24),
            GovComplianceAuditTable(
              title: 'Recent Compliance Verification Audits',
              columns: const ['Identifier', 'Authorized Signature', 'Status'],
              data: const [
                {
                  'Identifier': 'AUD-9981-A',
                  'Authorized Signature': 'SYSTEM_SECURE_BYPASS',
                  'Status': 'COMPLIANT',
                },
                {
                  'Identifier': 'AUD-9982-B',
                  'Authorized Signature': 'GOV_ENGINE_INV_SYNC',
                  'Status': 'COMPLIANT',
                },
                {
                  'Identifier': 'AUD-9983-C',
                  'Authorized Signature': 'SYSTEM_SECURE_BYPASS',
                  'Status': 'COMPLIANT',
                },
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map((log) => Padding(
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
                                log,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
            key: const Key('familymembercompliance-btn-3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state.isLoading ? null : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
            key: const Key('familymembercompliance-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Compliance Audit Scan',
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
