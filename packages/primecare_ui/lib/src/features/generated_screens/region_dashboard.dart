import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Governance - Category: view | Purpose: UI Screen component rendering the Region Dashboard workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RegionDashboardState {
  final List<Map<String, dynamic>> branches;
  final List<Map<String, dynamic>> coordinators;
  final List<Map<String, dynamic>> unassignedClients;
  final String searchQuery;
  final String activeStatusFilter;
  final bool isMutatingState;

  const RegionDashboardState({
    required this.branches,
    required this.coordinators,
    required this.unassignedClients,
    required this.searchQuery,
    required this.activeStatusFilter,
    required this.isMutatingState,
  });

  RegionDashboardState copyWith({
    List<Map<String, dynamic>>? branches,
    List<Map<String, dynamic>>? coordinators,
    List<Map<String, dynamic>>? unassignedClients,
    String? searchQuery,
    String? activeStatusFilter,
    bool? isMutatingState,
  }) {
    return RegionDashboardState(
      branches: branches ?? this.branches,
      coordinators: coordinators ?? this.coordinators,
      unassignedClients: unassignedClients ?? this.unassignedClients,
      searchQuery: searchQuery ?? this.searchQuery,
      activeStatusFilter: activeStatusFilter ?? this.activeStatusFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class RegionDashboardController extends StateNotifier<RegionDashboardState> {
  final Ref ref;
  final Ref _ref;

  RegionDashboardController(this._ref)
      : super(
          const RegionDashboardState(
            branches: [
              {
                'id': 'br-101',
                'name': 'Toronto East Hub',
                'caregivers': 45,
                'clients': 120,
                'ratio': 2.6,
                'status': 'Normal',
              },
              {
                'id': 'br-102',
                'name': 'Toronto West Hub',
                'caregivers': 28,
                'clients': 98,
                'ratio': 3.5,
                'status': 'Critical',
              },
              {
                'id': 'br-103',
                'name': 'Mississauga Central',
                'caregivers': 52,
                'clients': 130,
                'ratio': 2.5,
                'status': 'Normal',
              },
            ],
            coordinators: [
              {
                'id': 'co-01',
                'name': 'Alice Vance',
                'status': 'Active',
                'branch': 'Toronto East Hub',
              },
              {
                'id': 'co-02',
                'name': 'Bob Miller',
                'status': 'Away',
                'branch': 'Toronto West Hub',
              },
              {
                'id': 'co-03',
                'name': 'Clara Jenkins',
                'status': 'Active',
                'branch': 'Mississauga Central',
              },
            ],
            unassignedClients: [
              {
                'id': 'cl-901',
                'name': 'James Wilson',
                'branch': 'Toronto West Hub',
                'type': 'PSW Morning Care',
                'urgency': 'high',
              },
              {
                'id': 'cl-902',
                'name': 'Sarah Connor',
                'branch': 'Toronto East Hub',
                'type': 'RPN Afternoon Visit',
                'urgency': 'medium',
              },
              {
                'id': 'cl-903',
                'name': 'Bruce Wayne',
                'branch': 'Mississauga Central',
                'type': 'Companion Night Shift',
                'urgency': 'low',
              },
            ],
            searchQuery: '',
            activeStatusFilter: 'all',
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateStatusFilter(String filter) {
    state = state.copyWith(activeStatusFilter: filter);
  }

  void reassignStaff(String sourceId, String targetId, int count) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/offices/franchise/roles/regional_manager/dashboard',
            eventType: 'regional_staff_redeployed',
            metadata: {
              'sourceBranch': sourceId,
              'targetBranch': targetId,
              'caregiverCount': count,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final updated = state.branches.map((b) {
        if (b['id'] == sourceId) {
          final nextCaregivers = (b['caregivers'] as int) - count;
          final double nextRatio = double.parse(((b['clients'] as int) / nextCaregivers).toStringAsFixed(1));
          final nextStatus = nextRatio > 3.0 ? 'Critical' : 'Normal';
          return {
            ...b,
            'caregivers': nextCaregivers,
            'ratio': nextRatio,
            'status': nextStatus,
          };
        }
        if (b['id'] == targetId) {
          final nextCaregivers = (b['caregivers'] as int) + count;
          final double nextRatio = double.parse(((b['clients'] as int) / nextCaregivers).toStringAsFixed(1));
          final nextStatus = nextRatio > 3.0 ? 'Critical' : 'Normal';
          return {
            ...b,
            'caregivers': nextCaregivers,
            'ratio': nextRatio,
            'status': nextStatus,
          };
        }
        return b;
      }).toList();

      state = state.copyWith(
        branches: updated,
        isMutatingState: false,
      );
    });
  }

  void autoMatchCaregiver(String clientId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/offices/franchise/roles/regional_manager/dashboard',
            eventType: 'caregiver_auto_matched',
            metadata: {'clientId': clientId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final targetClient = state.unassignedClients.firstWhere((c) => c['id'] == clientId);
      final branchName = targetClient['branch'] as String;

      // Update caregiver count in the matching branch
      final updatedBranches = state.branches.map((b) {
        if (b['name'] == branchName) {
          final nextCaregivers = (b['caregivers'] as int) + 1;
          final double nextRatio = double.parse(((b['clients'] as int) / nextCaregivers).toStringAsFixed(1));
          final nextStatus = nextRatio > 3.0 ? 'Critical' : 'Normal';
          return {
            ...b,
            'caregivers': nextCaregivers,
            'ratio': nextRatio,
            'status': nextStatus,
          };
        }
        return b;
      }).toList();

      final updatedClients = state.unassignedClients.where((c) => c['id'] != clientId).toList();

      state = state.copyWith(
        branches: updatedBranches,
        unassignedClients: updatedClients,
        isMutatingState: false,
      );
    });
  }

  void toggleCoordinatorStatus(String id) {
    final updated = state.coordinators.map((c) {
      if (c['id'] == id) {
        final nextStatus = c['status'] == 'Active' ? 'Away' : 'Active';
        return {...c, 'status': nextStatus};
      }
      return c;
    }).toList();

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/offices/franchise/roles/regional_manager/dashboard',
            eventType: 'coordinator_status_toggled',
            metadata: {'coordinatorId': id},
          );
    } catch (_) {}

    state = state.copyWith(coordinators: updated);
  }
}

