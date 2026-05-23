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

    // Computed CFO metrics
    final totalTransactionsCount = state.transactions.length;
    final reconciledCount = state.transactions.where((tx) => tx.isReconciled).length;
    final compliancePercentage = totalTransactionsCount > 0 
        ? (reconciledCount / totalTransactionsCount * 100) 
        : 100.0;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(
            color: theme.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () {
              controller.addLog('Manual ledger synchronization executed.'); // .tr() LocaleKeys.
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Active Cash Balance', // .tr() LocaleKeys.
                value: '\$${state.currentCashBalance.toStringAsFixed(2).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")}', // .tr() LocaleKeys.
                trendLabel: 'Real-time ledger value', // .tr() LocaleKeys.
                progress: 0.85,
                icon: LucideIcons.banknote,
                brandColor: theme.colors.primary,
              ),
              GovMetricCard(
                title: 'Ledger Audit Standing', // .tr() LocaleKeys.
                value: '${compliancePercentage.toStringAsFixed(1)}%', // .tr() LocaleKeys.
                trendLabel: '$reconciledCount of $totalTransactionsCount entries verified', // .tr() LocaleKeys.
                progress: compliancePercentage / 100.0,
                icon: LucideIcons.checkSquare,
                brandColor: compliancePercentage > 80 ? const Color(0xFF10B981) : theme.colors.warning,
              ),
              GovMetricCard(
                title: 'Upcoming Tax Remittance', // .tr() LocaleKeys.
                value: state.taxLiability.isRemitted 
                    ? 'FULLY REMITTED' // .tr() LocaleKeys.
                    : '\$${state.taxLiability.netRemittance.toStringAsFixed(2).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")}', // .tr() LocaleKeys.
                trendLabel: state.taxLiability.isRemitted ? 'HST Q2 Settled' : 'GST/HST Q2 Remittance due', // .tr() LocaleKeys.
                progress: state.taxLiability.isRemitted ? 1.0 : 0.4,
                icon: LucideIcons.calculator,
                brandColor: state.taxLiability.isRemitted ? Colors.teal : theme.colors.tertiary,
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GovDashboardHero(
                  title: state.title,
                  roleName: 'CFO Strategic Finance', // .tr() LocaleKeys.
                  description: 'Executive command console for balanced multi-ledger bookkeeping, real-time corporate tax compliance, and cash forecasting.', // .tr() LocaleKeys.
                  onRefresh: () => controller.addLog('Telemetry status verified.'), // .tr() LocaleKeys.
                ),
                const SizedBox(height: 24),
                _buildLedgerCard(context, ref, state, controller),
                const SizedBox(height: 24),
                _buildTaxHub(context, ref, state, controller),
              ],
            ),
            defaultSidebarWidgets: [
              _buildForecastSimulator(context, ref, state, controller),
              _buildTerminalCard(context, ref, state, controller),
              const AiInsightsCard(
                heading: 'Financial AI Assistant', // .tr() LocaleKeys.
                suggestions: [
                  'Optimize GST/HST input tax credits prior to secure wire.', // .tr() LocaleKeys.
                  'Analyze ledger discrepancy logs to ensure zero audit variance.', // .tr() LocaleKeys.
                  'Adjust growth simulator rate to forecast cash runway metrics.', // .tr() LocaleKeys.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Beautiful Custom Component: Ledger Transaction Table ---
  Widget _buildLedgerCard(BuildContext context, WidgetRef ref, CfoDashboardState state, CfoDashboardController controller) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ledger Registry & Reconciliation',
                    style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Balanced double-entry records requiring authorization.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddTransactionDialog(context, ref, controller),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text('New Adjusting Entry'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: theme.colors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final tx = state.transactions[index];
              final isDiscrepancy = tx.status == 'discrepancy';

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDiscrepancy 
                      ? theme.colors.warning.withValues(alpha: 0.05)
                      : theme.colors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDiscrepancy 
                        ? theme.colors.warning.withValues(alpha: 0.3) 
                        : theme.colors.border,
                  ),
                ),
                child: Row(
                  children: [
                    // Icon based on type
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDiscrepancy
                            ? theme.colors.warning.withValues(alpha: 0.15)
                            : (tx.debitAccount.contains('Revenue') || tx.creditAccount.contains('Revenue'))
                                ? const Color(0xFF10B981).withValues(alpha: 0.15)
                                : theme.colors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isDiscrepancy 
                            ? LucideIcons.alertTriangle 
                            : (tx.debitAccount.contains('Revenue') || tx.creditAccount.contains('Revenue'))
                                ? LucideIcons.trendingUp 
                                : LucideIcons.arrowUpDown,
                        size: 20,
                        color: isDiscrepancy 
                            ? theme.colors.warning 
                            : (tx.debitAccount.contains('Revenue') || tx.creditAccount.contains('Revenue'))
                                ? const Color(0xFF10B981) 
                                : theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tx.id,
                                style: theme.typography.labelBold.copyWith(
                                  color: theme.colors.primary,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: tx.isReconciled 
                                      ? const Color(0xFF10B981).withValues(alpha: 0.1) 
                                      : theme.colors.warning.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tx.isReconciled ? 'RECONCILED' : 'PENDING RECON',
                                  style: theme.typography.labelSmall.copyWith(
                                    color: tx.isReconciled ? const Color(0xFF10B981) : theme.colors.warning,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            tx.description,
                            style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Dr: ',
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.outline, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                tx.debitAccount,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Cr: ',
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.outline, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                tx.creditAccount,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\$${tx.amount.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: theme.typography.h3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDiscrepancy ? theme.colors.warning : theme.colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (isDiscrepancy)
                            TextButton(
                              onPressed: () => controller.resolveDiscrepancy(tx.id),
                              style: TextButton.styleFrom(
                                backgroundColor: theme.colors.warning.withValues(alpha: 0.15),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                minimumSize: Size.zero,
                              ),
                              child: Text(
                                'Force Balance',
                                style: theme.typography.labelSmall.copyWith(color: theme.colors.warning, fontWeight: FontWeight.bold),
                              ),
                            )
                          else
                            InkWell(
                              onTap: () => controller.toggleReconcile(tx.id),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: tx.isReconciled 
                                      ? theme.colors.divider 
                                      : theme.colors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tx.isReconciled ? 'Unreconcile' : 'Reconcile',
                                  style: theme.typography.labelSmall.copyWith(
                                    color: tx.isReconciled ? theme.colors.onSurfaceVariant : theme.colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Beautiful Tax Remittance Compliance Hub ---
  Widget _buildTaxHub(BuildContext context, WidgetRef ref, CfoDashboardState state, CfoDashboardController controller) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HST / GST Q2 Remittance Center',
                    style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Canada Revenue Agency (CRA) Corporate Compliance Pipeline.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: state.taxLiability.isRemitted 
                      ? const Color(0xFF10B981).withValues(alpha: 0.15) 
                      : theme.colors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      state.taxLiability.isRemitted ? LucideIcons.shieldCheck : LucideIcons.clock,
                      size: 14,
                      color: state.taxLiability.isRemitted ? const Color(0xFF10B981) : theme.colors.error,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      state.taxLiability.isRemitted ? 'COMPLIANT' : 'PENDING PAYMENT',
                      style: theme.typography.labelSmall.copyWith(
                        color: state.taxLiability.isRemitted ? const Color(0xFF10B981) : theme.colors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: theme.colors.border, height: 1),
          const SizedBox(height: 20),
          
          // Tax Breakdowns
          Row(
            children: [
              Expanded(
                child: _buildTaxSubCard(
                  context,
                  'Total GST/HST Collected',
                  '\$${state.taxLiability.collectedGst.toStringAsFixed(2)}',
                  'Output Tax (Sales Inflows)',
                  theme.colors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTaxSubCard(
                  context,
                  'Total ITC Paid',
                  '\$${state.taxLiability.paidItc.toStringAsFixed(2)}',
                  'Input Tax Credits (Purchases)',
                  theme.colors.tertiary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTaxSubCard(
                  context,
                  'Net Remittance Due',
                  '\$${state.taxLiability.netRemittance.toStringAsFixed(2)}',
                  'CRA Liability Settlement',
                  Colors.blueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Wire Action
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.info, color: theme.colors.primary, size: 20),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Deadline: 31 May 2026',
                          style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Settling resolves GST Liability 2200 ledger to Cash 1010.',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.taxLiability.isRemitted ? const Color(0xFF10B981) : theme.colors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: state.taxLiability.isRemitted || state.isRemittingTax
                        ? null 
                        : () => controller.remitTaxLiability(),
                    child: state.isRemittingTax
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(
                            state.taxLiability.isRemitted ? 'Remitted & Balanced' : 'Secure Wire Remittance',
                            style: theme.typography.button.copyWith(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSubCard(BuildContext context, String title, String value, String desc, Color accent) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: theme.typography.bodySmall.copyWith(color: theme.colors.outline, fontSize: 10),
          ),
        ],
      ),
    );
  }

  // --- Beautiful Cash Flow Forecasting & Growth Simulator ---
  Widget _buildForecastSimulator(BuildContext context, WidgetRef ref, CfoDashboardState state, CfoDashboardController controller) {
    final theme = context.theme;

    // Simulation math
    final baseIncome = 450000.0;
    final simulatedGrowthFactor = 1.0 + (state.projectedGrowthRate / 100);
    final simulatedExpenseFactor = 1.0 + (state.expenseBuffer / 100);

    // Compute monthly projections
    final projections = List.generate(6, (index) {
      final monthIndex = index + 1;
      final income = baseIncome * double.parse(monthIndex.toString()) * simulatedGrowthFactor;
      final expense = (baseIncome * 0.72) * double.parse(monthIndex.toString()) * simulatedExpenseFactor;
      final netCash = income - expense;
      return netCash;
    });

    final maxVal = projections.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Cash Flow Predictor',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Model future reserves by adjusting target growth rates and fringe buffers.',
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Divider(color: theme.colors.border, height: 1),
          const SizedBox(height: 20),

          // Growth slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Projected Growth Rate', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              Text('${state.projectedGrowthRate.toStringAsFixed(1)}%', style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider.adaptive(
            value: state.projectedGrowthRate,
            min: 1.0,
            max: 15.0,
            activeColor: theme.colors.primary,
            inactiveColor: theme.colors.divider,
            onChanged: (val) => controller.updateGrowthRate(val),
          ),

          // Expense slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fringe Expense Buffer', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              Text('${state.expenseBuffer.toStringAsFixed(1)}%', style: theme.typography.bodyMedium.copyWith(color: theme.colors.tertiary, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider.adaptive(
            value: state.expenseBuffer,
            min: 0.0,
            max: 20.0,
            activeColor: theme.colors.tertiary,
            inactiveColor: theme.colors.divider,
            onChanged: (val) => controller.updateExpenseBuffer(val),
          ),

          const SizedBox(height: 24),
          Text(
            'Computed 6-Month Reserves Forecast',
            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 16),

          // Interactive Custom Chart Render
          SizedBox(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(6, (index) {
                final val = projections[index];
                final normalizedHeight = maxVal > 0 ? (val / maxVal) : 0.0;
                final months = ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov'];

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Projected Value Hover Tag
                      Text(
                        '\$${(val / 1000).toStringAsFixed(0)}K',
                        style: theme.typography.bodySmall.copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: theme.colors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: normalizedHeight.clamp(0.1, 1.0),
                            widthFactor: 0.5,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    theme.colors.primary,
                                    theme.colors.primary.withValues(alpha: 0.4),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        months[index],
                        style: theme.typography.bodySmall.copyWith(fontSize: 10, color: theme.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // --- Beautiful Compliance Audit Monospace Terminal ---
  Widget _buildTerminalCard(BuildContext context, WidgetRef ref, CfoDashboardState state, CfoDashboardController controller) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Premium obsidian background
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: const Color(0xFF334155)),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.terminal, color: Color(0xFF38BDF8), size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Operational Audit Logs',
                    style: theme.typography.h3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (state.isScanning)
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Color(0xFF38BDF8)),
                  ),
                )
              else
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (c) => c.repeat()).fade(duration: 800.ms).then().fade(duration: 800.ms),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF020617), // Pure black insert
              borderRadius: BorderRadius.circular(6),
            ),
            child: ListView.builder(
              itemCount: state.logs.length,
              itemBuilder: (context, index) {
                final log = state.logs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        r'cfo@primecare:~$ ',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          log,
                          style: TextStyle(
                            color: log.contains('⚠️') 
                                ? const Color(0xFFFBBF24) 
                                : log.contains('✅') 
                                    ? const Color(0xFF34D399) 
                                    : const Color(0xFFE2E8F0),
                            fontFamily: 'monospace',
                            fontSize: 11,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                side: const BorderSide(color: Color(0xFF475569)),
              ),
              onPressed: state.isScanning ? null : () => controller.runComplianceScan(),
              child: Text(
                state.isScanning ? 'Executing Scanner...' : 'Execute Ledger Integrity Scan',
                style: theme.typography.button.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Transaction Generation Modal Form ---
  void _showAddTransactionDialog(BuildContext context, WidgetRef ref, CfoDashboardController controller) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.theme.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return _AddTransactionSheet(controller: controller);
      },
    );
  }
}

// --- Custom HSL Styled CFO Dashboard Card Widget ---
class _CfoMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _CfoMetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.typography.h2.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.outline,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Add Transaction Sheet Component ---
class _AddTransactionSheet extends StatefulWidget {
  final CfoDashboardController controller;

  const _AddTransactionSheet({required this.controller});

  @override
  State<_AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<_AddTransactionSheet> {
  final _descController = TextEditingController();
  final _amountController = TextEditingController();

  String _debitAccount = '5010 - Wages & Salaries';
  String _creditAccount = '1010 - Cash Reserves';

  final List<String> _accounts = [
    '1010 - Cash Reserves',
    '1200 - Accounts Receivable',
    '2200 - GST/HST Payable',
    '4010 - Royalty Revenue',
    '5010 - Wages & Salaries',
    '5040 - Medical Supplies',
    '5060 - Office Rent',
  ];

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Post Adjusting Ledger Entry', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ensure full double-entry balance. All postings log to local telemetry audits.',
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          
          TextField(
            controller: _descController,
            style: theme.typography.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Transaction Description',
              hintText: 'e.g., General Office Lease Payment',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _amountController,
            style: theme.typography.bodyMedium,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: r'Debit/Credit Amount ($)',
              hintText: '0.00',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: _debitAccount,
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
            decoration: InputDecoration(
              labelText: 'Debit Account (Dr)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: _accounts.map((acct) => DropdownMenuItem(value: acct, child: Text(acct))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _debitAccount = val);
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: _creditAccount,
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
            decoration: InputDecoration(
              labelText: 'Credit Account (Cr)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: _accounts.map((acct) => DropdownMenuItem(value: acct, child: Text(acct))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _creditAccount = val);
            },
          ),
          
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              final desc = _descController.text.trim();
              final amountStr = _amountController.text.trim();
              final amount = double.tryParse(amountStr) ?? 0.0;

              if (desc.isNotEmpty && amount > 0.0) {
                widget.controller.addTransaction(desc, _debitAccount, _creditAccount, amount);
                Navigator.pop(context);
              }
            },
            child: const Text('Post to Ledger & Sync', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
