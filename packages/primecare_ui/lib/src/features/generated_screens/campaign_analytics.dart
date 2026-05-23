// Governance - Category: service | Purpose: Core implementation file for the Campaign Analytics platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class CampaignAnalyticsState {
  final List<Map<String, dynamic>> campaigns;
  final String activeTab;
  final double totalSpend;
  final double totalClicks;
  final double averageCtr;
  final bool isFiltering;

  const CampaignAnalyticsState({
    required this.campaigns,
    required this.activeTab,
    required this.totalSpend,
    required this.totalClicks,
    required this.averageCtr,
    required this.isFiltering,
  });

  CampaignAnalyticsState copyWith({
    List<Map<String, dynamic>>? campaigns,
    String? activeTab,
    double? totalSpend,
    double? totalClicks,
    double? averageCtr,
    bool? isFiltering,
  }) {
    return CampaignAnalyticsState(
      campaigns: campaigns ?? this.campaigns,
      activeTab: activeTab ?? this.activeTab,
      totalSpend: totalSpend ?? this.totalSpend,
      totalClicks: totalClicks ?? this.totalClicks,
      averageCtr: averageCtr ?? this.averageCtr,
      isFiltering: isFiltering ?? this.isFiltering,
    );
  }
}

// --- Controller ---
class CampaignAnalyticsController extends StateNotifier<CampaignAnalyticsState> {
  final Ref _ref;

  CampaignAnalyticsController(this._ref)
      : super(
          const CampaignAnalyticsState(
            campaigns: [
              {
                'id': 'cmp-01',
                'name': 'Google Ads - Primary Care',
                'channel': 'Paid Search',
                'spend': 5400.0,
                'clicks': 12000,
                'ctr': 0.045,
                'conversions': 180,
                'status': 'Active'
              },
              {
                'id': 'cmp-02',
                'name': 'Facebook - Senior Living',
                'channel': 'Paid Social',
                'spend': 3200.0,
                'clicks': 9500,
                'ctr': 0.038,
                'conversions': 115,
                'status': 'Active'
              },
              {
                'id': 'cmp-03',
                'name': 'Instagram - Caregiver Recruiting',
                'channel': 'Paid Social',
                'spend': 2100.0,
                'clicks': 6200,
                'ctr': 0.052,
                'conversions': 82,
                'status': 'Active'
              },
              {
                'id': 'cmp-04',
                'name': 'Local Health Fair Sponsorship',
                'channel': 'Event',
                'spend': 1500.0,
                'clicks': 400,
                'ctr': 0.15,
                'conversions': 30,
                'status': 'Completed'
              },
              {
                'id': 'cmp-05',
                'name': 'Q2 Email Newsletter',
                'channel': 'Email',
                'spend': 800.0,
                'clicks': 2500,
                'ctr': 0.22,
                'conversions': 45,
                'status': 'Active'
              },
            ],
            activeTab: 'All',
            totalSpend: 13000.0,
            totalClicks: 30600.0,
            averageCtr: 0.101,
            isFiltering: false,
          ),
        );

  void changeTab(String tab) {
    state = state.copyWith(activeTab: tab, isFiltering: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/campaign_analytics',
            eventType: 'campaign_analytics_tab_changed',
            metadata: {
              'selected_tab': tab,
              'time': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 200), () {
      state = state.copyWith(isFiltering: false);
    });
  }

  void pauseCampaign(String id) {
    final updated = state.campaigns.map((c) {
      if (c['id'] == id) {
        final currentStatus = c['status'];
        final nextStatus = currentStatus == 'Active' ? 'Paused' : 'Active';

        try {
          _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
                route: '/generated/campaign_analytics',
                eventType: 'campaign_status_toggled',
                metadata: {
                  'campaign_id': id,
                  'old_status': currentStatus,
                  'new_status': nextStatus,
                },
              );
        } catch (_) {}

        return {
          ...c,
          'status': nextStatus,
        };
      }
      return c;
    }).toList();

    state = state.copyWith(campaigns: updated);
  }
}

