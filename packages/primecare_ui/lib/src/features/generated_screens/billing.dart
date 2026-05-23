// Governance - Category: service | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class BillingInvoice {
  final String id;
  final String date;
  final String dueDate;
  final double amount;
  final String status; // 'paid', 'pending', 'overdue'
  final String description;

  const BillingInvoice({
    required this.id,
    required this.date,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.description,
  });

  BillingInvoice copyWith({
    String? id,
    String? date,
    String? dueDate,
    double? amount,
    String? status,
    String? description,
  }) {
    return BillingInvoice(
      id: id ?? this.id,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}

class BillingState {
  final double outstandingBalance;
  final double lastPaymentReceived;
  final double annualCareExpenditures;
  final List<BillingInvoice> invoices;
  final bool paymentPending;
  final bool showSuccess;
  final String? processedInvoiceId;

  const BillingState({
    required this.outstandingBalance,
    required this.lastPaymentReceived,
    required this.annualCareExpenditures,
    required this.invoices,
    required this.paymentPending,
    required this.showSuccess,
    this.processedInvoiceId,
  });

  BillingState copyWith({
    double? outstandingBalance,
    double? lastPaymentReceived,
    double? annualCareExpenditures,
    List<BillingInvoice>? invoices,
    bool? paymentPending,
    bool? showSuccess,
    String? processedInvoiceId,
  }) {
    return BillingState(
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      lastPaymentReceived: lastPaymentReceived ?? this.lastPaymentReceived,
      annualCareExpenditures: annualCareExpenditures ?? this.annualCareExpenditures,
      invoices: invoices ?? this.invoices,
      paymentPending: paymentPending ?? this.paymentPending,
      showSuccess: showSuccess ?? this.showSuccess,
      processedInvoiceId: processedInvoiceId ?? this.processedInvoiceId,
    );
  }
}

// --- Controller ---
class BillingController extends StateNotifier<BillingState> {
  final Ref _ref;

  BillingController(this._ref)
      : super(
          const BillingState(
            outstandingBalance: 340.00,
            lastPaymentReceived: 1250.00,
            annualCareExpenditures: 14890.00,
            invoices: [
              BillingInvoice(
                id: 'INV-2026-004',
                date: 'May 12, 2026',
                dueDate: 'May 26, 2026',
                amount: 340.00,
                status: 'pending',
                description: 'Personal Support Worker (PSW) Care - 12 hours of specialized clinical home assistance, arterial pressure monitoring, and meal preparation assistance.',
              ),
              BillingInvoice(
                id: 'INV-2026-003',
                date: 'Apr 28, 2026',
                dueDate: 'May 12, 2026',
                amount: 850.00,
                status: 'paid',
                description: 'Physiotherapist Specialized Rehabilitation Session - 4 hours of clinical kinetic recovery guidance, walking assistance training, and progress assessment.',
              ),
              BillingInvoice(
                id: 'INV-2026-002',
                date: 'Apr 14, 2026',
                dueDate: 'Apr 28, 2026',
                amount: 400.00,
                status: 'paid',
                description: 'RN Nurse Coordination Check-in - Clinical screening, cognitive score logging, medication revision, and supervisory care coordination.',
              ),
              BillingInvoice(
                id: 'INV-2026-001',
                date: 'Mar 30, 2026',
                dueDate: 'Apr 13, 2026',
                amount: 520.00,
                status: 'paid',
                description: 'Personal Support Worker (PSW) Intake & ADL Assessment - Initial household onboarding, patient safety environment configuration, and scheduling planning.',
              ),
            ],
            paymentPending: false,
            showSuccess: false,
          ),
        );

  void payInvoice(String invoiceId) {
    state = state.copyWith(paymentPending: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/client_payments',
            eventType: 'billing_payment_initiated',
            metadata: {'invoiceId': invoiceId},
          );
    } catch (_) {}

    // Simulate Payment Processing
    Future.delayed(const Duration(milliseconds: 1200), () {
      final updatedInvoices = state.invoices.map((inv) {
        if (inv.id == invoiceId) {
          return inv.copyWith(status: 'paid');
        }
        return inv;
      }).toList();

      final paidInvoice = state.invoices.firstWhere((inv) => inv.id == invoiceId);
      final double newOutstanding = state.outstandingBalance - paidInvoice.amount;
      final double newLastPayment = paidInvoice.amount;
      final double newAnnualSpend = state.annualCareExpenditures + paidInvoice.amount;

      state = state.copyWith(
        invoices: updatedInvoices,
        outstandingBalance: newOutstanding < 0 ? 0.0 : newOutstanding,
        lastPaymentReceived: newLastPayment,
        annualCareExpenditures: newAnnualSpend,
        paymentPending: false,
        showSuccess: true,
        processedInvoiceId: invoiceId,
      );

      try {
        _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
              route: '/generated/client_payments',
              eventType: 'billing_payment_completed',
              metadata: {
                'invoiceId': invoiceId,
                'amount': paidInvoice.amount,
                'status': 'success',
              },
            );
      } catch (_) {}
    });
  }

  void dismissSuccess() {
    state = state.copyWith(showSuccess: false, processedInvoiceId: null);
  }

  void logInvoiceViewed(String invoiceId) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/client_payments',
            eventType: 'billing_invoice_details_viewed',
            metadata: {'invoiceId': invoiceId},
          );
    } catch (_) {}
  }
}

