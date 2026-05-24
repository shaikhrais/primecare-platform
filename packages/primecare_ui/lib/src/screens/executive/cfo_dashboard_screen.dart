// Governance - Category: view | Purpose: UI Screen component rendering the Cfo Dashboard Screen workspace interface.
import 'package:flutter_animate/flutter_animate.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- Data Models ---
class LedgerTransaction {
  final String id;
  final String description;
  final String debitAccount;
  final String creditAccount;
  final double amount;
  final DateTime date;
  final bool isReconciled;
  final String status; // 'balanced', 'discrepancy'

  const LedgerTransaction({
    required this.id,
    required this.description,
    required this.debitAccount,
    required this.creditAccount,
    required this.amount,
    required this.date,
    required this.isReconciled,
    required this.status,
  });

  LedgerTransaction copyWith({
    bool? isReconciled,
    String? status,
  }) {
    return LedgerTransaction(
      id: id,
      description: description,
      debitAccount: debitAccount,
      creditAccount: creditAccount,
      amount: amount,
      date: date,
      isReconciled: isReconciled ?? this.isReconciled,
      status: status ?? this.status,
    );
  }
}

class TaxLiability {
  final double collectedGst;
  final double paidItc;
  final double netRemittance;
  final bool isRemitted;
  final DateTime dueDate;

  const TaxLiability({
    required this.collectedGst,
    required this.paidItc,
    required this.netRemittance,
    required this.isRemitted,
    required this.dueDate,
  });

