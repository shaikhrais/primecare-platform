// Governance - Category: service | Purpose: Core implementation file for the Revenue Tracker platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RevenueTrackerState {
  final List<Map<String, dynamic>> invoices;
  final String searchQuery;
  final String activeStatusFilter;
  final double minAmountFilter;
  final bool isReconciling;
  final String? reconcilingInvoiceId;

  const RevenueTrackerState({
    required this.invoices,
    required this.searchQuery,
    required this.activeStatusFilter,
    required this.minAmountFilter,
    required this.isReconciling,
    this.reconcilingInvoiceId,
  });

  RevenueTrackerState copyWith({
    List<Map<String, dynamic>>? invoices,
    String? searchQuery,
    String? activeStatusFilter,
    double? minAmountFilter,
    bool? isReconciling,
    String? reconcilingInvoiceId,
  }) {
    return RevenueTrackerState(
      invoices: invoices ?? this.invoices,
      searchQuery: searchQuery ?? this.searchQuery,
      activeStatusFilter: activeStatusFilter ?? this.activeStatusFilter,
      minAmountFilter: minAmountFilter ?? this.minAmountFilter,
      isReconciling: isReconciling ?? this.isReconciling,
      reconcilingInvoiceId: reconcilingInvoiceId ?? this.reconcilingInvoiceId,
    );
  }
}

// --- Controller ---
class RevenueTrackerController extends StateNotifier<RevenueTrackerState> {
  final Ref _ref;

