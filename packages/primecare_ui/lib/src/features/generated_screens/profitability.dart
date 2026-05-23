// Governance - Category: service | Purpose: Core implementation file for the Profitability platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class ProfitabilityState {
  final double hourlyClientBillRate;
  final double hourlyCaregiverPayRate;
  final double monthlyFixedOverhead;
  final int activeCaregiverHours;
  final bool isCalculating;
  final String activeTier;

  const ProfitabilityState({
    required this.hourlyClientBillRate,
    required this.hourlyCaregiverPayRate,
    required this.monthlyFixedOverhead,
    required this.activeCaregiverHours,
    required this.isCalculating,
    required this.activeTier,
  });

  ProfitabilityState copyWith({
    double? hourlyClientBillRate,
    double? hourlyCaregiverPayRate,
    double? monthlyFixedOverhead,
    int? activeCaregiverHours,
    bool? isCalculating,
    String? activeTier,
  }) {
    return ProfitabilityState(
      hourlyClientBillRate: hourlyClientBillRate ?? this.hourlyClientBillRate,
      hourlyCaregiverPayRate: hourlyCaregiverPayRate ?? this.hourlyCaregiverPayRate,
      monthlyFixedOverhead: monthlyFixedOverhead ?? this.monthlyFixedOverhead,
      activeCaregiverHours: activeCaregiverHours ?? this.activeCaregiverHours,
      isCalculating: isCalculating ?? this.isCalculating,
      activeTier: activeTier ?? this.activeTier,
    );
  }
}

// --- Controller ---
class ProfitabilityController extends StateNotifier<ProfitabilityState> {
  final Ref _ref;

  ProfitabilityController(this._ref)
      : super(
          const ProfitabilityState(
            hourlyClientBillRate: 48.0,
            hourlyCaregiverPayRate: 26.0,
            monthlyFixedOverhead: 18500.0,
            activeCaregiverHours: 2500,
            isCalculating: false,
            activeTier: 'Standard Care',
          ),
        );

  void updateClientBillRate(double val) {
    state = state.copyWith(hourlyClientBillRate: val);
    _logSimulation('bill_rate_adjusted', val);
  }

  void updateCaregiverPayRate(double val) {
    state = state.copyWith(hourlyCaregiverPayRate: val);
    _logSimulation('pay_rate_adjusted', val);
  }

  void updateFixedOverhead(double val) {
    state = state.copyWith(monthlyFixedOverhead: val);
    _logSimulation('overhead_adjusted', val);
  }

  void updateCaregiverHours(int val) {
    state = state.copyWith(activeCaregiverHours: val);
    _logSimulation('hours_adjusted', val.toDouble());
  }

  void updateTier(String tier) {
    state = state.copyWith(isCalculating: true, activeTier: tier);

    double defaultBill = 48.0;
    double defaultPay = 26.0;

    if (tier == 'Specialized Nursing') {
      defaultBill = 75.0;
      defaultPay = 42.0;
    } else if (tier == 'Allied Therapy') {
      defaultBill = 90.0;
      defaultPay = 50.0;
    } else if (tier == 'Standard Care') {
      defaultBill = 48.0;
      defaultPay = 26.0;
    }

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/profitability',
            eventType: 'profitability_service_tier_changed',
            metadata: {
              'selected_tier': tier,
              'bill_rate': defaultBill,
              'pay_rate': defaultPay,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      state = state.copyWith(
        hourlyClientBillRate: defaultBill,
        hourlyCaregiverPayRate: defaultPay,
        isCalculating: false,
      );
    });
  }

  void _logSimulation(String key, double value) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/profitability',
            eventType: 'profitability_simulation_updated',
            metadata: {
              'metric': key,
              'value': value,
            },
          );
    } catch (_) {}
  }
}

// --- Provider ---
final profitabilityControllerProvider =
    StateNotifierProvider<ProfitabilityController, ProfitabilityState>((ref) {
  return ProfitabilityController(ref);
});

