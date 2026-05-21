import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class HeadOfMarketingDashboardState {
  final double marketingBudget;
  final double cac;
  final double ltv;
  final double roi;
  final List<Map<String, dynamic>> marketingCampaigns;
  final List<Map<String, dynamic>> channelPerformance;
  final bool isSimulating;

  const HeadOfMarketingDashboardState({
    required this.marketingBudget,
    required this.cac,
    required this.ltv,
    required this.roi,
    required this.marketingCampaigns,
    required this.channelPerformance,
    required this.isSimulating,
  });

  HeadOfMarketingDashboardState copyWith({
    double? marketingBudget,
    double? cac,
    double? ltv,
    double? roi,
    List<Map<String, dynamic>>? marketingCampaigns,
    List<Map<String, dynamic>>? channelPerformance,
    bool? isSimulating,
  }) {
    return HeadOfMarketingDashboardState(
      marketingBudget: marketingBudget ?? this.marketingBudget,
      cac: cac ?? this.cac,
      ltv: ltv ?? this.ltv,
      roi: roi ?? this.roi,
      marketingCampaigns: marketingCampaigns ?? this.marketingCampaigns,
      channelPerformance: channelPerformance ?? this.channelPerformance,
      isSimulating: isSimulating ?? this.isSimulating,
    );
  }
}

// --- Controller ---
class HeadOfMarketingDashboardController extends StateNotifier<HeadOfMarketingDashboardState> {
  final Ref _ref;

  HeadOfMarketingDashboardController(this._ref)
      : super(
          const HeadOfMarketingDashboardState(
            marketingBudget: 45000.0,
            cac: 125.0,
            ltv: 850.0,
            roi: 5.8,
            marketingCampaigns: [
              {
                'id': 'cmp-001',
                'name': 'Paid Search ADL Search',
                'spend': 12000.0,
                'conversions': 95,
                'status': 'Active',
                'channel': 'Paid Search',
              },
              {
                'id': 'cmp-002',
                'name': 'Facebook Caregiver Outreach',
                'spend': 8500.0,
                'conversions': 68,
                'status': 'Active',
                'channel': 'Paid Social',
              },
              {
                'id': 'cmp-003',
                'name': 'LinkedIn B2B Nursing Partnerships',
                'spend': 5000.0,
                'conversions': 32,
                'status': 'Paused',
                'channel': 'Paid Social',
              },
              {
                'id': 'cmp-004',
                'name': 'Local Hospital Referral Brochures',
                'spend': 3500.0,
                'conversions': 45,
                'status': 'Active',
                'channel': 'Referral',
              },
            ],
            channelPerformance: [
              {'channel': 'Organic search', 'leads': 320, 'growth': 0.12},
              {'channel': 'Paid search', 'leads': 180, 'growth': 0.08},
              {'channel': 'Doctor referrals', 'leads': 450, 'growth': 0.25},
              {'channel': 'Community events', 'leads': 150, 'growth': -0.05},
            ],
            isSimulating: false,
          ),
        );