  RevenueTrackerController(this._ref)
      : super(
          const RevenueTrackerState(
            invoices: [
              {
                'id': 'INV-4001',
                'client': 'Aria Vance',
                'amount': 2450.00,
                'status': 'Pending Reimbursement',
                'date': '2026-05-18',
                'insurance': 'Blue Shield Medicare',
                'reconciliationCode': 'BSM-9921',
              },
              {
                'id': 'INV-4002',
                'client': 'Caleb Brooks',
                'amount': 1890.00,
                'status': 'Reconciled',
                'date': '2026-05-17',
                'insurance': 'Aetna Care',
                'reconciliationCode': 'AET-1102',
              },
              {
                'id': 'INV-4003',
                'client': 'Diana Prince',
                'amount': 3200.00,
                'status': 'Pending Reimbursement',
                'date': '2026-05-16',
                'insurance': 'UnitedHealth Group',
                'reconciliationCode': 'UHG-8843',
              },
              {
                'id': 'INV-4004',
                'client': 'Ethan Hunt',
                'amount': 850.00,
                'status': 'Unsubmitted',
                'date': '2026-05-15',
                'insurance': 'Private Pay / Cash',
                'reconciliationCode': 'CASH-002',
              },
              {
                'id': 'INV-4005',
                'client': 'Fiona Gallagher',
                'amount': 4120.00,
                'status': 'Reconciled',
                'date': '2026-05-12',
                'insurance': 'Blue Shield Medicare',
                'reconciliationCode': 'BSM-9912',
              },
            ],
            searchQuery: '',
            activeStatusFilter: 'all',
            minAmountFilter: 0.0,
            isReconciling: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateStatusFilter(String filter) {
    state = state.copyWith(activeStatusFilter: filter);
  }

  void updateMinAmountFilter(double amount) {
    state = state.copyWith(minAmountFilter: amount);
  }

  void reconcileInvoice(String id) {
    state = state.copyWith(isReconciling: true, reconcilingInvoiceId: id);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/revenue_tracker',
            eventType: 'revenue_invoice_reconciliation_triggered',
            metadata: {
              'invoice_id': id,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1200), () {
      final updated = state.invoices.map((inv) {
        if (inv['id'] == id) {
          return {
            ...inv,
            'status': 'Reconciled',
          };
        }
        return inv;
      }).toList();

      state = state.copyWith(
        invoices: updated,
        isReconciling: false,
        reconcilingInvoiceId: null,
      );
    });
  }
}

// --- Provider ---
final revenueTrackerControllerProvider =
    StateNotifierProvider<RevenueTrackerController, RevenueTrackerState>((ref) {
  return RevenueTrackerController(ref);
});

// --- View ---
class RevenueTracker extends GovernedConsumerWidget {
  const RevenueTracker({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(revenueTrackerControllerProvider);
    final controller = ref.read(revenueTrackerControllerProvider.notifier);
    final theme = context.theme;

    // Filtering logic
    final filteredInvoices = state.invoices.where((inv) {
      final matchesSearch = (inv['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (inv['id'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (inv['insurance'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesStatus = state.activeStatusFilter == 'all' ||
          (inv['status'] as String).toLowerCase() == state.activeStatusFilter.toLowerCase();
      final matchesAmount = (inv['amount'] as double) >= state.minAmountFilter;
      return matchesSearch && matchesStatus && matchesAmount;
    }).toList();

    // Stats calculations
    double totalClaims = 0;
    double totalReconciled = 0;
    double totalPending = 0;
    for (final inv in state.invoices) {
      final amt = inv['amount'] as double;
      totalClaims += amt;
      if (inv['status'] == 'Reconciled') {
        totalReconciled += amt;
      } else {
        totalPending += amt;
      }
    }

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
              'CFO Revenue & Claims Ledger',
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
                          'Revenue Tracker',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Audit patient invoices, track private insurance payouts, and execute real-time reconciliation pools.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Stats row
                Row(
                  children: [
                    Expanded(
                      child: _AnalyticsCard(
                        title: 'Aggregate Outstanding',
                        value: '\$${totalClaims.toStringAsFixed(0)}',
                        icon: LucideIcons.layers,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnalyticsCard(
                        title: 'Reconciled Payouts',
                        value: '\$${totalReconciled.toStringAsFixed(0)}',
                        icon: LucideIcons.checkCircle2,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnalyticsCard(
                        title: 'Pending Insurance',
                        value: '\$${totalPending.toStringAsFixed(0)}',
                        icon: LucideIcons.helpCircle,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Filters panel
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search by client, invoice ID, or insurer...',
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
                              _FilterChip(
                                label: 'All Statuses',
                                value: 'all',
                                activeValue: state.activeStatusFilter,
                                onTap: controller.updateStatusFilter,
                              ),
                              _FilterChip(
                                label: 'Pending Payout',
                                value: 'pending reimbursement',
                                activeValue: state.activeStatusFilter,
                                onTap: controller.updateStatusFilter,
                              ),
                              _FilterChip(
                                label: 'Reconciled',
                                value: 'reconciled',
                                activeValue: state.activeStatusFilter,
                                onTap: controller.updateStatusFilter,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(LucideIcons.sliders, size: 18, color: theme.colors.onSurfaceVariant),
                          const SizedBox(width: 12),
                          Text(
                            'Minimum Invoice Threshold: \$${state.minAmountFilter.toInt()}',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Slider(
                              value: state.minAmountFilter,
                              min: 0.0,
                              max: 5000.0,
                              divisions: 10,
                              activeColor: theme.colors.primary,
                              onChanged: controller.updateMinAmountFilter,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Invoice Ledger Roster
                Expanded(
                  child: filteredInvoices.isEmpty
                      ? Center(
                          child: Text(
                            'No invoices matching the selected criteria.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredInvoices.length,
                          itemBuilder: (context, index) {
                            final inv = filteredInvoices[index];
                            final id = inv['id'] as String;
                            final status = inv['status'] as String;
                            final isPending = status == 'Pending Reimbursement';
                            final isReconciled = status == 'Reconciled';
                            final statusColor = isReconciled
                                ? Colors.green
                                : isPending
                                    ? Colors.amber
                                    : Colors.grey;

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
                                    backgroundColor: statusColor.withValues(alpha: 0.1),
                                    child: Icon(
                                      isReconciled ? LucideIcons.check : LucideIcons.clock,
                                      color: statusColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              (inv['client'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '($id)',
                                              style: theme.typography.bodySmall.copyWith(
                                                color: theme.colors.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Carrier: ${inv['insurance']} • Reconciliation Code: ${inv['reconciliationCode']} • Date: ${inv['date']}',
                                          style: theme.typography.bodyMedium.copyWith(
                                            color: theme.colors.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '\$${(inv['amount'] as double).toStringAsFixed(2)}',
                                    style: theme.typography.h3.copyWith(
                                      color: theme.colors.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  if (isPending)
                                    ElevatedButton(
                                      onPressed: state.isReconciling ? null : () => controller.reconcileInvoice(id),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colors.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(theme.radiusMd),
                                        ),
                                      ),
                                      child: const Text('Reconcile'),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(theme.radiusMd),
                                        border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                                      ),
                                      child: Text(
                                        status,
                                        style: theme.typography.bodySmall.copyWith(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
                                        ),
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
          if (state.isReconciling)
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              child: Center(
                child: Card(
                  color: theme.colors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(theme.radiusLg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Validating Insurance Clearinghouse Handshake...',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Transmitting secure claims reconciliation tokens to carrier database...',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _AnalyticsCard({
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

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;

    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      selectedColor: theme.colors.primary.withValues(alpha: 0.2),
      backgroundColor: theme.colors.surface,
      labelStyle: TextStyle(
        color: isActive ? theme.colors.primary : theme.colors.onSurface,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(
          color: isActive ? theme.colors.primary : theme.colors.border,
        ),
      ),
      onSelected: (val) {
        if (val) onTap(value);
      },
    );
  }
}
