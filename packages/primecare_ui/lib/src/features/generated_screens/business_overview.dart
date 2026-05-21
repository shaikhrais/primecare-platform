import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class BusinessOverviewState {
  final List<Map<String, dynamic>> operationalEvents;
  final String selectedBranch;
  final int activeClients;
  final double monthlyRevenue;
  final double utilizationRate;
  final bool isMutatingState;

  const BusinessOverviewState({
    required this.operationalEvents,
    required this.selectedBranch,
    required this.activeClients,
    required this.monthlyRevenue,
    required this.utilizationRate,
    required this.isMutatingState,
  });

  BusinessOverviewState copyWith({
    List<Map<String, dynamic>>? operationalEvents,
    String? selectedBranch,
    int? activeClients,
    double? monthlyRevenue,
    double? utilizationRate,
    bool? isMutatingState,
  }) {
    return BusinessOverviewState(
      operationalEvents: operationalEvents ?? this.operationalEvents,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      activeClients: activeClients ?? this.activeClients,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      utilizationRate: utilizationRate ?? this.utilizationRate,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class BusinessOverviewController extends StateNotifier<BusinessOverviewState> {
  final Ref _ref;

  BusinessOverviewController(this._ref)
      : super(
          const BusinessOverviewState(
            operationalEvents: [
              {
                'id': 'evt-501',
                'description': 'Caregiver Jane Doe clocked in for Arthur Pendelton',
                'timestamp': '2026-05-20 09:30',
                'category': 'Attendance',
              },
              {
                'id': 'evt-502',
                'description': 'New Referral intake approved: James Anderson',
                'timestamp': '2026-05-20 08:45',
                'category': 'Sales',
              },
              {
                'id': 'evt-503',
                'description': 'Invoice INV-2026-003 marked as PAID',
                'timestamp': '2026-05-19 16:15',
                'category': 'Finance',
              },
              {
                'id': 'evt-504',
                'description': 'Incident resolved for Arthur Pendelton by Clinical Director',
                'timestamp': '2026-05-19 14:00',
                'category': 'Clinical',
              },
            ],
            selectedBranch: 'Toronto West Branch',
            activeClients: 120,
            monthlyRevenue: 154000.00,
            utilizationRate: 0.88,
            isMutatingState: false,
          ),
        );

  void selectBranch(String branch) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/business_overview',
            eventType: 'franchise_branch_selected',
            metadata: {'branch': branch},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      double revenueScale = branch.contains('Toronto') ? 1.0 : (branch.contains('Hamilton') ? 0.75 : 0.6);
      int clientScale = branch.contains('Toronto') ? 120 : (branch.contains('Hamilton') ? 90 : 70);

      state = state.copyWith(
        selectedBranch: branch,
        activeClients: clientScale,
        monthlyRevenue: 154000.00 * revenueScale,
        utilizationRate: 0.88 * (revenueScale + 0.2).clamp(0.5, 0.95),
        isMutatingState: false,
      );
    });
  }

  void triggerBranchSync() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/business_overview',
            eventType: 'franchise_branch_sync',
            metadata: {'branch': state.selectedBranch},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      state = state.copyWith(isMutatingState: false);
    });
  }
}

// --- Provider ---
final businessOverviewControllerProvider =
    StateNotifierProvider<BusinessOverviewController, BusinessOverviewState>((ref) {
  return BusinessOverviewController(ref);
});

// --- View ---
class BusinessOverview extends GovernedConsumerWidget {
  const BusinessOverview({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(businessOverviewControllerProvider);
    final controller = ref.read(businessOverviewControllerProvider.notifier);
    final theme = context.theme;

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
              'Franchise Owner Business Control Center',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.triggerBranchSync(),
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              label: const Text('Sync Branch'),
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
                          'Franchise Command Overview',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Track patient utilization scales, audit live dispatcher caregiver assignments, and monitor MRR pools.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: state.selectedBranch,
                      onChanged: (val) {
                        if (val != null) controller.selectBranch(val);
                      },
                      items: const [
                        DropdownMenuItem(value: 'Toronto West Branch', child: Text('Toronto West Branch')),
                        DropdownMenuItem(value: 'Hamilton Central Branch', child: Text('Hamilton Central Branch')),
                        DropdownMenuItem(value: 'London North Branch', child: Text('London North Branch')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Metrics Row
                Row(
                  children: [
                    Expanded(
                      child: _OverviewMetric(
                        title: 'Active Patient Roster',
                        value: '${state.activeClients}',
                        icon: LucideIcons.users,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _OverviewMetric(
                        title: 'Monthly Revenue',
                        value: '\$${state.monthlyRevenue.toStringAsFixed(2)}',
                        icon: LucideIcons.dollarSign,
                        iconColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _OverviewMetric(
                        title: 'Staff Utilization Rate',
                        value: '${(state.utilizationRate * 100).toStringAsFixed(1)}%',
                        icon: LucideIcons.percent,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Operational Logs
                Text(
                  'Recent Operational Activities',
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
                    itemCount: state.operationalEvents.length,
                    separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                    itemBuilder: (context, index) {
                      final item = state.operationalEvents[index];
                      final cat = item['category'];
                      final catColor = cat == 'Attendance'
                          ? Colors.amber
                          : cat == 'Sales'
                              ? Colors.green
                              : cat == 'Finance'
                                  ? Colors.purple
                                  : Colors.blue;

                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: catColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cat == 'Attendance'
                                ? LucideIcons.clock
                                : cat == 'Sales'
                                    ? LucideIcons.userPlus
                                    : cat == 'Finance'
                                        ? LucideIcons.creditCard
                                        : LucideIcons.activity,
                            color: catColor,
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
                        subtitle: Text('${item['category']} • Recorded ${item['timestamp']}'),
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

class _OverviewMetric extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _OverviewMetric({
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