  void simulateBudgetChange(double newBudget) {
    state = state.copyWith(marketingBudget: newBudget, isSimulating: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/head_of_marketing_dashboard',
            eventType: 'marketing_budget_simulated',
            metadata: {
              'simulated_budget': newBudget,
              'time': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    // Simulated recalculation of CAC and ROI based on budget shift
    Future.delayed(const Duration(milliseconds: 300), () {
      final budgetRatio = newBudget / 45000.0;
      // CAC usually increases as budget scales due to diminishing returns
      final simulatedCac = 125.0 * (1.0 + (budgetRatio - 1.0) * 0.15);
      // ROI decreases slightly with higher spend
      final simulatedRoi = 5.8 * (1.0 - (budgetRatio - 1.0) * 0.08);

      state = state.copyWith(
        cac: double.parse(simulatedCac.toStringAsFixed(1)),
        roi: double.parse(simulatedRoi.toStringAsFixed(1)),
        isSimulating: false,
      );
    });
  }

  void toggleCampaignStatus(String id) {
    final updatedCampaigns = state.marketingCampaigns.map((c) {
      if (c['id'] == id) {
        final currentStatus = c['status'];
        final newStatus = currentStatus == 'Active' ? 'Paused' : 'Active';
        
        try {
          _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
                route: '/generated/head_of_marketing_dashboard',
                eventType: 'campaign_status_changed',
                metadata: {
                  'campaign_id': id,
                  'campaign_name': c['name'],
                  'old_status': currentStatus,
                  'new_status': newStatus,
                },
              );
        } catch (_) {}
        
        return {
          ...c,
          'status': newStatus,
        };
      }
      return c;
    }).toList();

    state = state.copyWith(marketingCampaigns: updatedCampaigns);
  }
}

// --- Provider ---
final headOfMarketingDashboardControllerProvider =
    StateNotifierProvider<HeadOfMarketingDashboardController, HeadOfMarketingDashboardState>((ref) {
  return HeadOfMarketingDashboardController(ref);
});

// --- View ---
class HeadOfMarketingDashboard extends GovernedConsumerWidget {
  const HeadOfMarketingDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(headOfMarketingDashboardControllerProvider);
    final controller = ref.read(headOfMarketingDashboardControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.megaphone, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Head of Marketing Strategy Hub',
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
                            'Marketing Performance & Acquisition Strategy',
                            style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage B2B referrals, paid campaigns, organic lead pipeline, and calculate acquisition KPIs in real-time.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Core CAC / LTV KPIs
                Row(
                  children: [
                    Expanded(
                      child: _MarketingKpiCard(
                        title: 'CAC (Customer Acquisition Cost)',
                        value: '\$${state.cac}',
                        subtitle: 'Average per client onboarding',
                        icon: LucideIcons.userPlus,
                        iconColor: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MarketingKpiCard(
                        title: 'LTV (Lifetime Value)',
                        value: '\$${state.ltv}',
                        subtitle: 'Calculated client value ratio',
                        icon: LucideIcons.trendingUp,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MarketingKpiCard(
                        title: 'LTV : CAC Ratio',
                        value: '${(state.ltv / state.cac).toStringAsFixed(1)}x',
                        subtitle: 'Target: >3.0x ratio',
                        icon: LucideIcons.shieldCheck,
                        iconColor: (state.ltv / state.cac) >= 3.0 ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MarketingKpiCard(
                        title: 'Estimated Campaign ROI',
                        value: '${state.roi}x',
                        subtitle: 'Return on Ad Spend (ROAS)',
                        icon: LucideIcons.dollarSign,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Live Campaign Ledger & Simulation sliders
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Campaign List
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Acquisition Channels & Campaigns',
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
                              itemCount: state.marketingCampaigns.length,
                              separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                              itemBuilder: (context, index) {
                                final item = state.marketingCampaigns[index];
                                final status = item['status'] as String;
                                final statusColor = status == 'Active' ? Colors.green : Colors.grey;

                                return ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      item['channel'] == 'Paid Search' ? LucideIcons.search : LucideIcons.share2,
                                      color: statusColor,
                                      size: 16,
                                    ),
                                  ),
                                  title: Text(
                                    (item['name'] as String),
                                    style: theme.typography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                  subtitle: Text('Budget Spend: \$${item['spend']} • Conversions: ${item['conversions']}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: statusColor.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                                        ),
                                        child: Text(
                                          status,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: Icon(
                                          status == 'Active' ? LucideIcons.pauseCircle : LucideIcons.playCircle,
                                          color: theme.colors.primary,
                                        ),
                                        onPressed: () => controller.toggleCampaignStatus((item['id'] as String)),
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
                    const SizedBox(width: 24),

                    // Right Column: Budget Simulator & Organic/Referral Growth Charts
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Strategic Budget Simulator',
                            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 12),
                          Card(
                            color: theme.colors.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              side: BorderSide(color: theme.colors.border),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Simulate Monthly Ad Spend',
                                    style: theme.typography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Adjusting the slider dynamically predicts LTV/CAC ratio adjustments due to search term saturation.',
                                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Monthly Spend limit:',
                                        style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                                      ),
                                      Text(
                                        '\$${state.marketingBudget.toStringAsFixed(0)}',
                                        style: theme.typography.h3.copyWith(
                                          color: theme.colors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Slider(
                                    value: state.marketingBudget,
                                    min: 10000.0,
                                    max: 100000.0,
                                    divisions: 18,
                                    label: '\$${state.marketingBudget.toStringAsFixed(0)}',
                                    activeColor: theme.colors.primary,
                                    onChanged: (val) {
                                      controller.simulateBudgetChange(val);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Referral Leads Acquisition Channels List
                          Text(
                            'Organic & Referral Channels Growth',
                            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colors.surface,
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              border: Border.all(color: theme.colors.border),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: state.channelPerformance.map((channel) {
                                final growth = channel['growth'] as double;
                                final growthColor = growth >= 0 ? Colors.green : Colors.red;
                                final growthSign = growth >= 0 ? '+' : '';

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (channel['channel'] as String),
                                        style: theme.typography.bodyMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colors.onSurface,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${channel['leads']} leads',
                                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                          ),
                                          const SizedBox(width: 12),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: growthColor.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '$growthSign${(growth * 100).toStringAsFixed(0)}%',
                                              style: TextStyle(
                                                color: growthColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (state.isSimulating)
            Container(
              color: Colors.black.withValues(alpha: 0.08),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _MarketingKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _MarketingKpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
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
            const SizedBox(width: 12),
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
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(
                      color: theme.colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
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
      ),
    );
  }
}
