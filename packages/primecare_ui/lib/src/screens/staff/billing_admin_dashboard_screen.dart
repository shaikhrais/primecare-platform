// Governance - Category: view | Purpose: UI Screen component rendering the Billing Admin Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC Invoicing Model ---
class BillingInvoice {
  final String id;
  final String clientName;
  final double amount;
  final String serviceType; // 'Nursing', 'PSW Care', 'Therapy'
  final String status; // 'Outstanding', 'Underpaid', 'Matched & Cleared', 'Disputed'
  final bool isDiscrepant;

  const BillingInvoice({
    required this.id,
    required this.clientName,
    required this.amount,
    required this.serviceType,
    required this.status,
    required this.isDiscrepant,
  });

  BillingInvoice copyWith({
    String? status,
    bool? isDiscrepant,
  }) {
    return BillingInvoice(
      id: id,
      clientName: clientName,
      amount: amount,
      serviceType: serviceType,
      status: status ?? this.status,
      isDiscrepant: isDiscrepant ?? this.isDiscrepant,
    );
  }
}

// --- MVC State Model ---
class BillingAdminDashboardState {
  final bool isLoading;
  final String? error;
  final List<BillingInvoice> invoices;
  final double pswRatePerHour;
  final double rnRatePerHour;
  final double hstRatePercent;
  final List<String> logs;

  const BillingAdminDashboardState({
    required this.isLoading,
    this.error,
    required this.invoices,
    required this.pswRatePerHour,
    required this.rnRatePerHour,
    required this.hstRatePercent,
    required this.logs,
  });

  BillingAdminDashboardState copyWith({
    bool? isLoading,
    String? error,
    List<BillingInvoice>? invoices,
    double? pswRatePerHour,
    double? rnRatePerHour,
    double? hstRatePercent,
    List<String>? logs,
  }) {
    return BillingAdminDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      invoices: invoices ?? this.invoices,
      pswRatePerHour: pswRatePerHour ?? this.pswRatePerHour,
      rnRatePerHour: rnRatePerHour ?? this.rnRatePerHour,
      hstRatePercent: hstRatePercent ?? this.hstRatePercent,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class BillingAdminDashboardController extends StateNotifier<BillingAdminDashboardState> {
  BillingAdminDashboardController()
      : super(
          const BillingAdminDashboardState(
            isLoading: false,
            pswRatePerHour: 28.0,
            rnRatePerHour: 62.0,
            hstRatePercent: 13.0,
            invoices: [
              BillingInvoice(
                id: 'INV-401',
                clientName: 'Arthur Dent',
                amount: 350.00,
                serviceType: 'Nursing',
                status: 'Underpaid',
                isDiscrepant: true,
              ),
              BillingInvoice(
                id: 'INV-402',
                clientName: 'Tricia McMillan',
                amount: 1200.00,
                serviceType: 'Therapy',
                status: 'Outstanding',
                isDiscrepant: false,
              ),
              BillingInvoice(
                id: 'INV-403',
                clientName: 'Ford Prefect',
                amount: 450.00,
                serviceType: 'PSW Care',
                status: 'Underpaid',
                isDiscrepant: true,
              ),
              BillingInvoice(
                id: 'INV-404',
                clientName: 'Zaphod Beeblebrox',
                amount: 2500.00,
                serviceType: 'Nursing',
                status: 'Matched & Cleared',
                isDiscrepant: false,
              ),
            ],
            logs: [
              '[SYSTEM-INIT] Billing Admin Control Room hydrated.',
              '[LEDGER] Double-entry bank reconciliation bridge established via Plaid.',
              '[TAX-COMPLIANCE] GST/HST exemption algorithms synchronized with CRA specifications.',
            ],
          ),
        );

  void updatePswRate(double val) {
    state = state.copyWith(
      pswRatePerHour: val,
      logs: [
        ...state.logs,
        '[RATE-CHANGE] PSW base rate adjusted to \$${val.toStringAsFixed(2)}/hr.',
      ],
    );
  }

  void updateRnRate(double val) {
    state = state.copyWith(
      rnRatePerHour: val,
      logs: [
        ...state.logs,
        '[RATE-CHANGE] RN clinical rate adjusted to \$${val.toStringAsFixed(2)}/hr.',
      ],
    );
  }

  void updateHstRate(double val) {
    state = state.copyWith(
      hstRatePercent: val,
      logs: [
        ...state.logs,
        '[TAX-CALC] Provincial sales tax benchmark target adjusted to ${val.toStringAsFixed(1)}%.',
      ],
    );
  }

  Future<void> reconcileInvoice(String id) async {
    state = state.copyWith(
      invoices: state.invoices.map((inv) {
        if (inv.id == id) {
          return inv.copyWith(status: 'Matching Ledger...');
        }
        return inv;
      }).toList(),
      logs: [
        ...state.logs,
        '[RECONCILER] Running fuzzy ledger offset match on discrepancy $id...',
      ],
    );

    await Future<void>.delayed(const Duration(milliseconds: 1200));

    state = state.copyWith(
      invoices: state.invoices.map((inv) {
        if (inv.id == id) {
          return inv.copyWith(
            status: 'Matched & Cleared',
            isDiscrepant: false,
          );
        }
        return inv;
      }).toList(),
      logs: [
        ...state.logs,
        '[RECONCILER-SUCCESS] Double-entry matching journal record created for $id. Status: CLEARED.',
      ],
    );
  }

  Future<void> bulkReconcile() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    final reconciled = state.invoices.map((inv) {
      if (inv.isDiscrepant) {
        return inv.copyWith(
          status: 'Matched & Cleared',
          isDiscrepant: false,
        );
      }
      return inv;
    }).toList();

    state = state.copyWith(
      isLoading: false,
      invoices: reconciled,
      logs: [
        ...state.logs,
        '[LEDGER-SYNC] Bulk bank feed auto-matching finished.',
        '[LEDGER-SYNC] Zero discrepancy flags remaining in queue.',
      ],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  void clearLogs() {
    state = state.copyWith(logs: []);
  }
}


// --- Provider ---
final billingAdminDashboardProvider =
    StateNotifierProvider<BillingAdminDashboardController, BillingAdminDashboardState>((ref) {
  return BillingAdminDashboardController();
});

// --- View ---
class BillingAdminDashboardScreen extends GovernedConsumerWidget {
  const BillingAdminDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billingAdminDashboardProvider);
    final controller = ref.read(billingAdminDashboardProvider.notifier);
    final theme = context.theme;
    final roleBase = 'BillingAdminDashboardScreen'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: state.title,
              roleName: '$roleBase Dashboard',
              description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
              onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GovMetricCard(
                    title: 'Active Operations',
                    value: 'Active',
                    trendLabel: 'Optimal productivity',
                    progress: 0.92,
                    icon: LucideIcons.activity,
                    brandColor: theme.colors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GovMetricCard(
                    title: 'Security Clearance',
                    value: 'Level 4 Approved',
                    trendLabel: 'Zero exceptions logged',
                    progress: 1.0,
                    icon: LucideIcons.shieldCheck,
                    brandColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GovTelemetryChart(
              title: 'Hourly Core Telemetry',
              dataPoints: const [75, 82, 80, 94, 91, 98],
              labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
              accentColor: theme.colors.primary,
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
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan',
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