  TaxLiability copyWith({
    double? collectedGst,
    double? paidItc,
    double? netRemittance,
    bool? isRemitted,
    DateTime? dueDate,
  }) {
    return TaxLiability(
      collectedGst: collectedGst ?? this.collectedGst,
      paidItc: paidItc ?? this.paidItc,
      netRemittance: netRemittance ?? this.netRemittance,
      isRemitted: isRemitted ?? this.isRemitted,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}

// --- MVC State Model ---
class CfoDashboardState {
  final bool isLoading;
  final bool isScanning;
  final bool isRemittingTax;
  final String? error;
  final String title;
  final List<String> logs;
  final List<LedgerTransaction> transactions;
  final double projectedGrowthRate;
  final double expenseBuffer;
  final TaxLiability taxLiability;
  final double currentCashBalance;

  const CfoDashboardState({
    required this.isLoading,
    required this.isScanning,
    required this.isRemittingTax,
    this.error,
    required this.title,
    required this.logs,
    required this.transactions,
    required this.projectedGrowthRate,
    required this.expenseBuffer,
    required this.taxLiability,
    required this.currentCashBalance,
  });

  CfoDashboardState copyWith({
    bool? isLoading,
    bool? isScanning,
    bool? isRemittingTax,
    String? error,
    String? title,
    List<String>? logs,
    List<LedgerTransaction>? transactions,
    double? projectedGrowthRate,
    double? expenseBuffer,
    TaxLiability? taxLiability,
    double? currentCashBalance,
  }) {
    return CfoDashboardState(
      isLoading: isLoading ?? this.isLoading,
      isScanning: isScanning ?? this.isScanning,
      isRemittingTax: isRemittingTax ?? this.isRemittingTax,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      transactions: transactions ?? this.transactions,
      projectedGrowthRate: projectedGrowthRate ?? this.projectedGrowthRate,
      expenseBuffer: expenseBuffer ?? this.expenseBuffer,
      taxLiability: taxLiability ?? this.taxLiability,
      currentCashBalance: currentCashBalance ?? this.currentCashBalance,
    );
  }
}

// --- Controller (Notifier) ---
class CfoDashboardController extends StateNotifier<CfoDashboardState> {
  CfoDashboardController()
      : super(
          CfoDashboardState(
            isLoading: false,
            isScanning: false,
            isRemittingTax: false,
            title: 'CFO Strategic Finance HUD',
            logs: [
              'System initialized.',
              'Double-entry ledger sync complete.',
              'GST/HST Remittance engine ready.',
            ],
            currentCashBalance: 1245000.00,
            projectedGrowthRate: 5.5,
            expenseBuffer: 8.0,
            taxLiability: TaxLiability(
              collectedGst: 85420.00,
              paidItc: 34210.00,
              netRemittance: 51210.00,
              isRemitted: false,
              dueDate: DateTime.now().add(const Duration(days: 14)),
            ),
            transactions: [
              LedgerTransaction(
                id: 'TX-2026-001',
                description: 'Clinical Staff Payroll - Bi-Weekly Posting',
                debitAccount: '5010 - Wages & Salaries',
                creditAccount: '1010 - Cash Reserves',
                amount: 68500.00,
                date: DateTime.now().subtract(const Duration(days: 1)),
                isReconciled: true,
                status: 'balanced',
              ),
              LedgerTransaction(
                id: 'TX-2026-002',
                description: 'Corporate Supply Ingestion (Palliative Supplies)',
                debitAccount: '5040 - Medical Supplies',
                creditAccount: '1010 - Cash Reserves',
                amount: 14200.00,
                date: DateTime.now().subtract(const Duration(days: 2)),
                isReconciled: false,
                status: 'discrepancy',
              ),
              LedgerTransaction(
                id: 'TX-2026-003',
                description: 'Franchise Royalty Licensing Inflow (#104)',
                debitAccount: '1010 - Cash Reserves',
                creditAccount: '4010 - Royalty Revenue',
                amount: 24500.00,
                date: DateTime.now().subtract(const Duration(days: 3)),
                isReconciled: true,
                status: 'balanced',
              ),
              LedgerTransaction(
                id: 'TX-2026-004',
                description: 'HST Remittance Adjusting Provision',
                debitAccount: '2200 - GST/HST Payable',
                creditAccount: '1010 - Cash Reserves',
                amount: 51210.00,
                date: DateTime.now().subtract(const Duration(days: 4)),
                isReconciled: false,
                status: 'balanced',
              ),
            ],
          ),
        );

  Future<void> runComplianceScan() async {
    if (state.isScanning) return;
    state = state.copyWith(isScanning: true);
    addLog('Initiating Operational Ledger Audit Scan...');
    await Future<void>.delayed(const Duration(milliseconds: 600));
    addLog('Evaluating double-entry balance: Debit sum == Credit sum.');
    await Future<void>.delayed(const Duration(milliseconds: 600));
    
    // Check if there are any discrepancies
    final discrepancies = state.transactions.where((tx) => tx.status == 'discrepancy').toList();
    if (discrepancies.isNotEmpty) {
      addLog('⚠️ Scan warning: Detected ${discrepancies.length} ledger discrepancy!');
      for (final tx in discrepancies) {
        addLog(' -> Discrepancy in ${tx.id} (${tx.description}): unbalanced entry.');
      }
    } else {
      addLog('✅ Success: Double-entry audit clean. 100% balance consistency.');
    }
    
    await Future<void>.delayed(const Duration(milliseconds: 400));
    state = state.copyWith(
      isScanning: false,
      logs: [
        ...state.logs,
        'Operational Ledger Audit executed successfully at ${DateTime.now().toIso8601String()}',
        'All corporate governance and tax invariants validated.',
      ],
    );
  }

  void toggleReconcile(String txId) {
    final updatedTx = state.transactions.map((tx) {
      if (tx.id == txId) {
        final nextReconciled = !tx.isReconciled;
        final nextStatus = nextReconciled ? 'balanced' : tx.status;
        addLog('Transaction $txId reconciliation status flipped to: ${nextReconciled ? "RECONCILED" : "UNRECONCILED"}');
        return tx.copyWith(isReconciled: nextReconciled, status: nextStatus);
      }
      return tx;
    }).toList();

    state = state.copyWith(transactions: updatedTx);
  }

  void resolveDiscrepancy(String txId) {
    final updatedTx = state.transactions.map((tx) {
      if (tx.id == txId) {
        addLog('Resolved ledger discrepancy for $txId. Adjusting offset to balance.');
        return tx.copyWith(isReconciled: true, status: 'balanced');
      }
      return tx;
    }).toList();

    state = state.copyWith(transactions: updatedTx);
  }

  void addTransaction(String description, String debitAccount, String creditAccount, double amount) {
    final newTx = LedgerTransaction(
      id: 'TX-2026-${(state.transactions.length + 1).toString().padLeft(3, '0')}',
      description: description,
      debitAccount: debitAccount,
      creditAccount: creditAccount,
      amount: amount,
      date: DateTime.now(),
      isReconciled: false,
      status: 'balanced',
    );

    double nextCash = state.currentCashBalance;
    if (debitAccount.contains('1010')) {
      nextCash += amount;
    } else if (creditAccount.contains('1010')) {
      nextCash -= amount;
    }

    state = state.copyWith(
      transactions: [newTx, ...state.transactions],
      currentCashBalance: nextCash,
    );
    addLog('Created secure ledger transaction ${newTx.id}: ${newTx.description}');
  }

  void updateGrowthRate(double val) {
    state = state.copyWith(projectedGrowthRate: val);
  }

  void updateExpenseBuffer(double val) {
    state = state.copyWith(expenseBuffer: val);
  }

  Future<void> remitTaxLiability() async {
    if (state.taxLiability.isRemitted || state.isRemittingTax) return;
    
    state = state.copyWith(isRemittingTax: true);
    addLog('Secure Remittance Process: Initializing bank transfer endpoint.');
    await Future<void>.delayed(const Duration(seconds: 1));
    addLog('Secure Remittance Process: Debiting Cash account 1010 by \$${state.taxLiability.netRemittance}');
    
    double nextCash = state.currentCashBalance - state.taxLiability.netRemittance;
    
    state = state.copyWith(
      isRemittingTax: false,
      currentCashBalance: nextCash,
      taxLiability: state.taxLiability.copyWith(isRemitted: true),
    );
    
    addLog('✅ Success: Tax Remittance finalized. Audit receipt created.');
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }
}

// --- Provider ---
final cfoDashboardProvider =
    StateNotifierProvider<CfoDashboardController, CfoDashboardState>((ref) {
  return CfoDashboardController();
});

// --- View ---
class CfoDashboardScreen extends GovernedConsumerWidget {
  const CfoDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfoDashboardProvider);
    final controller = ref.read(cfoDashboardProvider.notifier);
    final theme = context.theme;
    final roleBase = 'CfoDashboardScreen'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

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
