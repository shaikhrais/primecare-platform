// Governance - Category: service | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class OperationsBoardState {
  final List<Map<String, dynamic>> activeAlerts;
  final String searchQuery;
  final String activeSeverityFilter;
  final bool isMutatingState;

  const OperationsBoardState({
    required this.activeAlerts,
    required this.searchQuery,
    required this.activeSeverityFilter,
    required this.isMutatingState,
  });

  OperationsBoardState copyWith({
    List<Map<String, dynamic>>? activeAlerts,
    String? searchQuery,
    String? activeSeverityFilter,
    bool? isMutatingState,
  }) {
    return OperationsBoardState(
      activeAlerts: activeAlerts ?? this.activeAlerts,
      searchQuery: searchQuery ?? this.searchQuery,
      activeSeverityFilter: activeSeverityFilter ?? this.activeSeverityFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class OperationsBoardController extends StateNotifier<OperationsBoardState> {
  final Ref _ref;

  OperationsBoardController(this._ref)
      : super(
          const OperationsBoardState(
            activeAlerts: [
              {
                'id': 'alt-101',
                'title': 'Caregiver Check-In Delay',
                'description': 'David Miller is late by 18 minutes for his shift with client James Wilson.',
                'severity': 'high',
                'timestamp': '10 mins ago',
                'assignedTo': 'Unassigned',
                'status': 'Open',
              },
              {
                'id': 'alt-102',
                'title': 'GPS Proximity Variance Alert',
                'description': 'Sarah Jenkins is checked in, but GPS coordinate logs place her 1.2 miles away from client.',
                'severity': 'medium',
                'timestamp': '22 mins ago',
                'assignedTo': 'Admin-1',
                'status': 'Investigating',
              },
              {
                'id': 'alt-103',
                'title': 'Critical ADL Log Skipping',
                'description': 'ADL daily task logging not completed by check-out time for client Margaret Thompson.',
                'severity': 'high',
                'timestamp': '45 mins ago',
                'assignedTo': 'Unassigned',
                'status': 'Open',
              },
              {
                'id': 'alt-104',
                'title': 'Client Rating Feedback Low',
                'description': 'Patient satisfaction scorecard submitted with a rating of 2/5 stars.',
                'severity': 'low',
                'timestamp': '1 hour ago',
                'assignedTo': 'Resolved',
                'status': 'Resolved',
              },
            ],
            searchQuery: '',
            activeSeverityFilter: 'all',
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateSeverityFilter(String filter) {
    state = state.copyWith(activeSeverityFilter: filter);
  }

  void acknowledgeAlert(String alertId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/operations_board',
            eventType: 'alert_acknowledged',
            metadata: {'alertId': alertId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.activeAlerts.map((a) {
        if (a['id'] == alertId) {
          return {
            ...a,
            'status': 'Investigating',
            'assignedTo': 'Marcus Aurelius (COO)',
          };
        }
        return a;
      }).toList();

      state = state.copyWith(
        activeAlerts: updated,
        isMutatingState: false,
      );
    });
  }

  void resolveAlert(String alertId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/operations_board',
            eventType: 'alert_resolved',
            metadata: {'alertId': alertId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.activeAlerts.map((a) {
        if (a['id'] == alertId) {
          return {
            ...a,
            'status': 'Resolved',
            'assignedTo': 'Resolved',
          };
        }
        return a;
      }).toList();

      state = state.copyWith(
        activeAlerts: updated,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final operationsBoardControllerProvider =
    StateNotifierProvider<OperationsBoardController, OperationsBoardState>((ref) {
  return OperationsBoardController(ref);
});

// --- View ---
class OperationsBoard extends GovernedConsumerWidget {
  const OperationsBoard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operationsBoardControllerProvider);
    final controller = ref.read(operationsBoardControllerProvider.notifier);
    final theme = context.theme;

    // Filter alerts
    final filteredAlerts = state.activeAlerts.where((a) {
      final matchesSearch = (a['title'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (a['description'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesFilter = state.activeSeverityFilter == 'all' ||
          (a['severity'] as String).toLowerCase() == state.activeSeverityFilter.toLowerCase();
      return matchesSearch && matchesFilter;
    }).toList();

    // Summary calculations
    final openCount = state.activeAlerts.where((a) => a['status'] == 'Open').length;
    final highCount = state.activeAlerts.where((a) => a['severity'] == 'high' && a['status'] != 'Resolved').length;
    final activeCount = state.activeAlerts.where((a) => a['status'] != 'Resolved').length;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.activity, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'COO Operational Intelligence Command',
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
                // Top Heading
                Text(
                  'Operations Command Dashboard',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Real-time staffing health indices, check-in tracking, and urgent ADL escalations.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Live Metrics Grids
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'Active Operations',
                        value: '$activeCount',
                        subtitle: 'Alerts Monitoring',
                        icon: LucideIcons.bellRing,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'High Severity Anomaly',
                        value: '$highCount',
                        subtitle: 'Immediate action required',
                        icon: LucideIcons.alertTriangle,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Pending Queue',
                        value: '$openCount',
                        subtitle: 'Awaiting dispatcher assign',
                        icon: LucideIcons.clock,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Controls and lists
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search operational alert logs...',
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
                          _FilterButton(
                            label: 'All Severities',
                            value: 'all',
                            activeValue: state.activeSeverityFilter,
                            onTap: controller.updateSeverityFilter,
                          ),
                          _FilterButton(
                            label: 'High Only',
                            value: 'high',
                            activeValue: state.activeSeverityFilter,
                            onTap: controller.updateSeverityFilter,
                          ),
                          _FilterButton(
                            label: 'Medium Only',
                            value: 'medium',
                            activeValue: state.activeSeverityFilter,
                            onTap: controller.updateSeverityFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Alerts list
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredAlerts.length,
                    itemBuilder: (context, index) {
                      final alert = filteredAlerts[index];
                      final isHigh = alert['severity'] == 'high';
                      final isResolved = alert['status'] == 'Resolved';

                      Color severityColor = Colors.green;
                      if (alert['severity'] == 'high') severityColor = Colors.red;
                      if (alert['severity'] == 'medium') severityColor = Colors.amber;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(
                            color: isHigh && !isResolved
                                ? Colors.red.shade200
                                : theme.colors.border,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: severityColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isHigh ? LucideIcons.shieldAlert : LucideIcons.shieldAlert,
                                color: severityColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        (alert['title'] as String),
                                        style: theme.typography.h4.copyWith(
                                          color: theme.colors.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: severityColor.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          alert['severity'].toString().toUpperCase(),
                                          style: theme.typography.bodyMedium.copyWith(
                                            color: severityColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        (alert['timestamp'] as String),
                                        style: theme.typography.bodyMedium.copyWith(
                                          color: theme.colors.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    (alert['description'] as String),
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Owner Assigned: ',
                                        style: theme.typography.bodyMedium.copyWith(
                                          color: theme.colors.onSurfaceVariant,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (alert['assignedTo'] as String),
                                        style: theme.typography.bodyMedium.copyWith(
                                          color: theme.colors.primary,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                            // Action Panel
                            if (!isResolved) ...[
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => controller.acknowledgeAlert((alert['id'] as String)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colors.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(theme.radiusMd),
                                      ),
                                    ),
                                    child: const Text('Acknowledge'),
                                  ),
                                  const SizedBox(height: 8),
                                  OutlinedButton(
                                    onPressed: () => controller.resolveAlert((alert['id'] as String)),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(theme.radiusMd),
                                      ),
                                    ),
                                    child: const Text('Resolve'),
                                  ),
                                ],
                              ),
                            ] else ...[
                              Icon(LucideIcons.checkCircle2, color: Colors.green, size: 24),
                            ],
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
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontSize: 11),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterButton({
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
