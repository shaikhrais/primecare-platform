import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class MarketingHubState {
  final List<Map<String, dynamic>> campaigns;
  final String searchQuery;
  final String selectedTypeFilter;
  final int activeCount;
  final double avgCac;
  final int leadsTotal;
  final bool isMutatingState;

  const MarketingHubState({
    required this.campaigns,
    required this.searchQuery,
    required this.selectedTypeFilter,
    required this.activeCount,
    required this.avgCac,
    required this.leadsTotal,
    required this.isMutatingState,
  });

  MarketingHubState copyWith({
    List<Map<String, dynamic>>? campaigns,
    String? searchQuery,
    String? selectedTypeFilter,
    int? activeCount,
    double? avgCac,
    int? leadsTotal,
    bool? isMutatingState,
  }) {
    return MarketingHubState(
      campaigns: campaigns ?? this.campaigns,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTypeFilter: selectedTypeFilter ?? this.selectedTypeFilter,
      activeCount: activeCount ?? this.activeCount,
      avgCac: avgCac ?? this.avgCac,
      leadsTotal: leadsTotal ?? this.leadsTotal,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class MarketingHubController extends StateNotifier<MarketingHubState> {
  final Ref _ref;

  MarketingHubController(this._ref)
      : super(
          const MarketingHubState(
            campaigns: [
              {
                'id': 'mkt-001',
                'name': 'Hospital Discharge Partner Outreach',
                'type': 'Outreach',
                'budget': 5000.00,
                'cac': 45.00,
                'leads': 112,
                'status': 'Active',
              },
              {
                'id': 'mkt-002',
                'name': 'Google Search Ads - Senior Care',
                'type': 'Digital',
                'budget': 8000.00,
                'cac': 65.00,
                'leads': 123,
                'status': 'Active',
              },
              {
                'id': 'mkt-003',
                'name': 'Local Community Living Seminars',
                'type': 'Seminars',
                'budget': 2000.00,
                'cac': 30.00,
                'leads': 67,
                'status': 'Paused',
              },
              {
                'id': 'mkt-004',
                'name': 'Physician Referral Dinner Series',
                'type': 'Outreach',
                'budget': 4000.00,
                'cac': 85.00,
                'leads': 47,
                'status': 'Active',
              },
            ],
            searchQuery: '',
            selectedTypeFilter: 'All',
            activeCount: 3,
            avgCac: 56.25,
            leadsTotal: 349,
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateTypeFilter(String filter) {
    state = state.copyWith(selectedTypeFilter: filter);
  }

  void toggleCampaign(String id) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/marketing_hub',
            eventType: 'campaign_state_toggled',
            metadata: {'campaignId': id},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      int activeChange = 0;
      final updated = state.campaigns.map((c) {
        if (c['id'] == id) {
          final isAct = c['status'] == 'Active';
          activeChange = isAct ? -1 : 1;
          return {
            ...c,
            'status': isAct ? 'Paused' : 'Active',
          };
        }
        return c;
      }).toList();

      state = state.copyWith(
        campaigns: updated,
        activeCount: state.activeCount + activeChange,
        isMutatingState: false,
      );
    });
  }

  void launchCampaign({
    required String name,
    required String type,
    required double budget,
  }) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/marketing_hub',
            eventType: 'campaign_launched',
            metadata: {
              'name': name,
              'type': type,
              'budget': budget,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final nextCampaign = {
        'id': 'mkt-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        'name': name,
        'type': type,
        'budget': budget,
        'cac': 0.00,
        'leads': 0,
        'status': 'Active',
      };

      state = state.copyWith(
        campaigns: [nextCampaign, ...state.campaigns],
        activeCount: state.activeCount + 1,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final marketingHubControllerProvider =
    StateNotifierProvider<MarketingHubController, MarketingHubState>((ref) {
  return MarketingHubController(ref);
});

// --- View ---
class MarketingHub extends GovernedConsumerWidget {
  const MarketingHub({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(marketingHubControllerProvider);
    final controller = ref.read(marketingHubControllerProvider.notifier);
    final theme = context.theme;

    // Filter campaigns
    final filtered = state.campaigns.where((c) {
      final matchesSearch = (c['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (c['type'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesType = state.selectedTypeFilter == 'All' ||
          (c['type'] as String).toLowerCase() == state.selectedTypeFilter.toLowerCase();
      return matchesSearch && matchesType;
    }).toList();

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
              'Marketing Campaign Command Hub',
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
                Text(
                  'Patient Leads Acquisition Board',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Audit digital campaigns, coordinate hospital outreach channels, and optimize CAC indexes.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: _MarketingCard(
                        title: 'Active Campaigns',
                        value: '${state.activeCount}',
                        icon: LucideIcons.rocket,
                        iconColor: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MarketingCard(
                        title: 'Average CAC Index',
                        value: '\$${state.avgCac.toStringAsFixed(2)}',
                        icon: LucideIcons.calculator,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MarketingCard(
                        title: 'Campaign Referrals Generated',
                        value: '${state.leadsTotal}',
                        icon: LucideIcons.userPlus2,
                        iconColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search & Filter Row
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
                            hintText: 'Search by campaign title or type...',
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
                          DropdownMenuItem(value: 'All', child: Text('All Channels')),
                          DropdownMenuItem(value: 'Outreach', child: Text('Outreach Channel')),
                          DropdownMenuItem(value: 'Digital', child: Text('Digital Ads Channel')),
                          DropdownMenuItem(value: 'Seminars', child: Text('Seminars & Events')),
                        ],
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => _showLaunchDialog(context, controller),
                        child: const Text('Launch Campaign'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Campaigns grid/list
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            'No active campaigns matching criteria.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final camp = filtered[index];
                            final isActive = camp['status'] == 'Active';
                            final statusColor = isActive ? Colors.green : Colors.grey;

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
                                                (camp['name'] as String),
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
                                                  (camp['status'] as String).toUpperCase(),
                                                  style: TextStyle(
                                                    color: statusColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: theme.colors.primary.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  (camp['type'] as String),
                                                  style: TextStyle(
                                                    color: theme.colors.primary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.dollarSign, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Budget: \$${(camp['budget'] as double).toStringAsFixed(2)}',
                                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                              ),
                                              const SizedBox(width: 24),
                                              Icon(LucideIcons.userPlus2, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Leads: ${camp['leads']}',
                                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                              ),
                                              const SizedBox(width: 24),
                                              Icon(LucideIcons.calculator, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                'CAC: \$${(camp['cac'] as double).toStringAsFixed(2)}',
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
                                    ElevatedButton(
                                      onPressed: () => controller.toggleCampaign((camp['id'] as String)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isActive ? Colors.grey : theme.colors.primary,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text(isActive ? 'Pause' : 'Activate'),
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

  void _showLaunchDialog(BuildContext context, MarketingHubController controller) {
    final theme = context.theme;
    final nameController = TextEditingController();
    final budgetController = TextEditingController();
    String selectedType = 'Outreach';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colors.surface,
          title: Text(
            'Launch Marketing Campaign',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Campaign Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(value: 'Outreach', child: Text('Outreach Channel')),
                  DropdownMenuItem(value: 'Digital', child: Text('Digital Ads Channel')),
                  DropdownMenuItem(value: 'Seminars', child: Text('Seminars & Events')),
                ],
                onChanged: (val) {
                  if (val != null) selectedType = val;
                },
                decoration: InputDecoration(
                  labelText: 'Campaign Channel Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: budgetController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Campaign Budget (\$)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: theme.colors.onSurfaceVariant)),
            ),
            ElevatedButton(
              onPressed: () {
                final budget = double.tryParse(budgetController.text) ?? 0.0;
                if (nameController.text.isNotEmpty && budget > 0) {
                  controller.launchCampaign(name: nameController.text, type: selectedType, budget: budget);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Launch'),
            ),
          ],
        );
      },
    );
  }
}

class _MarketingCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _MarketingCard({
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