// --- Provider ---
final campaignAnalyticsControllerProvider =
    StateNotifierProvider<CampaignAnalyticsController, CampaignAnalyticsState>((ref) {
  return CampaignAnalyticsController(ref);
});

// --- View ---
class CampaignAnalytics extends GovernedConsumerWidget {
  const CampaignAnalytics({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(campaignAnalyticsControllerProvider);
    final controller = ref.read(campaignAnalyticsControllerProvider.notifier);
    final theme = context.theme;

    final filteredCampaigns = state.campaigns.where((c) {
      if (state.activeTab == 'All') return true;
      return c['channel'] == state.activeTab;
    }).toList();

    final calculatedSpend = filteredCampaigns.fold<double>(0, (sum, c) => sum + (c['spend'] as double));
    final calculatedClicks = filteredCampaigns.fold<int>(0, (sum, c) => sum + (c['clicks'] as int));
    final calculatedConversions = filteredCampaigns.fold<int>(0, (sum, c) => sum + (c['conversions'] as int));

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.barChart3, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Campaign Performance Analytics',
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
                            'Acquisition Funnel & Conversion Analytics',
                            style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Analyze conversions across Google Ads, Social channels, Local Health Events, and Referral pipelines.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Channel tab selectors
                Row(
                  children: ['All', 'Paid Search', 'Paid Social', 'Event', 'Email'].map((tab) {
                    final isSelected = state.activeTab == tab;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(tab),
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
                          if (val) controller.changeTab(tab);
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // KPIs Row
                Row(
                  children: [
                    Expanded(
                      child: _AnalyticsKpiCard(
                        title: 'Total Ad Spend',
                        value: '\$${calculatedSpend.toStringAsFixed(0)}',
                        subtitle: 'Campaign budget deployed',
                        icon: LucideIcons.dollarSign,
                        iconColor: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnalyticsKpiCard(
                        title: 'Total Impressions/Clicks',
                        value: calculatedClicks.toString(),
                        subtitle: 'Client touchpoints',
                        icon: LucideIcons.mousePointerClick,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnalyticsKpiCard(
                        title: 'Client Conversions',
                        value: calculatedConversions.toString(),
                        subtitle: 'Completed assessments',
                        icon: LucideIcons.checkSquare,
                        iconColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _AnalyticsKpiCard(
                        title: 'Average CPA',
                        value: calculatedConversions > 0
                            ? '\$${(calculatedSpend / calculatedConversions).toStringAsFixed(1)}'
                            : '\$0.0',
                        subtitle: 'Cost per Acquisition',
                        icon: LucideIcons.badgeAlert,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Campaigns Table Ledger
                Text(
                  'Detailed Channel Conversion Ledger',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: filteredCampaigns.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              'No active campaigns for this channel.',
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredCampaigns.length,
                          separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                          itemBuilder: (context, index) {
                            final item = filteredCampaigns[index];
                            final status = item['status'] as String;
                            final statusColor = status == 'Active'
                                ? Colors.green
                                : status == 'Completed'
                                    ? Colors.blue
                                    : Colors.grey;

                            return ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item['channel'] == 'Paid Search'
                                      ? LucideIcons.search
                                      : item['channel'] == 'Paid Social'
                                          ? LucideIcons.share2
                                          : LucideIcons.mail,
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
                              subtitle: Text(
                                  'CTR: ${(item['ctr'] * 100).toStringAsFixed(1)}% • Spend: \$${item['spend']} • Conversions: ${item['conversions']}'),
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
                                  if (status != 'Completed')
                                    IconButton(
                                      icon: Icon(
                                        status == 'Active' ? LucideIcons.pauseCircle : LucideIcons.playCircle,
                                        color: theme.colors.primary,
                                      ),
                                      onPressed: () => controller.pauseCampaign((item['id'] as String)),
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
          if (state.isFiltering)
            Container(
              color: Colors.black.withValues(alpha: 0.05),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _AnalyticsKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _AnalyticsKpiCard({
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
