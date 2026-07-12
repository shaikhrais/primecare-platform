import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Governance - Category: service | Purpose: Core implementation file for the Cash Flow platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class CashFlowState {
  final List<Map<String, dynamic>> ledgers;
  final String activePeriod;
  final double inflowTotal;
  final double outflowTotal;
  final double netFlow;
  final bool isMutatingState;

  const CashFlowState({
    required this.ledgers,
    required this.activePeriod,
    required this.inflowTotal,
    required this.outflowTotal,
    required this.netFlow,
    required this.isMutatingState,
  });

  CashFlowState copyWith({
    List<Map<String, dynamic>>? ledgers,
    String? activePeriod,
    double? inflowTotal,
    double? outflowTotal,
    double? netFlow,
    bool? isMutatingState,
  }) {
    return CashFlowState(
      ledgers: ledgers ?? this.ledgers,
      activePeriod: activePeriod ?? this.activePeriod,
      inflowTotal: inflowTotal ?? this.inflowTotal,
      outflowTotal: outflowTotal ?? this.outflowTotal,
      netFlow: netFlow ?? this.netFlow,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class CashFlowController extends StateNotifier<CashFlowState> {
  final Ref ref;
  final Ref _ref;

  CashFlowController(this._ref)
      : super(
          const CashFlowState(
            ledgers: [
              {
                'id': 'LGR-901',
                'description': 'Private Patient Billings Sweep',
                'amount': 45200.00,
                'type': 'Inflow',
                'category': 'Operations',
                'date': '2026-05-18',
              },
              {
                'id': 'LGR-902',
                'description': 'Caregiver Payroll Cycle (BI-WEEKLY)',
                'amount': -28400.00,
                'type': 'Outflow',
                'category': 'Payroll',
                'date': '2026-05-19',
              },
              {
                'id': 'LGR-903',
                'description': 'Ontario Ministry Health Medicaid Reimbursement',
                'amount': 18900.00,
                'type': 'Inflow',
                'category': 'Government Grants',
                'date': '2026-05-17',
              },
              {
                'id': 'LGR-904',
                'description': 'Office Lease & Facility Costs',
                'amount': -3500.00,
                'type': 'Outflow',
                'category': 'Rent',
                'date': '2026-05-15',
              },
            ],
            activePeriod: 'Monthly',
            inflowTotal: 64100.00,
            outflowTotal: 31900.00,
            netFlow: 32200.00,
            isMutatingState: false,
          ),
        );

  void updatePeriod(String period) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/cash_flow',
            eventType: 'cash_flow_period_changed',
            metadata: {'period': period},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      double multiply = period == 'Quarterly' ? 3.0 : (period == 'Yearly' ? 12.0 : 1.0);
      state = state.copyWith(
        activePeriod: period,
        inflowTotal: 64100.00 * multiply,
        outflowTotal: 31900.00 * multiply,
        netFlow: (64100.00 - 31900.00) * multiply,
        isMutatingState: false,
      );
    });
  }

  void simulateAchSweep() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/cash_flow',
            eventType: 'cash_flow_simulation_run',
            metadata: {'simulationType': 'ACH sweep balance reconcile'},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final sweepLedger = {
        'id': 'LGR-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        'description': 'Simulated Operations ACH Sweep Audit',
        'amount': 8400.00,
        'type': 'Inflow',
        'category': 'Operations',
        'date': DateTime.now().toString().substring(0, 10),
      };

      state = state.copyWith(
        ledgers: [sweepLedger, ...state.ledgers],
        inflowTotal: state.inflowTotal + 8400.00,
        netFlow: state.netFlow + 8400.00,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final cashFlowControllerProvider =
    StateNotifierProvider<CashFlowController, CashFlowState>((ref) {
  return CashFlowController(ref);
});

// --- View ---
class CashFlow extends GovernedConsumerWidget {
  const CashFlow({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cashFlowControllerProvider);
    final controller = ref.read(cashFlowControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.trendingUp, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Finance Director Cash Flow Auditor',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.simulateAchSweep(),
              icon: const Icon(LucideIcons.cpu, size: 16),
              label: const Text('Simulate ACH Sweep'),
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
          SingleChildScrollView(
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
                          'Capital Flow & Balances Overview',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Simulate quarterly corporate withholding brackets, reconcile caregiver payroll metrics, and audit inflows.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: state.activePeriod,
                      onChanged: (val) {
                        if (val != null) controller.updatePeriod(val);
                      },
                      items: const [
                        DropdownMenuItem(value: 'Monthly', child: Text('Monthly View')),
                        DropdownMenuItem(value: 'Quarterly', child: Text('Quarterly View')),
                        DropdownMenuItem(value: 'Yearly', child: Text('Yearly View')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: _FlowCard(
                        title: 'Total Inflows',
                        value: '\$${state.inflowTotal.toStringAsFixed(2)}',
                        icon: LucideIcons.arrowDownLeft,
                        iconColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FlowCard(
                        title: 'Total Outflows',
                        value: '\$${state.outflowTotal.toStringAsFixed(2)}',
                        icon: LucideIcons.arrowUpRight,
                        iconColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FlowCard(
                        title: 'Net Operational Flow',
                        value: '\$${state.netFlow.toStringAsFixed(2)}',
                        icon: LucideIcons.wallet,
                        iconColor: state.netFlow >= 0 ? Colors.blue : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Cash Ledger
                Text(
                  'Recent Reconciliation Activities',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.ledgers.length,
                    separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                    itemBuilder: (context, index) {
                      final item = state.ledgers[index];
                      final isOutflow = (item['amount'] as double) < 0;

                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isOutflow ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isOutflow ? LucideIcons.minus : LucideIcons.plus,
                            color: isOutflow ? Colors.red : Colors.green,
                            size: 16,
                          ),
                        ),
                        title: Text(
                          (item['description'] as String),
                          style: theme.typography.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colors.onSurface,
                          ),
                        ),
                        subtitle: Text('${item['category']} • Reconciled ${item['date']}'),
                        trailing: Text(
                          (isOutflow ? '' : '+') + '\$${(item['amount'] as double).toStringAsFixed(2)}',
                          style: theme.typography.bodyMedium.copyWith(
                            color: isOutflow ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
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

class _FlowCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _FlowCard({
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
