// Governance - Category: service | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RegionPerformanceState {
  final List<Map<String, dynamic>> regions;
  final String activeMarketFilter;
  final double minRetentionThreshold;
  final String? selectedRegionId;
  final bool isInitiatingAudit;

  const RegionPerformanceState({
    required this.regions,
    required this.activeMarketFilter,
    required this.minRetentionThreshold,
    this.selectedRegionId,
    required this.isInitiatingAudit,
  });

  RegionPerformanceState copyWith({
    List<Map<String, dynamic>>? regions,
    String? activeMarketFilter,
    double? minRetentionThreshold,
    String? selectedRegionId,
    bool? isInitiatingAudit,
  }) {
    return RegionPerformanceState(
      regions: regions ?? this.regions,
      activeMarketFilter: activeMarketFilter ?? this.activeMarketFilter,
      minRetentionThreshold: minRetentionThreshold ?? this.minRetentionThreshold,
      selectedRegionId: selectedRegionId ?? this.selectedRegionId,
      isInitiatingAudit: isInitiatingAudit ?? this.isInitiatingAudit,
    );
  }
}

// --- Controller ---
class RegionPerformanceController extends StateNotifier<RegionPerformanceState> {
  final Ref _ref;

  RegionPerformanceController(this._ref)
      : super(
          const RegionPerformanceState(
            regions: [
              {
                'id': 'REG-001',
                'name': 'Ontario Southwest',
                'market': 'Canada',
                'clients': 1420,
                'caregivers': 380,
                'growth': 14.5,
                'revenue': 2.45, // millions
                'retention': 96.2, // percentage
                'nps': 92.0,
                'staffingGap': 8,
              },
              {
                'id': 'REG-002',
                'name': 'British Columbia Coastal',
                'market': 'Canada',
                'clients': 980,
                'caregivers': 240,
                'growth': 11.2,
                'revenue': 1.85,
                'retention': 94.5,
                'nps': 88.5,
                'staffingGap': 14,
              },
              {
                'id': 'REG-003',
                'name': 'California Southern',
                'market': 'USA',
                'clients': 2250,
                'caregivers': 610,
                'growth': 22.8,
                'revenue': 4.10,
                'retention': 91.8,
                'nps': 94.0,
                'staffingGap': 24,
              },
              {
                'id': 'REG-004',
                'name': 'New York Metro',
                'market': 'USA',
                'clients': 1850,
                'caregivers': 490,
                'growth': 18.2,
                'revenue': 3.35,
                'retention': 89.4,
                'nps': 86.0,
                'staffingGap': 32,
              },
              {
                'id': 'REG-005',
                'name': 'UK South East',
                'market': 'International',
                'clients': 620,
                'caregivers': 150,
                'growth': 29.5,
                'revenue': 1.15,
                'retention': 95.0,
                'nps': 91.5,
                'staffingGap': 4,
              },
            ],
            activeMarketFilter: 'all',
            minRetentionThreshold: 0.0,
            isInitiatingAudit: false,
          ),
        );

  void updateMarketFilter(String filter) {
    state = state.copyWith(activeMarketFilter: filter);
  }

  void updateThreshold(double val) {
    state = state.copyWith(minRetentionThreshold: val);
  }

  void selectRegion(String? id) {
    state = state.copyWith(selectedRegionId: id);

    if (id != null) {
      try {
        _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
              route: '/generated/region_performance',
              eventType: 'regional_performance_drilldown',
              metadata: {
                'region_id': id,
                'timestamp': DateTime.now().toIso8601String(),
              },
            );
      } catch (_) {}
    }
  }

  void triggerQualityAudit(String regionId) {
    state = state.copyWith(isInitiatingAudit: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/region_performance',
            eventType: 'regional_quality_audit_initiated',
            metadata: {
              'region_id': regionId,
              'audit_type': 'Caregiver Retention Focus',
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1600), () {
      state = state.copyWith(isInitiatingAudit: false);
    });
  }
}

// --- Provider ---
final regionPerformanceControllerProvider =
    StateNotifierProvider<RegionPerformanceController, RegionPerformanceState>((ref) {
  return RegionPerformanceController(ref);
});