// --- View ---
class Profitability extends GovernedConsumerWidget {
  const Profitability({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profitabilityControllerProvider);
    final controller = ref.read(profitabilityControllerProvider.notifier);
    final theme = context.theme;

    // Financial math
    final double spread = state.hourlyClientBillRate - state.hourlyCaregiverPayRate;
    final double grossRevenue = state.hourlyClientBillRate * state.activeCaregiverHours;
    final double directCost = state.hourlyCaregiverPayRate * state.activeCaregiverHours;
    final double grossProfit = grossRevenue - directCost;
    final double netProfit = grossProfit - state.monthlyFixedOverhead;
    final double margin = grossRevenue > 0 ? (netProfit / grossRevenue) * 100 : 0.0;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.pieChart, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'CFO Strategic Margin & Profitability Command',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Franchise Profitability Simulator',
                            style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Simulate gross margins, review client billing tiers, map caregiver labor overhead, and analyze regional operating leverage.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Choice chips for Tiers
                Row(
                  children: ['Standard Care', 'Specialized Nursing', 'Allied Therapy'].map((tier) {
                    final isSelected = state.activeTier == tier;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(tier),
                        selected: isSelected,
                        selectedColor: theme.colors.primary.withValues(alpha: 0.2),
                        backgroundColor: theme.colors.surface,
                        labelStyle: TextStyle(
                          color: isSelected ? theme.colors.primary : theme.colors.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          side: BorderSide(
                            color: isSelected ? theme.colors.primary : theme.colors.border,
                          ),
                        ),
                        onSelected: (val) {
                          if (val) controller.updateTier(tier);
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Output KPIs Card Grid
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'Simulated Gross Yield',
                        value: '\$${grossRevenue.toStringAsFixed(0)}',
                        subtitle: 'Aggregated client billings',
                        icon: LucideIcons.trendingUp,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Direct Caregiver Labor',
                        value: '\$${directCost.toStringAsFixed(0)}',
                        subtitle: 'Caregiver pay expenses',
                        icon: LucideIcons.trendingDown,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Net Yield Rate',
                        value: '\$${netProfit.toStringAsFixed(0)}',
                        subtitle: 'Net revenue pre-taxes',
                        icon: LucideIcons.badgeDollarSign,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Simulated Net Margin',
                        value: '${margin.toStringAsFixed(1)}%',
                        subtitle: 'Post-overhead profit ratio',
                        icon: LucideIcons.percent,
                        color: margin > 15 ? Colors.teal : Colors.amber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Split controls Panel
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Interactive Simulation Sliders
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Simulation Parameters',
                              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                            ),
                            const SizedBox(height: 24),

                            // Bill Rate
                            _SliderField(
                              title: 'Hourly Client Bill Rate',
                              value: state.hourlyClientBillRate,
                              min: 15.0,
                              max: 150.0,
                              prefix: '\$',
                              suffix: '/hr',
                              onChanged: controller.updateClientBillRate,
                            ),
                            const SizedBox(height: 24),

                            // Pay Rate
                            _SliderField(
                              title: 'Hourly Caregiver Pay Rate',
                              value: state.hourlyCaregiverPayRate,
                              min: 12.0,
                              max: 100.0,
                              prefix: '\$',
                              suffix: '/hr',
                              onChanged: controller.updateCaregiverPayRate,
                            ),
                            const SizedBox(height: 24),

                            // Active Hours
                            _SliderField(
                              title: 'Monthly Service Hours',
                              value: state.activeCaregiverHours.toDouble(),
                              min: 500,
                              max: 10000,
                              divisions: 38,
                              prefix: '',
                              suffix: ' hrs',
                              onChanged: (val) => controller.updateCaregiverHours(val.toInt()),
                            ),
                            const SizedBox(height: 24),

                            // Monthly Fixed Overhead
                            _SliderField(
                              title: 'Monthly Fixed Operational Overhead',
                              value: state.monthlyFixedOverhead,
                              min: 5000.0,
                              max: 50000.0,
                              divisions: 45,
                              prefix: '\$',
                              suffix: '/mo',
                              onChanged: controller.updateFixedOverhead,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Right Column: Summary Audit Ledger
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Simulation Auditor Ratios',
                              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                            ),
                            const SizedBox(height: 20),

                            _RatioRow(
                              label: 'Gross Profit spread',
                              value: '\$${spread.toStringAsFixed(2)} / hr',
                              color: theme.colors.onSurface,
                            ),
                            const Divider(height: 24),

                            _RatioRow(
                              label: 'Direct Labor Cost Ratio',
                              value: grossRevenue > 0
                                  ? '${((directCost / grossRevenue) * 100).toStringAsFixed(1)}%'
                                  : '0%',
                              color: theme.colors.onSurfaceVariant,
                            ),
                            const Divider(height: 24),

                            _RatioRow(
                              label: 'Fixed Cost Ratio',
                              value: grossRevenue > 0
                                  ? '${((state.monthlyFixedOverhead / grossRevenue) * 100).toStringAsFixed(1)}%'
                                  : '0%',
                              color: theme.colors.onSurfaceVariant,
                            ),
                            const Divider(height: 24),

                            _RatioRow(
                              label: 'Breakeven Operating Point',
                              value: spread > 0
                                  ? '${(state.monthlyFixedOverhead / spread).toStringAsFixed(0)} hrs / mo'
                                  : 'Infinity',
                              color: theme.colors.primary,
                              isBold: true,
                            ),
                            const SizedBox(height: 24),

                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: margin > 20
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.amber.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(
                                  color: margin > 20
                                      ? Colors.green.withValues(alpha: 0.2)
                                      : Colors.amber.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    margin > 20 ? LucideIcons.smile : LucideIcons.alertTriangle,
                                    color: margin > 20 ? Colors.green : Colors.amber,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      margin > 20
                                          ? 'Franchise margin exceeds target index benchmarks (20.0%).'
                                          : 'Simulation margins sit below corporate benchmark index.',
                                      style: theme.typography.bodyMedium.copyWith(
                                        color: margin > 20 ? Colors.green[800] : Colors.amber[900],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
          if (state.isCalculating)
            Container(
              color: Colors.black.withValues(alpha: 0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _MetricCard({
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
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: 20),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.typography.h2.copyWith(
                    color: theme.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
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

class _SliderField extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final String prefix;
  final String suffix;
  final int? divisions;
  final ValueChanged<double> onChanged;

  const _SliderField({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.prefix,
    required this.suffix,
    this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colors.onSurface,
              ),
            ),
            Text(
              '$prefix${value.toStringAsFixed(value % 1 == 0 ? 0 : 2)}$suffix',
              style: theme.typography.h4.copyWith(
                color: theme.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions ?? 50,
          activeColor: theme.colors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _RatioRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isBold;

  const _RatioRow({
    required this.label,
    required this.value,
    required this.color,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.typography.bodyMedium.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.typography.bodyMedium.copyWith(
            color: color,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
