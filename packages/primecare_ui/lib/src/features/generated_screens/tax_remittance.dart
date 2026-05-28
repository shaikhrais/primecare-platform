// Governance - Category: service | Purpose: Core implementation file for the Tax Remittance platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class TaxRemittanceState {
  final List<Map<String, dynamic>> ledgerEntries;
  final double simulatedTaxRate;
  final String activeQuarter;
  final bool isSubmittingFiling;
  final bool showFilingSuccess;

  const TaxRemittanceState({
    required this.ledgerEntries,
    required this.simulatedTaxRate,
    required this.activeQuarter,
    required this.isSubmittingFiling,
    required this.showFilingSuccess,
  });

  TaxRemittanceState copyWith({
    List<Map<String, dynamic>>? ledgerEntries,
    double? simulatedTaxRate,
    String? activeQuarter,
    bool? isSubmittingFiling,
    bool? showFilingSuccess,
  }) {
    return TaxRemittanceState(
      ledgerEntries: ledgerEntries ?? this.ledgerEntries,
      simulatedTaxRate: simulatedTaxRate ?? this.simulatedTaxRate,
      activeQuarter: activeQuarter ?? this.activeQuarter,
      isSubmittingFiling: isSubmittingFiling ?? this.isSubmittingFiling,
      showFilingSuccess: showFilingSuccess ?? this.showFilingSuccess,
    );
  }
}

// --- Controller ---
class TaxRemittanceController extends StateNotifier<TaxRemittanceState> {
  final Ref _ref;

  TaxRemittanceController(this._ref)
      : super(
          const TaxRemittanceState(
            ledgerEntries: [
              {
                'id': 'tx-901',
                'category': 'Employee Income Tax Withheld',
                'amount': 45600.00,
                'status': 'pending',
                'dueDate': '2026-06-15',
                'code': 'T4-FED',
              },
              {
                'id': 'tx-902',
                'category': 'Employer Pension Contributions (CPP)',
                'amount': 18950.00,
                'status': 'pending',
                'dueDate': '2026-06-15',
                'code': 'CPP-PROV',
              },
              {
                'id': 'tx-903',
                'category': 'Employment Insurance Levies (EI)',
                'amount': 8230.00,
                'status': 'reimbursed',
                'dueDate': '2026-05-15',
                'code': 'EI-REG',
              },
              {
                'id': 'tx-904',
                'category': 'Municipal Training Levy Contribution',
                'amount': 2400.00,
                'status': 'reimbursed',
                'dueDate': '2026-05-15',
                'code': 'MUN-12',
              },
            ],
            simulatedTaxRate: 15.0,
            activeQuarter: 'Q2-2026',
            isSubmittingFiling: false,
            showFilingSuccess: false,
          ),
        );

  void updateSimulatedRate(double rate) {
    state = state.copyWith(simulatedTaxRate: rate);
  }

  void updateQuarter(String quarter) {
    state = state.copyWith(activeQuarter: quarter);
  }

  void executeFilingSubmission() {
    state = state.copyWith(isSubmittingFiling: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/tax_remittance',
            eventType: 'tax_remittance_ledger_filed',
            metadata: {
              'quarter': state.activeQuarter,
              'simulatedRate': state.simulatedTaxRate,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      final updated = state.ledgerEntries.map((e) {
        if (e['status'] == 'pending') {
          return {...e, 'status': 'reimbursed'};
        }
        return e;
      }).toList();

      state = state.copyWith(
        isSubmittingFiling: false,
        showFilingSuccess: true,
        ledgerEntries: updated,
      );
    });
  }

  void dismissNotification() {
    state = state.copyWith(showFilingSuccess: false);
  }
}

// --- Provider ---
final taxRemittanceControllerProvider =
    StateNotifierProvider<TaxRemittanceController, TaxRemittanceState>((ref) {
  return TaxRemittanceController(ref);
});

