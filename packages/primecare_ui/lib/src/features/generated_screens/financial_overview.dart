import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Governance - Category: view | Purpose: Core implementation file for the Financial Overview platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class FinancialOverviewState {
  final List<Map<String, dynamic>> ledger;
  final String searchQuery;
  final String activeCategoryFilter;
  final bool isSweepingPayroll;
  final bool isMutatingState;

  const FinancialOverviewState({
    required this.ledger,
    required this.searchQuery,
    required this.activeCategoryFilter,
    required this.isSweepingPayroll,
    required this.isMutatingState,
  });

  FinancialOverviewState copyWith({
    List<Map<String, dynamic>>? ledger,
    String? searchQuery,
    String? activeCategoryFilter,
    bool? isSweepingPayroll,
    bool? isMutatingState,
  }) {
    return FinancialOverviewState(
      ledger: ledger ?? this.ledger,
      searchQuery: searchQuery ?? this.searchQuery,
      activeCategoryFilter: activeCategoryFilter ?? this.activeCategoryFilter,
      isSweepingPayroll: isSweepingPayroll ?? this.isSweepingPayroll,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class FinancialOverviewController extends StateNotifier<FinancialOverviewState> {
  final Ref ref;
  final Ref _ref;

  FinancialOverviewController(this._ref)
      : super(
          const FinancialOverviewState(
            ledger: [
              {
                'id': 'txn-201',
                'description': 'Private Pay Sweep: Client Roster',
                'amount': 45200.0,
                'type': 'inflow',
                'category': 'Private Pay',
                'date': '2026-05-19',
                'status': 'Reconciled',
              },
              {
                'id': 'txn-202',
                'description': 'Caregiver Bi-weekly Payroll ACH',
                'amount': -31450.0,
                'type': 'outflow',
                'category': 'Payroll',
                'date': '2026-05-18',
                'status': 'Completed',
              },
              {
                'id': 'txn-203',
                'description': 'Gov Insurance Claim #CL-990812',
                'amount': 18750.0,
                'type': 'inflow',
                'category': 'Claims',
                'date': '2026-05-17',
                'status': 'Pending',
              },
              {
                'id': 'txn-204',
                'description': 'Office Lease & Facility Remittance',
                'amount': -4200.0,
                'type': 'outflow',
                'category': 'Expense',
                'date': '2026-05-15',
                'status': 'Completed',
              },
            ],
            searchQuery: '',
            activeCategoryFilter: 'all',
            isSweepingPayroll: false,
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateCategoryFilter(String filter) {
    state = state.copyWith(activeCategoryFilter: filter);
  }

  void executePayrollSweep() {
    state = state.copyWith(isSweepingPayroll: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/financial_overview',
            eventType: 'financial_payroll_sweep_executed',
            metadata: {'timestamp': DateTime.now().toIso8601String()},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1500), () {
      final newTxn = {
        'id': 'txn-${DateTime.now().millisecondsSinceEpoch}',
        'description': 'Immediate Payroll Dispatch (COO Approved)',
        'amount': -15400.0,
        'type': 'outflow',
        'category': 'Payroll',
        'date': DateTime.now().toString().substring(0, 10),
        'status': 'Completed',
      };

      state = state.copyWith(
        ledger: [newTxn, ...state.ledger],
        isSweepingPayroll: false,
      );
    });
  }
}

// --- Provider ---
final financialOverviewControllerProvider =
    StateNotifierProvider<FinancialOverviewController, FinancialOverviewState>((ref) {
  return FinancialOverviewController(ref);
});

// --- View ---
class FinancialOverview extends GovernedConsumerWidget {
  const FinancialOverview({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financialOverviewControllerProvider);
    final controller = ref.read(financialOverviewControllerProvider.notifier);
    final theme = context.theme;

    // Filter transactions
    final filteredTransactions = state.ledger.where((t) {
      final matchesSearch = (t['description'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (t['category'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesFilter = state.activeCategoryFilter == 'all' ||
          (t['category'] as String).toLowerCase() == state.activeCategoryFilter.toLowerCase();
      return matchesSearch && matchesFilter;
    }).toList();

    // Summary math
    double totalInflow = 0;
    double totalOutflow = 0;
    for (final txn in state.ledger) {
      final amt = txn['amount'] as double;
      if (amt > 0) {
        totalInflow += amt;
      } else {
        totalOutflow += amt.abs();
      }
    }
    final netFlow = totalInflow - totalOutflow;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.barChart, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'CFO Corporate Ledger Command',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
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
                          'Cash Flow & Reserves',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Review financial inflows, trigger immediate payroll ACH sweeps, and reconcile claims.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: state.isSweepingPayroll ? null : controller.executePayrollSweep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                        ),
                      ),
                      icon: const Icon(LucideIcons.wallet, size: 18),
                      label: Text(
                        state.isSweepingPayroll ? 'Sweeping...' : 'Trigger Payroll Sweep',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Total Inflow',
                        value: '\$${totalInflow.toStringAsFixed(0)}',
                        icon: LucideIcons.trendingUp,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'Total Outflow',
                        value: '-\$${totalOutflow.toStringAsFixed(0)}',
                        icon: LucideIcons.trendingDown,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'Net Profit Margin',
                        value: '\$${netFlow.toStringAsFixed(0)}',
                        icon: LucideIcons.dollarSign,
                        color: theme.colors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Controls
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(key: const Key('financial_overview_textfield_input_1'), 
                          decoration: InputDecoration(
                            hintText: 'Search private pay, payroll, or expenses...',
                            prefixIcon: const Icon(LucideIcons.search, size: 20),
                            fillColor: theme.colors.background,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              borderSide: BorderSide(color: theme.colors.border),
                            ),
                          ),
                          onChanged: controller.updateSearch,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          _FilterButton(
                            label: 'All Items',
                            value: 'all',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                          _FilterButton(
                            label: 'Payroll',
                            value: 'payroll',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                          _FilterButton(
                            label: 'Private Pay',
                            value: 'private pay',
                            activeValue: state.activeCategoryFilter,
                            onTap: controller.updateCategoryFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Transactions list
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final txn = filteredTransactions[index];
                      final isOutflow = (txn['amount'] as double) < 0;
                      final amountText = isOutflow
                          ? '-\$${(txn['amount'] as double).abs().toStringAsFixed(2)}'
                          : '+\$${(txn['amount'] as double).toStringAsFixed(2)}';
                      final color = isOutflow ? Colors.red : Colors.green;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: color.withValues(alpha: 0.1),
                              child: Icon(
                                isOutflow ? LucideIcons.arrowUpRight : LucideIcons.arrowDownLeft,
                                color: color,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (txn['description'] as String),
                                    style: theme.typography.h4.copyWith(
                                      color: theme.colors.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Date: ${txn['date']} • Category: ${txn['category']}',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ),
                            // Status Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              margin: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Text(
                                (txn['status'] as String),
                                style: theme.typography.bodyMedium.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            // Amount
                            Text(
                              amountText,
                              style: theme.typography.h4.copyWith(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (state.isSweepingPayroll)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusLg),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Executing Corporate Payroll Sweep...',
                        style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Transmitting secure bank ACH instructions...',
                        style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterButton({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: isActive ? theme.colors.primary : theme.colors.border),
        ),
        child: Text(
          label,
          style: theme.typography.bodyMedium.copyWith(
            color: isActive ? Colors.white : theme.colors.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
