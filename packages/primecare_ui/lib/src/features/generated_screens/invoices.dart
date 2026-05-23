// Governance - Category: service | Purpose: Core implementation file for the Invoices platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class InvoicesState {
  final List<Map<String, dynamic>> invoices;
  final String searchQuery;
  final String selectedStatusFilter;
  final double totalInvoiced;
  final double totalCollected;
  final double totalOverdue;
  final bool isMutatingState;

  const InvoicesState({
    required this.invoices,
    required this.searchQuery,
    required this.selectedStatusFilter,
    required this.totalInvoiced,
    required this.totalCollected,
    required this.totalOverdue,
    required this.isMutatingState,
  });

  InvoicesState copyWith({
    List<Map<String, dynamic>>? invoices,
    String? searchQuery,
    String? selectedStatusFilter,
    double? totalInvoiced,
    double? totalCollected,
    double? totalOverdue,
    bool? isMutatingState,
  }) {
    return InvoicesState(
      invoices: invoices ?? this.invoices,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStatusFilter: selectedStatusFilter ?? this.selectedStatusFilter,
      totalInvoiced: totalInvoiced ?? this.totalInvoiced,
      totalCollected: totalCollected ?? this.totalCollected,
      totalOverdue: totalOverdue ?? this.totalOverdue,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class InvoicesController extends StateNotifier<InvoicesState> {
  final Ref _ref;

  InvoicesController(this._ref)
      : super(
          const InvoicesState(
            invoices: [
              {
                'id': 'INV-2026-001',
                'client': 'Arthur Pendelton',
                'amount': 2400.00,
                'dueDate': '2026-05-15',
                'status': 'Overdue',
              },
              {
                'id': 'INV-2026-002',
                'client': 'Emily Watson',
                'amount': 850.00,
                'dueDate': '2026-05-25',
                'status': 'Sent',
              },
              {
                'id': 'INV-2026-003',
                'client': 'Clara Higgins',
                'amount': 3200.00,
                'dueDate': '2026-05-20',
                'status': 'Paid',
              },
              {
                'id': 'INV-2026-004',
                'client': 'Eleanor Vance',
                'amount': 1500.00,
                'dueDate': '2026-06-01',
                'status': 'Draft',
              },
            ],
            searchQuery: '',
            selectedStatusFilter: 'All',
            totalInvoiced: 7950.00,
            totalCollected: 3200.00,
            totalOverdue: 2400.00,
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateStatusFilter(String filter) {
    state = state.copyWith(selectedStatusFilter: filter);
  }

  void downloadInvoicePdf(String invoiceId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/invoices',
            eventType: 'invoice_pdf_downloaded',
            metadata: {'invoiceId': invoiceId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      state = state.copyWith(isMutatingState: false);
    });
  }

  void markAsPaid(String invoiceId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/invoices',
            eventType: 'invoice_marked_paid',
            metadata: {'invoiceId': invoiceId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      double paidAmt = 0.0;
      final updated = state.invoices.map((inv) {
        if (inv['id'] == invoiceId) {
          paidAmt = inv['amount'] as double;
          return {
            ...inv,
            'status': 'Paid',
          };
        }
        return inv;
      }).toList();

      state = state.copyWith(
        invoices: updated,
        totalCollected: state.totalCollected + paidAmt,
        totalOverdue: state.totalOverdue - (invoiceId == 'INV-2026-001' ? paidAmt : 0.0),
        isMutatingState: false,
      );
    });
  }

  void runInvoiceGeneration() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/invoices',
            eventType: 'invoice_generation_run',
            metadata: {'operator': 'Billing Admin'},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      final updated = state.invoices.map((inv) {
        if (inv['status'] == 'Draft') {
          return {
            ...inv,
            'status': 'Sent',
          };
        }
        return inv;
      }).toList();

      state = state.copyWith(
        invoices: updated,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final invoicesControllerProvider =
    StateNotifierProvider<InvoicesController, InvoicesState>((ref) {
  return InvoicesController(ref);
});

// --- View ---
class Invoices extends GovernedConsumerWidget {
  const Invoices({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(invoicesControllerProvider);
    final controller = ref.read(invoicesControllerProvider.notifier);
    final theme = context.theme;

    // Filter invoices
    final filtered = state.invoices.where((inv) {
      final matchesSearch = (inv['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (inv['id'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesStatus = state.selectedStatusFilter == 'All' ||
          (inv['status'] as String).toLowerCase() == state.selectedStatusFilter.toLowerCase();
      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.fileSpreadsheet, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Patient Care Invoices',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.runInvoiceGeneration(),
              icon: const Icon(LucideIcons.play, size: 16),
              label: const Text('Publish Drafts'),
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
                  'Client Invoice Statements',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Generate statements for patient billing cycles, export PDF ledgers, and track collection rates.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Metrics summary
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Total Invoiced',
                        value: '\$${state.totalInvoiced.toStringAsFixed(2)}',
                        icon: LucideIcons.fileText,
                        iconColor: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Collected Revenue',
                        value: '\$${state.totalCollected.toStringAsFixed(2)}',
                        icon: LucideIcons.checkCircle2,
                        iconColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Overdue Balance',
                        value: '\$${state.totalOverdue.toStringAsFixed(2)}',
                        icon: LucideIcons.alertCircle,
                        iconColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search & Filter Bar
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by client or invoice ID...',
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
                        value: state.selectedStatusFilter,
                        onChanged: (val) {
                          if (val != null) controller.updateStatusFilter(val);
                        },
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All Statuses')),
                          DropdownMenuItem(value: 'Draft', child: Text('Draft')),
                          DropdownMenuItem(value: 'Sent', child: Text('Sent')),
                          DropdownMenuItem(value: 'Paid', child: Text('Paid')),
                          DropdownMenuItem(value: 'Overdue', child: Text('Overdue')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Invoices Card List
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            'No invoices match your active filters.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final inv = filtered[index];
                            final isDraft = inv['status'] == 'Draft';
                            final isPaid = inv['status'] == 'Paid';
                            final isOverdue = inv['status'] == 'Overdue';
                            final statusColor = isPaid
                                ? Colors.green
                                : isOverdue
                                    ? Colors.red
                                    : isDraft
                                        ? Colors.grey
                                        : Colors.blue;

                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              color: theme.colors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                side: BorderSide(color: theme.colors.border),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                (inv['id'] as String),
                                                style: theme.typography.h4.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme.colors.onSurface,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: statusColor.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  (inv['status'] as String).toUpperCase(),
                                                  style: TextStyle(
                                                    color: statusColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Client: ${inv['client']}',
                                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.calendar, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Due: ${inv['dueDate']}',
                                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                              ),
                                              const SizedBox(width: 24),
                                              Icon(LucideIcons.dollarSign, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Amount: \$${(inv['amount'] as double).toStringAsFixed(2)}',
                                                style: theme.typography.bodySmall.copyWith(
                                                  color: theme.colors.onSurface,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(LucideIcons.download),
                                          onPressed: () => controller.downloadInvoicePdf((inv['id'] as String)),
                                          tooltip: 'Download Invoice PDF',
                                        ),
                                        if (!isPaid) ...[
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () => controller.markAsPaid((inv['id'] as String)),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: theme.colors.primary,
                                              foregroundColor: Colors.white,
                                            ),
                                            child: const Text('Mark Paid'),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SummaryCard({
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