// --- View ---
class TaxRemittance extends GovernedConsumerWidget {
  const TaxRemittance({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taxRemittanceControllerProvider);
    final controller = ref.read(taxRemittanceControllerProvider.notifier);
    final theme = context.theme;

    // Calculate simulated totals
    double basePendingAmount = 0.0;
    for (var entry in state.ledgerEntries) {
      if (entry['status'] == 'pending') {
        basePendingAmount += entry['amount'] as double;
      }
    }
    final simulatedPendingAdjustment = basePendingAmount * (state.simulatedTaxRate / 100.0);
    final simulatedTotalDue = basePendingAmount + simulatedPendingAdjustment;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.fileSignature, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Corporate Tax & Remittance Desk',
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
            if (state.showFilingSuccess)
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
                    const Icon(LucideIcons.checkCircle2, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Quarterly Tax Remittance Ledger Filed Successfully!',
                        style: theme.typography.bodyMedium.copyWith(color: Colors.green.shade800),
                      ),
                    ),
                    IconButton(key: const Key('tax_remittance_iconbutton_button_1'), 
                      icon: const Icon(LucideIcons.x, size: 16, color: Colors.green),
                      onPressed: controller.dismissNotification,
                    ),
                  ],
                ),
              ),

            // Header Hero
            Text(
              'Corporate Remittance Auditor',
              style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 6),
            Text(
              'Quarterly filing simulation & regulatory tax withholding logs.',
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Ledger Tables
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Active Ledger Table
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                border: Border(bottom: BorderSide(color: theme.colors.border)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Regulatory Withholding Ledger (${state.activeQuarter})',
                                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                                  ),
                                  DropdownButton<String>(
                                    value: state.activeQuarter,
                                    items: const [
                                      DropdownMenuItem(value: 'Q1-2026', child: Text('Q1 2026')),
                                      DropdownMenuItem(value: 'Q2-2026', child: Text('Q2 2026')),
                                      DropdownMenuItem(value: 'Q3-2026', child: Text('Q3 2026')),
                                    ],
                                    onChanged: (val) => controller.updateQuarter(val ?? 'Q2-2026'),
                                  ),
                                ],
                              ),
                            ),

                            // Ledger rows
                            ...state.ledgerEntries.map((entry) {
                              final isPending = entry['status'] == 'pending';
                              Color statusColor = isPending ? Colors.amber : Colors.green;

                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: theme.colors.border)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (entry['category'] as String),
                                            style: theme.typography.bodyLarge.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: theme.colors.onSurface,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'CODE: ${entry['code']} | DUE: ${entry['dueDate']}',
                                            style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '\$${(entry['amount'] as double).toStringAsFixed(2)}',
                                        style: theme.typography.bodyLarge.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colors.onSurface,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(theme.radiusSm),
                                      ),
                                      child: Text(
                                        isPending ? 'Pending Filing' : 'Settled',
                                        style: theme.typography.labelBold.copyWith(color: statusColor),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),

                // Right Column: Simulation & Submission Box
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Compliance Bracket Simulator',
                          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Model local municipal adjustments below to recalculate year-end adjustments.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 24),

                        // Slider
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Local Surcharge Levy',
                              style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${state.simulatedTaxRate.toStringAsFixed(1)}%',
                              style: theme.typography.bodyLarge.copyWith(
                                color: theme.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: state.simulatedTaxRate,
                          min: 5.0,
                          max: 30.0,
                          divisions: 250,
                          activeColor: theme.colors.primary,
                          onChanged: controller.updateSimulatedRate,
                        ),
                        const SizedBox(height: 24),

                        // Financial totals drawer
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Base Pending Tax Due:',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  Text(
                                    '\$${basePendingAmount.toStringAsFixed(2)}',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Simulated Adjustments:',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  Text(
                                    '+\$${simulatedPendingAdjustment.toStringAsFixed(2)}',
                                    style: theme.typography.bodyMedium.copyWith(color: Colors.amber.shade900),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estimated Remittance due:',
                                    style: theme.typography.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                  Text(
                                    '\$${simulatedTotalDue.toStringAsFixed(2)}',
                                    style: theme.typography.h3.copyWith(
                                      color: theme.colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: state.isSubmittingFiling
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(key: const Key('tax_remittance_elevatedbutton_button_1'), 
                                  onPressed: basePendingAmount > 0
                                      ? () => _showConfirmationDialog(context, controller)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colors.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    disabledBackgroundColor: theme.colors.border,
                                  ),
                                  child: const Text('Submit Ledger & File Remittance'),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, TaxRemittanceController controller) {
    final theme = context.theme;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm Tax Remittance Filing',
                style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
              ),
              const SizedBox(height: 12),
              Text(
                'By clicking confirm, you authorize a digital submission of the tax withholding ledger to the government registry. This simulation will update the status checkmark immediately.',
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(key: const Key('tax_remittance_outlinedbutton_button_1'), 
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(key: const Key('tax_remittance_elevatedbutton_button_2'), 
                      onPressed: () {
                        controller.executeFilingSubmission();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Confirm & File'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