// --- View ---
class RegionPerformance extends GovernedConsumerWidget {
  const RegionPerformance({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regionPerformanceControllerProvider);
    final controller = ref.read(regionPerformanceControllerProvider.notifier);
    final theme = context.theme;

    // Filter regional datasets
    final filteredRegions = state.regions.where((reg) {
      final matchesMarket = state.activeMarketFilter == 'all' ||
          (reg['market'] as String).toLowerCase() == state.activeMarketFilter.toLowerCase();
      final matchesRetention = (reg['retention'] as double) >= state.minRetentionThreshold;
      return matchesMarket && matchesRetention;
    }).toList();

    // Calculations
    double totalRevenue = 0;
    double weightedNpsSum = 0;
    int clientCount = 0;
    for (final reg in state.regions) {
      totalRevenue += reg['revenue'] as double;
      weightedNpsSum += (reg['nps'] as double) * (reg['clients'] as int);
      clientCount += reg['clients'] as int;
    }
    final avgNps = clientCount == 0 ? 0.0 : weightedNpsSum / clientCount;

    final selectedRegion = state.selectedRegionId == null
        ? null
        : state.regions.firstWhere((r) => r['id'] == state.selectedRegionId);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.barChart4, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'CEO Multi-Regional KPIs',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Territory Performance Ledger',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Drill down into local branch client acquisition indices, caregiver retention tracking, and staffing gap analysis.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // KPI aggregate cards
                Row(
                  children: [
                    Expanded(
                      child: _MetricItemCard(
                        title: 'Aggregate System Revenue',
                        value: '\$${totalRevenue.toStringAsFixed(2)}M',
                        icon: LucideIcons.trendingUp,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricItemCard(
                        title: 'System-wide NPS Score',
                        value: avgNps.toStringAsFixed(1),
                        icon: LucideIcons.award,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricItemCard(
                        title: 'Active Platform Clients',
                        value: clientCount.toString(),
                        icon: LucideIcons.users,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Filters panel
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Market Territory:',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          _ChipTab(
                            label: 'All Markets',
                            value: 'all',
                            activeValue: state.activeMarketFilter,
                            onTap: controller.updateMarketFilter,
                          ),
                          _ChipTab(
                            label: 'Canada',
                            value: 'canada',
                            activeValue: state.activeMarketFilter,
                            onTap: controller.updateMarketFilter,
                          ),
                          _ChipTab(
                            label: 'USA',
                            value: 'usa',
                            activeValue: state.activeMarketFilter,
                            onTap: controller.updateMarketFilter,
                          ),
                          _ChipTab(
                            label: 'International',
                            value: 'international',
                            activeValue: state.activeMarketFilter,
                            onTap: controller.updateMarketFilter,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(LucideIcons.slidersHorizontal, size: 18, color: theme.colors.onSurfaceVariant),
                      const SizedBox(width: 12),
                      Text(
                        'Min Retention: ${state.minRetentionThreshold.toInt()}%',
                        style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 160,
                        child: Slider(
                          value: state.minRetentionThreshold,
                          min: 0.0,
                          max: 95.0,
                          divisions: 19,
                          activeColor: theme.colors.primary,
                          onChanged: controller.updateThreshold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Graphical Matrix & List
                Expanded(
                  child: filteredRegions.isEmpty
                      ? Center(
                          child: Text(
                            'No regional statistics found matching filters.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredRegions.length,
                          itemBuilder: (context, index) {
                            final reg = filteredRegions[index];
                            final regId = reg['id'] as String;
                            final retention = reg['retention'] as double;
                            final nps = reg['nps'] as double;
                            final isUnderPerforming = retention < 90.0 || nps < 88.0;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              (reg['name'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: theme.colors.primary.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(theme.radiusSm),
                                              ),
                                              child: Text(
                                                (reg['market'] as String),
                                                style: theme.typography.bodySmall.copyWith(
                                                  color: theme.colors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Visual metric bars (Retention % & NPS)
                                        _ProgressBar(
                                          label: 'Caregiver Retention',
                                          value: retention / 100.0,
                                          valueText: '$retention%',
                                          activeColor: retention > 95 ? Colors.green : (retention < 90 ? Colors.red : Colors.blue),
                                        ),
                                        const SizedBox(height: 8),
                                        _ProgressBar(
                                          label: 'Client Net Promoter Score',
                                          value: nps / 100.0,
                                          valueText: nps.toStringAsFixed(0),
                                          activeColor: nps > 90 ? Colors.green : (nps < 87 ? Colors.amber : Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        _SmallStat(
                                          label: 'Revenue',
                                          value: '\$${reg['revenue']}M',
                                        ),
                                        _SmallStat(
                                          label: 'Caregivers',
                                          value: reg['caregivers'].toString(),
                                        ),
                                        _SmallStat(
                                          label: 'Gaps',
                                          value: reg['staffingGap'].toString(),
                                          color: (reg['staffingGap'] as int) > 15 ? Colors.red : theme.colors.onSurface,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isUnderPerforming ? Colors.red.withValues(alpha: 0.1) : theme.colors.background,
                                      foregroundColor: isUnderPerforming ? Colors.red : theme.colors.primary,
                                      elevation: 0,
                                      side: BorderSide(
                                        color: isUnderPerforming ? Colors.red : theme.colors.border,
                                      ),
                                    ),
                                    onPressed: () => controller.selectRegion(regId),
                                    child: const Text('Drilldown'),
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

          // Right Drilldown Panel
          if (selectedRegion != null)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 400,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(-2, 0),
                    ),
                  ],
                  border: Border(left: BorderSide(color: theme.colors.border)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Regional Deep Dive',
                          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.x),
                          onPressed: () => controller.selectRegion(null),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      (selectedRegion['name'] as String),
                      style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                    ),
                    Text(
                      'Market Zone: ${selectedRegion['market']}',
                      style: theme.typography.bodyLarge.copyWith(color: theme.colors.primary),
                    ),
                    const SizedBox(height: 24),
                    _DetailsRow(label: 'Total Active Clients', value: selectedRegion['clients'].toString()),
                    _DetailsRow(label: 'Staff Roster Size', value: '${selectedRegion['caregivers']} Caregivers'),
                    _DetailsRow(label: 'Net Profit Margin Ratio', value: '28.4% (Forecasted)'),
                    _DetailsRow(label: 'Regional Growth Index', value: '+${selectedRegion['growth']}% YoY'),
                    _DetailsRow(
                      label: 'Staffing Shortages',
                      value: '${selectedRegion['staffingGap']} Shifts Unallocated',
                      valueColor: (selectedRegion['staffingGap'] as int) > 15 ? Colors.red : Colors.green,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Licensing & Local Regulations:',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colors.background,
                        borderRadius: BorderRadius.circular(theme.radiusSm),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BulletPoint(text: 'State/Provincial License: COMPLIANT'),
                          SizedBox(height: 6),
                          _BulletPoint(text: 'Nurse Practice Act audit score: 98%'),
                          SizedBox(height: 6),
                          _BulletPoint(text: 'Active marketing budget pool: \$12,500/mo'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (state.isInitiatingAudit)
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('Compiling audit traces...'),
                          ],
                        ),
                      )
                    else ...[
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colors.primary,
                            foregroundColor: theme.colors.onPrimary,
                          ),
                          onPressed: () => controller.triggerQualityAudit((selectedRegion['id'] as String)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.shieldCheck, size: 18, color: theme.colors.onPrimary),
                              const SizedBox(width: 8),
                              const Text('Initiate Quality & Safety Audit'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricItemCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricItemCard({
    required this.title,
    required this.value,
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
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChipTab extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _ChipTab({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusSm),
          border: Border.all(
            color: isActive ? theme.colors.primary : theme.colors.border,
          ),
        ),
        child: Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: isActive ? theme.colors.onPrimary : theme.colors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final String label;
  final double value;
  final String valueText;
  final Color activeColor;

  const _ProgressBar({
    required this.label,
    required this.value,
    required this.valueText,
    required this.activeColor,
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
              label,
              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            Text(
              valueText,
              style: theme.typography.bodySmall.copyWith(
                color: theme.colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(theme.radiusSm),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: theme.colors.background,
            valueColor: AlwaysStoppedAnimation<Color>(activeColor),
          ),
        ),
      ],
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _SmallStat({
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        Text(
          value,
          style: theme.typography.bodyLarge.copyWith(
            color: color ?? theme.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _DetailsRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailsRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          Text(
            value,
            style: theme.typography.bodyMedium.copyWith(
              color: valueColor ?? theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(LucideIcons.check, size: 14, color: theme.colors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