// --- Provider ---
final regionDashboardControllerProvider =
    StateNotifierProvider<RegionDashboardController, RegionDashboardState>((ref) {
  return RegionDashboardController(ref);
});

// --- View ---
class RegionDashboard extends GovernedConsumerWidget {
  const RegionDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regionDashboardControllerProvider);
    final controller = ref.read(regionDashboardControllerProvider.notifier);
    final theme = context.theme;

    // Filter branches
    final filteredBranches = state.branches.where((b) {
      final matchesSearch = (b['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesStatus = state.activeStatusFilter == 'all' ||
          (b['status'] as String).toLowerCase() == state.activeStatusFilter.toLowerCase();
      return matchesSearch && matchesStatus;
    }).toList();

    // Filter clients
    final filteredClients = state.unassignedClients.where((c) {
      return (c['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (c['branch'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (c['type'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.map, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Regional Operations & Staffing Command',
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
                // Top Header Text
                Text(
                  'Territory Command Dashboard',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Redeploy caregivers, monitor clinical ratio bottlenecks, and audit regional coordinators.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Live Stats / Filter Bar
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
                        child: TextField(key: const Key('region_dashboard_textfield_input_1'), 
                          decoration: InputDecoration(
                            hintText: 'Search branches or clients...',
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
                          _FilterChip(
                            label: 'All Branches',
                            value: 'all',
                            activeFilter: state.activeStatusFilter,
                            onTap: controller.updateStatusFilter,
                          ),
                          _FilterChip(
                            label: 'Critical Shortage',
                            value: 'critical',
                            activeFilter: state.activeStatusFilter,
                            onTap: controller.updateStatusFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Main Dashboard Body: Left side (Branches), Right side (Unassigned & Coordinators)
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Branch Cards List & Ratios Redeployment Simulator
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Territory Hub Networks',
                              style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: ListView.builder(
                                itemCount: filteredBranches.length,
                                itemBuilder: (context, index) {
                                  final branch = filteredBranches[index];
                                  final isCritical = branch['status'] == 'Critical';
                                  final Color statusColor = isCritical ? Colors.red : Colors.green;

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: theme.colors.surface,
                                      borderRadius: BorderRadius.circular(theme.radiusMd),
                                      border: Border.all(
                                        color: isCritical ? Colors.red.shade300 : theme.colors.border,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: statusColor.withValues(alpha: 0.1),
                                          child: Icon(LucideIcons.home, color: statusColor),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (branch['name'] as String),
                                                style: theme.typography.h4.copyWith(
                                                  color: theme.colors.onSurface,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Caregivers: ${branch['caregivers']}   |   Clients: ${branch['clients']}',
                                                    style: theme.typography.bodyMedium.copyWith(
                                                      color: theme.colors.onSurfaceVariant,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Ratio: ${branch['ratio']}',
                                              style: theme.typography.h4.copyWith(
                                                color: isCritical ? Colors.red : theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              branch['status'].toString().toUpperCase(),
                                              style: theme.typography.bodyMedium.copyWith(
                                                color: statusColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Quick Redeploy Drawer
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(LucideIcons.gitPullRequest, color: theme.colors.primary, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Regional Staffing Balance Simulator',
                                        style: theme.typography.h4.copyWith(
                                          color: theme.colors.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Instantly transfer caregivers from over-staffed branches to critical zones to balance patient load.',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: 11),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(key: const Key('region_dashboard_elevatedbutton_button_1'), 
                                          onPressed: () => controller.reassignStaff('br-103', 'br-102', 4),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: theme.colors.primary,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(theme.radiusMd),
                                            ),
                                          ),
                                          child: const Text('Rebalance: Mississauga ➜ Toronto West (-4 Caregivers)'),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Right Column: Unassigned Clients & Coordinators Lists
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Coordinators Grid
                            Text(
                              'Regional Coordinators',
                              style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Column(
                                children: state.coordinators.map((co) {
                                  final isActive = co['status'] == 'Active';
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: theme.colors.background,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          LucideIcons.user,
                                          color: isActive ? theme.colors.primary : theme.colors.onSurfaceVariant,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (co['name'] as String),
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                (co['branch'] as String),
                                                style: TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => controller.toggleCoordinatorStatus((co['id'] as String)),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: isActive 
                                                  ? Colors.green.withValues(alpha: 0.1) 
                                                  : Colors.grey.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: isActive ? Colors.green : Colors.grey,
                                              ),
                                            ),
                                            child: Text(
                                              (co['status'] as String),
                                              style: TextStyle(
                                                color: isActive ? Colors.green : Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Unassigned Clients Queue
                            Text(
                              'Unassigned Shift Roster',
                              style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: filteredClients.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(LucideIcons.checkCircle2, color: Colors.green, size: 36),
                                          const SizedBox(height: 8),
                                          Text(
                                            'All regional rosters assigned!',
                                            style: TextStyle(color: theme.colors.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: filteredClients.length,
                                      itemBuilder: (context, index) {
                                        final client = filteredClients[index];
                                        final isHigh = client['urgency'] == 'high';
                                        final Color urgencyColor = isHigh 
                                            ? Colors.red 
                                            : client['urgency'] == 'medium' 
                                                ? Colors.amber 
                                                : Colors.blue;

                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: theme.colors.surface,
                                            borderRadius: BorderRadius.circular(theme.radiusMd),
                                            border: Border.all(color: theme.colors.border),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  color: urgencyColor,
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (client['name'] as String),
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${client['branch']} • ${client['type']}',
                                                      style: TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 11),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                                      decoration: BoxDecoration(
                                                        color: urgencyColor.withValues(alpha: 0.1),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        client['urgency'].toString().toUpperCase(),
                                                        style: TextStyle(
                                                          color: urgencyColor,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 9,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              IconButton(key: const Key('region_dashboard_iconbutton_button_1'), 
                                                icon: Icon(LucideIcons.zap, color: theme.colors.primary, size: 20),
                                                onPressed: () => controller.autoMatchCaregiver((client['id'] as String)),
                                                tooltip: 'Auto-Match Caregiver',
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
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

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeFilter;
  final ValueChanged<String> onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.activeFilter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeFilter;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: isActive ? theme.colors.primary : theme.colors.border),
        ),
        child: Text(
          label,
          style: theme.typography.bodyMedium.copyWith(
            color: isActive ? Colors.white : theme.colors.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
