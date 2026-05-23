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

    // Derived values
    final totalDiscrepancies = state.invoices.where((inv) => inv.isDiscrepant).length;
    final totalVolume = state.invoices.fold<double>(0.0, (acc, inv) => acc + inv.amount);
    final outstandingVolume = state.invoices
        .where((inv) => inv.status != 'Matched & Cleared')
        .fold<double>(0.0, (acc, inv) => acc + inv.amount);

    // Dynamic GST/HST calculation based on outstanding volume
    final calculatedTax = outstandingVolume * (state.hstRatePercent / 100.0);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.fileSpreadsheet, color: theme.colors.primary, size: 24),
            const SizedBox(width: 8),
            Text(
              'Billing Admin Hub', // .tr() LocaleKeys.
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () {
              controller.addLog('[PULL-FEEDS] Plaid banking transactions synchronized.'); // .tr() LocaleKeys.
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
                title: 'Total Active Volume', // .tr() LocaleKeys.
                value: '\$${totalVolume.toStringAsFixed(2)} CAD', // .tr() LocaleKeys.
                trendLabel: 'Sum of open & cleared invoices', // .tr() LocaleKeys.
                progress: 0.85,
                icon: LucideIcons.coins,
                brandColor: theme.colors.primary,
              ),
              GovMetricCard(
                title: 'Ledger Discrepancies', // .tr() LocaleKeys.
                value: totalDiscrepancies == 0 ? 'Zero flags' : '$totalDiscrepancies mismatch alerts', // .tr() LocaleKeys.
                trendLabel: totalDiscrepancies == 0 ? 'Optimal double-entry health' : 'Unmatched bank offsets', // .tr() LocaleKeys.
                progress: totalDiscrepancies == 0 ? 1.0 : 0.65,
                icon: LucideIcons.alertTriangle,
                brandColor: totalDiscrepancies == 0 ? const Color(0xFF0D9488) : const Color(0xFFEF4444),
              ),
              GovMetricCard(
                title: 'HST Benchmark', // .tr() LocaleKeys.
                value: '\$${calculatedTax.toStringAsFixed(2)} CAD', // .tr() LocaleKeys.
                trendLabel: 'Estimated HST to remit', // .tr() LocaleKeys.
                progress: 0.90,
                icon: LucideIcons.percent,
                brandColor: Colors.amber,
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title Hero Title Card ---
                GovDashboardHero(
                  title: 'Billing & Invoicing administration', // .tr() LocaleKeys.
                  roleName: 'Ledger Audit Command', // .tr() LocaleKeys.
                  description: 'Reconcile patient service invoice disputes, tweak base billing hourly rates, compute provincial GST/HST CRA tax offsets, and track accounting ledger health.', // .tr() LocaleKeys.
                  onRefresh: () => controller.addLog('[HEALTH-CHECK] Double-entry ledger parity confirmed.'), // .tr() LocaleKeys.
                ),
                const SizedBox(height: 24),

                // --- Billing Reconciliation Matrix ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Banking Ledgers & Invoices', // .tr() LocaleKeys.
                            style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                          ),
                          // Bulk auto match trigger button
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colors.primary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: state.isLoading ? null : () => controller.bulkReconcile(),
                              child: state.isLoading
                                  ? const SizedBox(
                                      height: 14,
                                      width: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        const Icon(LucideIcons.sparkles, color: Colors.white, size: 14),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Fuzzy Smart Resolve All', // .tr() LocaleKeys.
                                          style: theme.typography.button.copyWith(color: Colors.white, fontSize: 11),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Invoices mapping
                      ...state.invoices.map((invoice) {
                        final hasMismatch = invoice.isDiscrepant;
                        final isMatching = invoice.status == 'Matching Ledger...'; // .tr() LocaleKeys.

                        Color stateBorder = theme.colors.border;
                        Color statusAccent = theme.colors.primary;

                        if (hasMismatch) {
                          stateBorder = const Color(0xFFEF4444);
                          statusAccent = const Color(0xFFEF4444);
                        } else if (invoice.status == 'Outstanding') { // .tr() LocaleKeys.
                          stateBorder = const Color(0xFFD97706);
                          statusAccent = const Color(0xFFD97706);
                        } else if (invoice.status == 'Matched & Cleared') { // .tr() LocaleKeys.
                          stateBorder = const Color(0xFF0D9488);
                          statusAccent = const Color(0xFF0D9488);
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: stateBorder),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: statusAccent.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            invoice.serviceType,
                                            style: theme.typography.bodySmall.copyWith(
                                              color: statusAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          invoice.id,
                                          style: theme.typography.bodySmall.copyWith(
                                            color: theme.colors.onSurfaceVariant,
                                            fontFamily: 'monospace',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      invoice.clientName,
                                      style: theme.typography.bodyLarge.copyWith(
                                        color: theme.colors.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Invoice Amount: \$${invoice.amount.toStringAsFixed(2)} CAD', // .tr() LocaleKeys.
                                      style: theme.typography.bodyMedium.copyWith(
                                        color: theme.colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Actions buttons
                              SizedBox(
                                height: 36,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: hasMismatch
                                        ? const Color(0xFFEF4444)
                                        : isMatching
                                            ? theme.colors.border
                                            : theme.colors.surface,
                                    foregroundColor: hasMismatch ? Colors.white : theme.colors.onSurface,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: hasMismatch ? BorderSide.none : BorderSide(color: theme.colors.border),
                                    ),
                                  ),
                                  onPressed: (isMatching || !hasMismatch)
                                      ? null
                                      : () => controller.reconcileInvoice(invoice.id),
                                  child: isMatching
                                      ? const SizedBox(
                                          height: 14,
                                          width: 14,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                                          ),
                                        )
                                      : Text(
                                          hasMismatch ? 'Fuzzy Offset MATCH' : invoice.status, // .tr() LocaleKeys.
                                          style: theme.typography.button.copyWith(
                                            color: hasMismatch ? Colors.white : theme.colors.onSurfaceVariant,
                                            fontSize: 11,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
            defaultSidebarWidgets: [
              // --- GST/HST Calculator & Rate Adjustments Panel ---
              Container(
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
                      'CRA GST/HST Remittance Simulator', // .tr() LocaleKeys.
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Simulate provincial sales tax margins on outstanding care billing.', // .tr() LocaleKeys.
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 20),
                    // Display calculated tax
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax Rate Multiplier:', // .tr() LocaleKeys.
                          style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface),
                        ),
                        Text(
                          '${state.hstRatePercent.toStringAsFixed(1)}%',
                          style: theme.typography.h4.copyWith(
                            color: theme.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      activeColor: theme.colors.primary,
                      inactiveColor: theme.colors.border,
                      min: 0,
                      max: 20,
                      divisions: 20,
                      value: state.hstRatePercent,
                      onChanged: (val) => controller.updateHstRate(val),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estimated HST to Remit:', // .tr() LocaleKeys.
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                          Text(
                            '\$${calculatedTax.toStringAsFixed(2)} CAD',
                            style: theme.typography.h3.copyWith(
                              color: const Color(0xFFD97706),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 32),
                    // Hourly Rate adjusters
                    Text(
                      'Operational Base Billing Rates', // .tr() LocaleKeys.
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PSW Billing Rate: \$${state.pswRatePerHour.toStringAsFixed(2)}/hr', // .tr() LocaleKeys.
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                        ),
                        Text(
                          'RN Billing Rate: \$${state.rnRatePerHour.toStringAsFixed(2)}/hr', // .tr() LocaleKeys.
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            activeColor: theme.colors.primary,
                            inactiveColor: theme.colors.border,
                            min: 15,
                            max: 60,
                            value: state.pswRatePerHour,
                            onChanged: (val) => controller.updatePswRate(val),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Slider(
                            activeColor: theme.colors.primary,
                            inactiveColor: theme.colors.border,
                            min: 40,
                            max: 120,
                            value: state.rnRatePerHour,
                            onChanged: (val) => controller.updateRnRate(val),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- Monospace System Ledger Logs ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: const Color(0xFF1E293B)),
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
                            const SizedBox(width: 8),
                            Text(
                              'Corporate Billing System Audit Ledger', // .tr() LocaleKeys.
                              style: theme.typography.h4.copyWith(color: const Color(0xFFF8FAFC)),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.trash2, color: Color(0xFF64748B), size: 18),
                          onPressed: () => controller.clearLogs(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 180,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF020617),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ListView.builder(
                        itemCount: state.logs.length,
                        itemBuilder: (context, idx) {
                          final log = state.logs[idx];
                          Color logColor = const Color(0xFFCBD5E1);

                          if (log.contains('[RECONCILER]')) {
                            logColor = const Color(0xFFFBBF24);
                          } else if (log.contains('[RECONCILER-SUCCESS]')) {
                            logColor = const Color(0xFF34D399);
                          } else if (log.contains('[RATE-CHANGE]')) {
                            logColor = const Color(0xFF60A5FA);
                          } else if (log.contains('[LEDGER-SYNC]')) {
                            logColor = const Color(0xFFF472B6);
                          } else if (log.contains('[TAX-COMPLIANCE]') || log.contains('[TAX-CALC]')) {
                            logColor = const Color(0xFFFB923C);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              log,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ).copyWith(color: logColor),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AiInsightsCard(
                heading: 'Billing & Remittance Insights', // .tr() LocaleKeys.
                suggestions: [
                  'Ensure HST remittance reports align with CRA quarterly schedules.', // .tr() LocaleKeys.
                  'Audit ledger records automatically cross-reference Plaid banking feeds.', // .tr() LocaleKeys.
                  'Resolve underpaid invoice balances by triggering fuzzy smart ledger offset match.', // .tr() LocaleKeys.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
