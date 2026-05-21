import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class HeadOfBusDevDashboardState {
  final List<Map<String, dynamic>> partnerships;
  final int activePartners;
  final double dealPipelineValue;
  final double regionalGrowthRate;
  final String statusFilter;
  final bool isMutatingState;

  const HeadOfBusDevDashboardState({
    required this.partnerships,
    required this.activePartners,
    required this.dealPipelineValue,
    required this.regionalGrowthRate,
    required this.statusFilter,
    required this.isMutatingState,
  });

  HeadOfBusDevDashboardState copyWith({
    List<Map<String, dynamic>>? partnerships,
    int? activePartners,
    double? dealPipelineValue,
    double? regionalGrowthRate,
    String? statusFilter,
    bool? isMutatingState,
  }) {
    return HeadOfBusDevDashboardState(
      partnerships: partnerships ?? this.partnerships,
      activePartners: activePartners ?? this.activePartners,
      dealPipelineValue: dealPipelineValue ?? this.dealPipelineValue,
      regionalGrowthRate: regionalGrowthRate ?? this.regionalGrowthRate,
      statusFilter: statusFilter ?? this.statusFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class HeadOfBusDevDashboardController extends StateNotifier<HeadOfBusDevDashboardState> {
  final Ref _ref;

  HeadOfBusDevDashboardController(this._ref)
      : super(
          const HeadOfBusDevDashboardState(
            partnerships: [
              {
                'id': 'pt-801',
                'partner': 'Sunrise Senior Living Center',
                'type': 'Assisted Living Alliance',
                'value': 180000.0,
                'status': 'Negotiation',
              },
              {
                'id': 'pt-802',
                'partner': 'St. Jude General Hospital',
                'type': 'Discharge Referral Pact',
                'value': 350000.0,
                'status': 'Active',
              },
              {
                'id': 'pt-803',
                'partner': 'Vance Medical Group',
                'type': 'Physician Clinic Network',
                'value': 120000.0,
                'status': 'Pending',
              },
              {
                'id': 'pt-804',
                'partner': 'Golden Years Retirement Village',
                'type': 'Preferred Care Provider',
                'value': 240000.0,
                'status': 'Active',
              },
            ],
            activePartners: 32,
            dealPipelineValue: 890000.0,
            regionalGrowthRate: 0.142,
            statusFilter: 'All',
            isMutatingState: false,
          ),
        );

  void setFilter(String filter) {
    state = state.copyWith(statusFilter: filter);
  }

  void triggerPipelineRefresh() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/head_of_bus_dev_dashboard',
            eventType: 'pipeline_refresh_triggered',
            metadata: {
              'refresh_time': DateTime.now().toIso8601String(),
              'current_value': state.dealPipelineValue,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final updatedPartners = state.partnerships.map((p) {
        if (p['status'] == 'Pending') {
          return {
            ...p,
            'status': 'Active',
          };
        }
        return p;
      }).toList();

      state = state.copyWith(
        partnerships: updatedPartners,
        activePartners: 34,
        dealPipelineValue: 1010000.0,
        regionalGrowthRate: 0.168,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final headOfBusDevDashboardControllerProvider =
    StateNotifierProvider<HeadOfBusDevDashboardController, HeadOfBusDevDashboardState>((ref) {
  return HeadOfBusDevDashboardController(ref);
});

// --- View ---
class HeadOfBusDevDashboard extends GovernedConsumerWidget {
  const HeadOfBusDevDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(headOfBusDevDashboardControllerProvider);
    final controller = ref.read(headOfBusDevDashboardControllerProvider.notifier);
    final theme = context.theme;

    final filteredPartnerships = state.partnerships.where((p) {
      if (state.statusFilter == 'All') return true;
      return p['status'] == state.statusFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.briefcase, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Business Development Strategic Command',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.triggerPipelineRefresh(),
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              label: const Text('Sync Pipeline'),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'B2B Partnerships & Regional Alliances',
                            style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monitor hospital referral pacts, assisted living networks value pools, and multi-branch expansions.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: state.statusFilter,
                      onChanged: (val) {
                        if (val != null) controller.setFilter(val);
                      },
                      items: const [
                        DropdownMenuItem(value: 'All', child: Text('All Deals')),
                        DropdownMenuItem(value: 'Active', child: Text('Active Alliance')),
                        DropdownMenuItem(value: 'Negotiation', child: Text('In Negotiation')),
                        DropdownMenuItem(value: 'Pending', child: Text('Pending Contract')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Strategic KPIs
                Row(
                  children: [
                    Expanded(
                      child: _BusDevKpiCard(
                        title: 'Active Corporate Partners',
                        value: '${state.activePartners}',
                        subtitle: 'Pacts, clinics & hospitals',
                        icon: LucideIcons.users,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _BusDevKpiCard(
                        title: 'Estimated Deal Pipeline',
                        value: '\$${state.dealPipelineValue.toStringAsFixed(0)}',
                        subtitle: 'Projected B2B revenues',
                        icon: LucideIcons.trendingUp,
                        iconColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _BusDevKpiCard(
                        title: 'Regional Expansions',
                        value: '${(state.regionalGrowthRate * 100).toStringAsFixed(1)}%',
                        subtitle: 'Quarter-over-Quarter growth',
                        icon: LucideIcons.globe,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Partnerships Directory Ledger
                Text(
                  'Corporate Partnerships Ledger',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: filteredPartnerships.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              'No strategic partnerships match the selected deal filter.',
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredPartnerships.length,
                          separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                          itemBuilder: (context, index) {
                            final item = filteredPartnerships[index];
                            final status = item['status'] as String;
                            final statusColor = status == 'Active'
                                ? Colors.green
                                : status == 'Negotiation'
                                    ? Colors.amber
                                    : Colors.blue;

                            return ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  status == 'Active' ? LucideIcons.shieldCheck : LucideIcons.fileText,
                                  color: statusColor,
                                  size: 16,
                                ),
                              ),
                              title: Text(
                                (item['partner'] as String),
                                style: theme.typography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                              subtitle: Text('${item['type']} • Contract Pool'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '\$${item['value'].toStringAsFixed(0)}',
                                    style: theme.typography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
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

class _BusDevKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _BusDevKpiCard({
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
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
                      fontSize: 11,
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
