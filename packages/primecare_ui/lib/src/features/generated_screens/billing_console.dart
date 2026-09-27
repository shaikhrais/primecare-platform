import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Governance - Category: service | Purpose: Core implementation file for the Billing Console platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class BillingConsoleState {
  final List<Map<String, dynamic>> transactions;
  final String searchQuery;
  final String selectedTypeFilter;
  final double totalOutstanding;
  final int pendingSweepsCount;
  final bool isMutatingState;

  const BillingConsoleState({
    required this.transactions,
    required this.searchQuery,
    required this.selectedTypeFilter,
    required this.totalOutstanding,
    required this.pendingSweepsCount,
    required this.isMutatingState,
  });

  BillingConsoleState copyWith({
    List<Map<String, dynamic>>? transactions,
    String? searchQuery,
    String? selectedTypeFilter,
    double? totalOutstanding,
    int? pendingSweepsCount,
    bool? isMutatingState,
  }) {
    return BillingConsoleState(
      transactions: transactions ?? this.transactions,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTypeFilter: selectedTypeFilter ?? this.selectedTypeFilter,
      totalOutstanding: totalOutstanding ?? this.totalOutstanding,
      pendingSweepsCount: pendingSweepsCount ?? this.pendingSweepsCount,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class BillingConsoleController extends StateNotifier<BillingConsoleState> {
  final Ref ref;
  final Ref _ref;

  BillingConsoleController(this._ref)
      : super(
          const BillingConsoleState(
            transactions: [
              {
                'id': 'tx-801',
                'client': 'Arthur Pendelton',
                'amount': 1250.00,
                'type': 'Medicaid Claim',
                'date': '2026-05-18',
                'status': 'Pending Audit',
              },
              {
                'id': 'tx-802',
                'client': 'Emily Watson',
                'amount': 450.00,
                'type': 'Private Pay',
                'date': '2026-05-19',
                'status': 'Pending Sweep',
              },
              {
                'id': 'tx-803',
                'client': 'Clara Higgins',
                'amount': 2100.00,
                'type': 'LTC Insurance',
                'date': '2026-05-17',
                'status': 'Approved',
              },
              {
                'id': 'tx-804',
                'client': 'James Anderson',
                'amount': 890.00,
                'type': 'Private Pay',
                'date': '2026-05-16',
                'status': 'Cleared',
              },
            ],
            searchQuery: '',
            selectedTypeFilter: 'All',
            totalOutstanding: 3800.00,
            pendingSweepsCount: 2,
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateTypeFilter(String filter) {
    state = state.copyWith(selectedTypeFilter: filter);
  }

  void triggerSweep() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/billing_console',
            eventType: 'private_pay_sweep_triggered',
            metadata: {'trigger': 'Billing Admin Console Panel'},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 500), () {
      final updated = state.transactions.map((tx) {
        if (tx['status'] == 'Pending Sweep') {
          return {
            ...tx,
            'status': 'Cleared',
          };
        }
        return tx;
      }).toList();

      state = state.copyWith(
        transactions: updated,
        pendingSweepsCount: 0,
        totalOutstanding: state.totalOutstanding - 450.00,
        isMutatingState: false,
      );
    });
  }

  void approveTransaction(String id) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/billing_console',
            eventType: 'billing_transaction_approved',
            metadata: {'transactionId': id},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.transactions.map((tx) {
        if (tx['id'] == id) {
          return {
            ...tx,
            'status': 'Approved',
          };
        }
        return tx;
      }).toList();

      state = state.copyWith(
        transactions: updated,
        isMutatingState: false,
      );
    });
  }

  void createPrivateInvoice({
    required String clientName,
    required double amount,
  }) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/billing_console',
            eventType: 'private_pay_invoice_created',
            metadata: {'client': clientName, 'amount': amount},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final nextTx = {
        'id': 'tx-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        'client': clientName,
        'amount': amount,
        'type': 'Private Pay',
        'date': DateTime.now().toString().substring(0, 10),
        'status': 'Pending Sweep',
      };

      state = state.copyWith(
        transactions: [nextTx, ...state.transactions],
        pendingSweepsCount: state.pendingSweepsCount + 1,
        totalOutstanding: state.totalOutstanding + amount,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final billingConsoleControllerProvider =
    StateNotifierProvider<BillingConsoleController, BillingConsoleState>((ref) {
  return BillingConsoleController(ref);
});

// --- View ---
class BillingConsole extends GovernedConsumerWidget {
  const BillingConsole({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billingConsoleControllerProvider);
    final controller = ref.read(billingConsoleControllerProvider.notifier);
    final theme = context.theme;

    // Filter transactions
    final filtered = state.transactions.where((tx) {
      final matchesSearch = (tx['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (tx['id'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesType = state.selectedTypeFilter == 'All' ||
          (tx['type'] as String).toLowerCase() == state.selectedTypeFilter.toLowerCase();
      return matchesSearch && matchesType;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.landmark, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Billing Admin Console',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          if (state.pendingSweepsCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: ElevatedButton.icon(
                onPressed: () => controller.triggerSweep(),
                icon: const Icon(LucideIcons.refreshCw, size: 16),
                label: Text('Sweep Private Pay (${state.pendingSweepsCount})'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Claims, Clearinghouse & Invoices Ledger',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Audit electronic insurance claims, trigger automatic ACH sweeps, and draft client pay ledgers.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'Outstanding Ledger Balance',
                        value: '\$${state.totalOutstanding.toStringAsFixed(2)}',
                        icon: LucideIcons.dollarSign,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Pending ACH Sweeps',
                        value: '${state.pendingSweepsCount}',
                        icon: LucideIcons.arrowUpDown,
                        iconColor: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Active Accounts',
                        value: '${state.transactions.length}',
                        icon: LucideIcons.users,
                        iconColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search & Filter Box
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
                        child: TextField(key: const Key('billing_console_textfield_input_1'), 
                          decoration: InputDecoration(
                            hintText: 'Search by client name or transaction ID...',
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
                      DropdownButton<String>(
                        value: state.selectedTypeFilter,
                        onChanged: (val) {
                          if (val != null) controller.updateTypeFilter(val);
                        },
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All Types')),
                          DropdownMenuItem(value: 'Private Pay', child: Text('Private Pay')),
                          DropdownMenuItem(value: 'Medicaid Claim', child: Text('Medicaid Claim')),
                          DropdownMenuItem(value: 'LTC Insurance', child: Text('LTC Insurance')),
                        ],
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(key: const Key('billing_console_elevatedbutton_button_1'), 
                        onPressed: () => _showCreateInvoiceDialog(context, controller),
                        child: const Text('New Private Pay'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Transactions Table List
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      children: [
                        // Table Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: theme.colors.background,
                          child: const Row(
                            children: [
                              Expanded(flex: 2, child: Text('Transaction ID', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 3, child: Text('Client', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                        Divider(height: 1, color: theme.colors.border),
                        // Table Body
                        Expanded(
                          child: filtered.isEmpty
                              ? Center(
                                  child: Text(
                                    'No records found.',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: filtered.length,
                                  separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                                  itemBuilder: (context, index) {
                                    final tx = filtered[index];
                                    final isPendingSweep = tx['status'] == 'Pending Sweep';
                                    final isPendingAudit = tx['status'] == 'Pending Audit';
                                    final statusColor = tx['status'] == 'Cleared'
                                        ? Colors.green
                                        : isPendingSweep
                                            ? Colors.orange
                                            : isPendingAudit
                                                ? Colors.red
                                                : Colors.blue;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              (tx['id'] as String),
                                              style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(flex: 3, child: Text((tx['client'] as String))),
                                          Expanded(flex: 2, child: Text((tx['type'] as String))),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '\$${(tx['amount'] as double).toStringAsFixed(2)}',
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    color: statusColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  (tx['status'] as String),
                                                  style: TextStyle(
                                                    color: statusColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                if (isPendingAudit)
                                                  TextButton(key: const Key('billing_console_textbutton_button_1'), 
                                                    onPressed: () => controller.approveTransaction((tx['id'] as String)),
                                                    child: const Text('Approve'),
                                                  )
                                                else if (isPendingSweep)
                                                  TextButton(key: const Key('billing_console_textbutton_button_2'), 
                                                    onPressed: () => controller.triggerSweep(),
                                                    child: const Text('Sweep'),
                                                  )
                                                else
                                                  const Icon(LucideIcons.check, size: 16, color: Colors.green),
                                              ],
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
                ),
              ],
            ),
          ),
          if (state.isMutatingState)
            Container(
              color: Colors.black.withValues(alpha: 0.15),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _showCreateInvoiceDialog(BuildContext context, BillingConsoleController controller) {
    final theme = context.theme;
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colors.surface,
          title: Text(
            'Draft Private Pay Ledger Entry',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(key: const Key('billing_console_textfield_input_2'), 
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Client Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(key: const Key('billing_console_textfield_input_3'), 
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Billing Amount (\$)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(key: const Key('billing_console_textbutton_button_3'), 
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: theme.colors.onSurfaceVariant)),
            ),
            ElevatedButton(key: const Key('billing_console_elevatedbutton_button_2'), 
              onPressed: () {
                final amt = double.tryParse(amountController.text) ?? 0.0;
                if (nameController.text.isNotEmpty && amt > 0) {
                  controller.createPrivateInvoice(clientName: nameController.text, amount: amt);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
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
