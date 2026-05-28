// Governance - Category: service | Purpose: Core implementation file for the Branch Operations platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class BranchOperationsState {
  final List<Map<String, dynamic>> branches;
  final String searchQuery;
  final String activeRegion;
  final bool isTriggeringRecruitment;
  final String? activeRecruitingBranchId;

  const BranchOperationsState({
    required this.branches,
    required this.searchQuery,
    required this.activeRegion,
    required this.isTriggeringRecruitment,
    this.activeRecruitingBranchId,
  });

  BranchOperationsState copyWith({
    List<Map<String, dynamic>>? branches,
    String? searchQuery,
    String? activeRegion,
    bool? isTriggeringRecruitment,
    String? activeRecruitingBranchId,
  }) {
    return BranchOperationsState(
      branches: branches ?? this.branches,
      searchQuery: searchQuery ?? this.searchQuery,
      activeRegion: activeRegion ?? this.activeRegion,
      isTriggeringRecruitment: isTriggeringRecruitment ?? this.isTriggeringRecruitment,
      activeRecruitingBranchId: activeRecruitingBranchId ?? this.activeRecruitingBranchId,
    );
  }
}

// --- Controller ---
class BranchOperationsController extends StateNotifier<BranchOperationsState> {
  final Ref _ref;

  BranchOperationsController(this._ref)
      : super(
          const BranchOperationsState(
            branches: [
              {
                'id': 'br-101',
                'name': 'Toronto Central Care Hub',
                'region': 'Ontario',
                'caregivers': 142,
                'activeShifts': 89,
                'efficiencyScore': 94.2,
                'recruitmentGap': 12,
                'recruitmentActive': false,
              },
              {
                'id': 'br-102',
                'name': 'Ottawa Valley Staffing',
                'region': 'Ontario',
                'caregivers': 98,
                'activeShifts': 54,
                'efficiencyScore': 87.5,
                'recruitmentGap': 5,
                'recruitmentActive': false,
              },
              {
                'id': 'br-103',
                'name': 'Vancouver Coastal Health',
                'region': 'British Columbia',
                'caregivers': 115,
                'activeShifts': 76,
                'efficiencyScore': 91.8,
                'recruitmentGap': 18,
                'recruitmentActive': false,
              },
              {
                'id': 'br-104',
                'name': 'Victoria Island Support',
                'region': 'British Columbia',
                'caregivers': 64,
                'activeShifts': 38,
                'efficiencyScore': 82.1,
                'recruitmentGap': 2,
                'recruitmentActive': false,
              },
              {
                'id': 'br-105',
                'name': 'Calgary Prairie Caregivers',
                'region': 'Alberta',
                'caregivers': 88,
                'activeShifts': 61,
                'efficiencyScore': 89.0,
                'recruitmentGap': 15,
                'recruitmentActive': false,
              },
            ],
            searchQuery: '',
            activeRegion: 'all',
            isTriggeringRecruitment: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateRegionFilter(String region) {
    state = state.copyWith(activeRegion: region);
  }

  void triggerRecruitmentDrive(String id) {
    state = state.copyWith(
      isTriggeringRecruitment: true,
      activeRecruitingBranchId: id,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/branch_operations',
            eventType: 'branch_recruitment_drive_triggered',
            metadata: {
              'branch_id': id,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1500), () {
      final updated = state.branches.map((br) {
        if (br['id'] == id) {
          return {
            ...br,
            'recruitmentActive': true,
            'caregivers': (br['caregivers'] as int) + 6,
            'recruitmentGap': 0,
          };
        }
        return br;
      }).toList();

      state = state.copyWith(
        branches: updated,
        isTriggeringRecruitment: false,
        activeRecruitingBranchId: null,
      );
    });
  }
}

// --- Provider ---
final branchOperationsControllerProvider =
    StateNotifierProvider<BranchOperationsController, BranchOperationsState>((ref) {
  return BranchOperationsController(ref);
});

// --- View ---
class BranchOperations extends GovernedConsumerWidget {
  const BranchOperations({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(branchOperationsControllerProvider);
    final controller = ref.read(branchOperationsControllerProvider.notifier);
    final theme = context.theme;

    // Filter branches
    final filteredBranches = state.branches.where((br) {
      final matchesSearch = (br['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (br['region'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesRegion = state.activeRegion == 'all' ||
          (br['region'] as String).toLowerCase() == state.activeRegion.toLowerCase();
      return matchesSearch && matchesRegion;
    }).toList();

    // Aggregates
    int totalCaregivers = 0;
    int totalActiveShifts = 0;
    double avgEfficiency = 0;
    int totalGaps = 0;
    for (final br in state.branches) {
      totalCaregivers += br['caregivers'] as int;
      totalActiveShifts += br['activeShifts'] as int;
      avgEfficiency += br['efficiencyScore'] as double;
      totalGaps += br['recruitmentGap'] as int;
    }
    avgEfficiency = state.branches.isNotEmpty ? (avgEfficiency / state.branches.length) : 0.0;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.gitMerge, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'COO Branch Performance & Efficiency Control',
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
                          'Regional Operations Board',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Monitor regional Hub efficiency indexes, review unallocated shift limits, and dispatch caregiver recruitment campaigns.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Aggregates row
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Total Caregivers Roster',
                        value: '$totalCaregivers',
                        icon: LucideIcons.users,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Active Operations',
                        value: '$totalActiveShifts shifts',
                        icon: LucideIcons.calendarCheck2,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Mean Efficiency',
                        value: '${avgEfficiency.toStringAsFixed(1)}%',
                        icon: LucideIcons.gauge,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Open Labor Gaps',
                        value: '$totalGaps roles',
                        icon: LucideIcons.userPlus,
                        color: totalGaps > 10 ? Colors.red : Colors.amber,
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
                      Expanded(
                        flex: 3,
                        child: TextField(key: const Key('branch_operations_textfield_input_1'), 
                          decoration: InputDecoration(
                            hintText: 'Search regional care hubs or provinces...',
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
                      Wrap(
                        spacing: 8,
                        children: [
                          _RegionChip(
                            label: 'All Regions',
                            value: 'all',
                            activeValue: state.activeRegion,
                            onTap: controller.updateRegionFilter,
                          ),
                          _RegionChip(
                            label: 'Ontario',
                            value: 'ontario',
                            activeValue: state.activeRegion,
                            onTap: controller.updateRegionFilter,
                          ),
                          _RegionChip(
                            label: 'British Columbia',
                            value: 'british columbia',
                            activeValue: state.activeRegion,
                            onTap: controller.updateRegionFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Branch Cards List
                Expanded(
                  child: filteredBranches.isEmpty
                      ? Center(
                          child: Text(
                            'No branch operations matching current parameters.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.6,
                          ),
                          itemCount: filteredBranches.length,
                          itemBuilder: (context, index) {
                            final br = filteredBranches[index];
                            final id = br['id'] as String;
                            final score = br['efficiencyScore'] as double;
                            final gap = br['recruitmentGap'] as int;
                            final recActive = br['recruitmentActive'] as bool;

                            return Container(
                              padding: const EdgeInsets.all(20),
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (br['name'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Territory Region: ${br['region']}',
                                              style: theme.typography.bodySmall.copyWith(
                                                color: theme.colors.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: score > 90
                                              ? Colors.green.withValues(alpha: 0.1)
                                              : Colors.amber.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: score > 90
                                                ? Colors.green.withValues(alpha: 0.2)
                                                : Colors.amber.withValues(alpha: 0.2),
                                          ),
                                        ),
                                        child: Text(
                                          '$score% Efficiency',
                                          style: theme.typography.bodySmall.copyWith(
                                            color: score > 90 ? Colors.green : Colors.amber,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _MetricIndicator(
                                        label: 'Caregivers',
                                        value: '${br['caregivers']}',
                                      ),
                                      _MetricIndicator(
                                        label: 'Active Shifts',
                                        value: '${br['activeShifts']}',
                                      ),
                                      _MetricIndicator(
                                        label: 'Staffing Gap',
                                        value: gap > 0 ? '$gap missing' : 'Optimal',
                                        isWarning: gap > 10,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (gap > 0)
                                        ElevatedButton.icon(
                                          onPressed: state.isTriggeringRecruitment
                                              ? null
                                              : () => controller.triggerRecruitmentDrive(id),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: theme.colors.primary,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(theme.radiusMd),
                                            ),
                                          ),
                                          icon: const Icon(LucideIcons.megaphone, size: 14),
                                          label: const Text('Dispatch Campaign'),
                                        )
                                      else if (recActive)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(theme.radiusMd),
                                            border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(LucideIcons.check, color: Colors.green, size: 14),
                                              SizedBox(width: 6),
                                              Text(
                                                'Campaign Deployed',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        Text(
                                          'Operational limits optimal',
                                          style: theme.typography.bodySmall.copyWith(
                                            color: theme.colors.onSurfaceVariant,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                    ],
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
          if (state.isTriggeringRecruitment)
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              child: Center(
                child: Card(
                  color: theme.colors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(theme.radiusLg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Broadcasting Regional Caregiver Job Ledger...',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Injecting marketing spend into local job boards and applicant tracking system (ATS)...',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
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
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
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
          )
        ],
      ),
    );
  }
}

class _RegionChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _RegionChip({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;

    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      selectedColor: theme.colors.primary.withValues(alpha: 0.2),
      backgroundColor: theme.colors.surface,
      labelStyle: TextStyle(
        color: isActive ? theme.colors.primary : theme.colors.onSurface,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(
          color: isActive ? theme.colors.primary : theme.colors.border,
        ),
      ),
      onSelected: (val) {
        if (val) onTap(value);
      },
    );
  }
}

class _MetricIndicator extends StatelessWidget {
  final String label;
  final String value;
  final bool isWarning;

  const _MetricIndicator({
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.typography.bodyMedium.copyWith(
            color: isWarning ? Colors.red : theme.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