// --- Provider ---
final billingControllerProvider =
    StateNotifierProvider<BillingController, BillingState>((ref) {
  return BillingController(ref);
});

// --- View ---
class Billing extends GovernedConsumerWidget {
  const Billing({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billingControllerProvider);
    final controller = ref.read(billingControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.creditCard, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Billing & Invoices',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Notification Header
            if (state.showSuccess)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.checkSquare, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Payment for ${state.processedInvoiceId} was successfully processed and receipt generated!',
                        style: theme.typography.bodyMedium.copyWith(color: Colors.green.shade800),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x, size: 16, color: Colors.green),
                      onPressed: controller.dismissSuccess,
                    ),
                  ],
                ),
              ),

            // Financial KPIs
            Text(
              'Financial Summary',
              style: theme.typography.h3,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth < 600;

                if (isMobile) {
                  return Column(
                    children: [
                      _buildKPICard(
                        context,
                        title: 'Outstanding Balance',
                        value: '\$${state.outstandingBalance.toStringAsFixed(2)}',
                        icon: LucideIcons.wallet,
                        accentColor: state.outstandingBalance > 0
                            ? Colors.amber.shade700
                            : Colors.green.shade700,
                        backgroundColor: state.outstandingBalance > 0
                            ? Colors.amber.shade50
                            : Colors.green.shade50,
                      ),
                      const SizedBox(height: 12),
                      _buildKPICard(
                        context,
                        title: 'Last Payment',
                        value: '\$${state.lastPaymentReceived.toStringAsFixed(2)}',
                        icon: LucideIcons.badgeCheck,
                        accentColor: theme.colors.primary,
                        backgroundColor: theme.colors.primary.withValues(alpha: 0.05),
                      ),
                      const SizedBox(height: 12),
                      _buildKPICard(
                        context,
                        title: 'Annual Expenditures',
                        value: '\$${state.annualCareExpenditures.toStringAsFixed(2)}',
                        icon: LucideIcons.trendingUp,
                        accentColor: theme.colors.secondary,
                        backgroundColor: theme.colors.secondary.withValues(alpha: 0.05),
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _buildKPICard(
                        context,
                        title: 'Outstanding Balance',
                        value: '\$${state.outstandingBalance.toStringAsFixed(2)}',
                        icon: LucideIcons.wallet,
                        accentColor: state.outstandingBalance > 0
                            ? Colors.amber.shade700
                            : Colors.green.shade700,
                        backgroundColor: state.outstandingBalance > 0
                            ? Colors.amber.shade50
                            : Colors.green.shade50,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildKPICard(
                        context,
                        title: 'Last Payment',
                        value: '\$${state.lastPaymentReceived.toStringAsFixed(2)}',
                        icon: LucideIcons.badgeCheck,
                        accentColor: theme.colors.primary,
                        backgroundColor: theme.colors.primary.withValues(alpha: 0.05),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildKPICard(
                        context,
                        title: 'Annual Expenditures',
                        value: '\$${state.annualCareExpenditures.toStringAsFixed(2)}',
                        icon: LucideIcons.trendingUp,
                        accentColor: theme.colors.secondary,
                        backgroundColor: theme.colors.secondary.withValues(alpha: 0.05),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            // Invoices Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Invoices Ledger',
                  style: theme.typography.h3,
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.download, size: 16),
                  label: Text('Export Statements', style: theme.typography.bodySmall),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Invoices Ledger List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.invoices.length,
              itemBuilder: (context, index) {
                final invoice = state.invoices[index];
                final isPaid = invoice.status == 'paid';

                Color badgeColor = Colors.amber.shade700;
                Color badgeBg = Colors.amber.shade50;
                if (isPaid) {
                  badgeColor = Colors.green.shade700;
                  badgeBg = Colors.green.shade50;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.divider),
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
                              const Icon(LucideIcons.fileSpreadsheet, size: 20, color: Colors.blueGrey),
                              const SizedBox(width: 12),
                              Text(
                                invoice.id,
                                style: theme.typography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(theme.radiusFull),
                            ),
                            child: Text(
                              invoice.status.toUpperCase(),
                              style: theme.typography.bodySmall.copyWith(
                                color: badgeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        invoice.description,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Due Date: ${invoice.dueDate}',
                                style: theme.typography.bodySmall.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${invoice.amount.toStringAsFixed(2)} CAD',
                                style: theme.typography.h3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  side: BorderSide(color: theme.colors.divider),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(theme.radiusDefault),
                                  ),
                                ),
                                onPressed: () {
                                  controller.logInvoiceViewed(invoice.id);
                                  _showInvoiceDetailSheet(context, invoice);
                                },
                                child: Text('View Details', style: theme.typography.bodySmall),
                              ),
                              if (!isPaid) ...[
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colors.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(theme.radiusDefault),
                                    ),
                                  ),
                                  onPressed: state.paymentPending
                                      ? null
                                      : () => _showCheckoutSheet(context, invoice, controller, state.paymentPending),
                                  child: const Text('Pay Now'),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color accentColor,
    required Color backgroundColor,
  }) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: theme.typography.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInvoiceDetailSheet(
    BuildContext context,
    BillingInvoice invoice,
  ) {
    final theme = context.theme;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Invoice Detailed Statement', style: theme.typography.h3),
                  Text(
                    invoice.status.toUpperCase(),
                    style: theme.typography.bodySmall.copyWith(
                      color: invoice.status == 'paid' ? Colors.green.shade700 : Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              _buildDetailRow(context, 'Invoice ID', invoice.id),
              _buildDetailRow(context, 'Issued Date', invoice.date),
              _buildDetailRow(context, 'Due Date', invoice.dueDate),
              _buildDetailRow(context, 'Description of Services', invoice.description),
              _buildDetailRow(context, 'Subtotal', '\$${(invoice.amount * 0.88).toStringAsFixed(2)} CAD'),
              _buildDetailRow(context, 'Taxes (HST 13%)', '\$${(invoice.amount * 0.12).toStringAsFixed(2)} CAD'),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount Due', style: theme.typography.labelBold),
                  Text(
                    '\$${invoice.amount.toStringAsFixed(2)} CAD',
                    style: theme.typography.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colors.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(theme.radiusDefault),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close Statement', style: theme.typography.labelBold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: theme.typography.bodySmall.copyWith(
                color: theme.colors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutSheet(
    BuildContext context,
    BillingInvoice invoice,
    BillingController controller,
    bool isPending,
  ) {
    final theme = context.theme;
    final cardNumberController = TextEditingController(text: '4532 •••• •••• 8824');
    final expiryController = TextEditingController(text: '12/29');
    final cvcController = TextEditingController(text: '***');

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
              ),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(LucideIcons.shieldCheck, color: theme.colors.primary, size: 24),
                      const SizedBox(width: 12),
                      Text('Secure Checkout Portal', style: theme.typography.h3),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'SSL Encrypted secure simulated transaction for ${invoice.id}.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),

                  // Amount Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.primary.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Amount', style: theme.typography.bodyMedium),
                        Text(
                          '\$${invoice.amount.toStringAsFixed(2)} CAD',
                          style: theme.typography.h3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Card inputs
                  PrimeCareTextField(
                    label: 'Cardholder Number',
                    hintText: '4532 0000 0000 0000',
                    controller: cardNumberController,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimeCareTextField(
                          label: 'Expiry Date',
                          hintText: 'MM/YY',
                          controller: expiryController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PrimeCareTextField(
                          label: 'CVV/CVC',
                          hintText: '•••',
                          controller: cvcController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  if (isPending)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(theme.radiusDefault),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPending = true;
                          });
                          controller.payInvoice(invoice.id);
                          Future.delayed(const Duration(milliseconds: 1200), () {
                            Navigator.pop(context);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.lock, size: 16),
                            const SizedBox(width: 8),
                            Text('Authorize Payment of \$${invoice.amount.toStringAsFixed(2)}', style: theme.typography.labelBold),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
