import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class FinancialPerformanceState {
  final double caregiverHourlyRate;
  final double clientBillingRate;
  final int totalBillableHours;
  final double monthlyRevenue;
  final double operatingExpenses;
  final double royaltiesFee;
  final double netProfit;
  final double profitMargin;
  final bool isMutatingState;

  const FinancialPerformanceState({
    required this.caregiverHourlyRate,
    required this.clientBillingRate,
    required this.totalBillableHours,
    required this.monthlyRevenue,
    required this.operatingExpenses,
    required this.royaltiesFee,
    required this.netProfit,
    required this.profitMargin,
    required this.isMutatingState,
  });

  FinancialPerformanceState copyWith({
    double? caregiverHourlyRate,
    double? clientBillingRate,
    int? totalBillableHours,
    double? monthlyRevenue,
    double? operatingExpenses,
    double? royaltiesFee,
    double? netProfit,
    double? profitMargin,
    bool? isMutatingState,
  }) {
    return FinancialPerformanceState(
      caregiverHourlyRate: caregiverHourlyRate ?? this.caregiverHourlyRate,
      clientBillingRate: clientBillingRate ?? this.clientBillingRate,
      totalBillableHours: totalBillableHours ?? this.totalBillableHours,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      operatingExpenses: operatingExpenses ?? this.operatingExpenses,
      royaltiesFee: royaltiesFee ?? this.royaltiesFee,
      netProfit: netProfit ?? this.netProfit,
      profitMargin: profitMargin ?? this.profitMargin,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class FinancialPerformanceController extends StateNotifier<FinancialPerformanceState> {
  final Ref _ref;

  FinancialPerformanceController(this._ref)
      : super(
          const FinancialPerformanceState(
            caregiverHourlyRate: 28.0,
            clientBillingRate: 45.0,
            totalBillableHours: 3200,
            monthlyRevenue: 144000.0,
            operatingExpenses: 89600.0, // 3200 * 28
            royaltiesFee: 7200.0, // 5% of 144000
            netProfit: 47200.0, // 144000 - 89600 - 7200
            profitMargin: 0.3278, // 47200 / 144000
            isMutatingState: false,
          ),
        );

  void updateRates({
    double? caregiverRate,
    double? clientRate,
  }) {
    final double cgRate = caregiverRate ?? state.caregiverHourlyRate;
    final double clRate = clientRate ?? state.clientBillingRate;

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/financial_performance',
            eventType: 'financial_simulation_slider_changed',
            metadata: {
              'caregiverRate': cgRate,
              'clientRate': clRate,
            },
          );
    } catch (_) {}

    final revenue = state.totalBillableHours * clRate;
    final wages = state.totalBillableHours * cgRate;
    final royalties = revenue * 0.05;
    final profit = revenue - wages - royalties;
    final margin = revenue > 0 ? (profit / revenue) : 0.0;

    state = state.copyWith(
      caregiverHourlyRate: cgRate,
      clientBillingRate: clRate,
      monthlyRevenue: revenue,
      operatingExpenses: wages,
      royaltiesFee: royalties,
      netProfit: profit,
      profitMargin: margin,
    );
  }

  void exportReport() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/financial_performance',
            eventType: 'financial_report_exported',
            metadata: {
              'caregiverRate': state.caregiverHourlyRate,
              'clientRate': state.clientBillingRate,
              'netProfit': state.netProfit,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(isMutatingState: false);
    });
  }
}

// --- Provider ---
final financialPerformanceControllerProvider =
    StateNotifierProvider<FinancialPerformanceController, FinancialPerformanceState>((ref) {
  return FinancialPerformanceController(ref);
});

// --- View ---
class FinancialPerformance extends GovernedConsumerWidget {
  const FinancialPerformance({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financialPerformanceControllerProvider);
    final controller = ref.read(financialPerformanceControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.barChart2, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Franchise Financial Performance Auditor',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.exportReport(),
              icon: const Icon(LucideIcons.download, size: 16),
              label: const Text('Export Profitability Audit'),
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
                Text(
                  'Profitability Margin & Yield Reconciler',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tweak caregiver hourly wages, customize patient private billing ratios, and simulate local monthly net yield pools.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: _FinancialCard(
                        title: 'Simulated Revenue',
                        value: '\$${state.monthlyRevenue.toStringAsFixed(2)}',
                        icon: LucideIcons.pieChart,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FinancialCard(
                        title: 'Wages & Operating Costs',
                        value: '\$${state.operatingExpenses.toStringAsFixed(2)}',
                        icon: LucideIcons.wallet,
                        iconColor: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _FinancialCard(
                        title: 'Franchise Royalties (5%)',
                        value: '\$${state.royaltiesFee.toStringAsFixed(2)}',
                        icon: LucideIcons.home,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sliders Simulation Panel
                Container(
                  padding: const EdgeInsets.all(24),
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
                            'Operational Slider Simulator',
                            style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: state.profitMargin >= 0.25 ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Simulated Margin: ${(state.profitMargin * 100).toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: state.profitMargin >= 0.25 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Slider 1: Caregiver Rate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Caregiver Hourly Pay Rate: \$${state.caregiverHourlyRate.toStringAsFixed(2)}/hr',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                          ),
                          const Text('Range: \$20 - \$45', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Slider(
                        value: state.caregiverHourlyRate,
                        min: 20.0,
                        max: 45.0,
                        divisions: 50,
                        activeColor: theme.colors.primary,
                        onChanged: (val) => controller.updateRates(caregiverRate: val),
                      ),
                      const SizedBox(height: 16),

                      // Slider 2: Client Billing Rate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Client Private Billing Rate: \$${state.clientBillingRate.toStringAsFixed(2)}/hr',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                          ),
                          const Text('Range: \$35 - \$75', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Slider(
                        value: state.clientBillingRate,
                        min: 35.0,
                        max: 75.0,
                        divisions: 80,
                        activeColor: theme.colors.primary,
                        onChanged: (val) => controller.updateRates(clientRate: val),
                      ),
                      const SizedBox(height: 24),

                      // Net Profit Yield Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.background,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Monthly Net Profit Yield Pool',
                                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${state.netProfit.toStringAsFixed(2)}',
                                  style: theme.typography.h1.copyWith(
                                    color: state.netProfit >= 0 ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              state.netProfit >= 0 ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                              color: state.netProfit >= 0 ? Colors.green : Colors.red,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _FinancialCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _FinancialCard({
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
