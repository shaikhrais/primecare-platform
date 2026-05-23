// Governance - Category: view | Purpose: Core implementation file for the Incident Reviews platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class IncidentReviewsState {
  final List<Map<String, dynamic>> incidents;
  final String searchQuery;
  final String activeSeverityFilter;
  final bool isResolving;
  final String? activeResolvingId;

  const IncidentReviewsState({
    required this.incidents,
    required this.searchQuery,
    required this.activeSeverityFilter,
    required this.isResolving,
    this.activeResolvingId,
  });

  IncidentReviewsState copyWith({
    List<Map<String, dynamic>>? incidents,
    String? searchQuery,
    String? activeSeverityFilter,
    bool? isResolving,
    String? activeResolvingId,
  }) {
    return IncidentReviewsState(
      incidents: incidents ?? this.incidents,
      searchQuery: searchQuery ?? this.searchQuery,
      activeSeverityFilter: activeSeverityFilter ?? this.activeSeverityFilter,
      isResolving: isResolving ?? this.isResolving,
      activeResolvingId: activeResolvingId ?? this.activeResolvingId,
    );
  }
}

// --- Controller ---
class IncidentReviewsController extends StateNotifier<IncidentReviewsState> {
  final Ref _ref;

  IncidentReviewsController(this._ref)
      : super(
          const IncidentReviewsState(
            incidents: [
              {
                'id': 'inc-901',
                'caregiver': 'Elena Rostova',
                'client': 'Aria Vance',
                'severity': 'High',
                'description': 'Fall in restroom during ADL transfers. Minor contusion resolved with ice.',
                'date': '2026-05-18',
                'status': 'Pending Compliance Review',
              },
              {
                'id': 'inc-902',
                'caregiver': 'Marcus Brody',
                'client': 'Diana Prince',
                'severity': 'Critical',
                'description': 'Medication dosage mismatch. Client given 10mg instead of 5mg of standard care script. Physician alerted.',
                'date': '2026-05-17',
                'status': 'Under Investigation',
              },
              {
                'id': 'inc-903',
                'caregiver': 'Sara Connor',
                'client': 'John Connor',
                'severity': 'Low',
                'description': 'Late clock-out due to transportation delay. No client harm.',
                'date': '2026-05-15',
                'status': 'Resolved Compliance Passed',
              },
            ],
            searchQuery: '',
            activeSeverityFilter: 'all',
            isResolving: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateSeverityFilter(String severity) {
    state = state.copyWith(activeSeverityFilter: severity);
  }

  void resolveIncident(String id) {
    state = state.copyWith(
      isResolving: true,
      activeResolvingId: id,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/incident_reviews',
            eventType: 'incident_resolution_triggered',
            metadata: {
              'incident_id': id,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1300), () {
      final updated = state.incidents.map((inc) {
        if (inc['id'] == id) {
          return {
            ...inc,
            'status': 'Resolved Compliance Passed',
          };
        }
        return inc;
      }).toList();

      state = state.copyWith(
        incidents: updated,
        isResolving: false,
        activeResolvingId: null,
      );
    });
  }
}

// --- Provider ---
final incidentReviewsControllerProvider =
    StateNotifierProvider<IncidentReviewsController, IncidentReviewsState>((ref) {
  return IncidentReviewsController(ref);
});

// --- View ---
class IncidentReviews extends GovernedConsumerWidget {
  const IncidentReviews({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(incidentReviewsControllerProvider);
    final controller = ref.read(incidentReviewsControllerProvider.notifier);
    final theme = context.theme;

    // Filter incidents
    final filteredIncidents = state.incidents.where((inc) {
      final matchesSearch = (inc['caregiver'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (inc['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (inc['description'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesSeverity = state.activeSeverityFilter == 'all' ||
          (inc['severity'] as String).toLowerCase() == state.activeSeverityFilter.toLowerCase();
      return matchesSearch && matchesSeverity;
    }).toList();

    // Stats calculations
    int totalIncidents = 0;
    int criticalCount = 0;
    int pendingCount = 0;
    for (final inc in state.incidents) {
      totalIncidents++;
      if (inc['severity'] == 'Critical') {
        criticalCount++;
      }
      if (inc['status'] != 'Resolved Compliance Passed') {
        pendingCount++;
      }
    }

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.fileWarning, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'COO Incident Compliance Command',
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
                          'Incident Compliance Reviews',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Audit caregiver incident reports, track state licensing regulations compliance, and execute medical incident sweeps.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // KPIs Cards
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'Total Logs Flagged',
                        value: '$totalIncidents',
                        icon: LucideIcons.clipboardList,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Pending Resolution',
                        value: '$pendingCount reviews',
                        icon: LucideIcons.clock,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Critical Severity Escalations',
                        value: '$criticalCount active',
                        icon: LucideIcons.shieldAlert,
                        color: criticalCount > 0 ? Colors.red : Colors.green,
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by caregiver, client, or description details...',
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
                            label: 'All Severities',
                            value: 'all',
                            activeValue: state.activeSeverityFilter,
                            onTap: controller.updateSeverityFilter,
                          ),
                          _FilterChip(
                            label: 'Critical Only',
                            value: 'critical',
                            activeValue: state.activeSeverityFilter,
                            onTap: controller.updateSeverityFilter,
                          ),
                          _FilterChip(
                            label: 'High Severity',
                            value: 'high',
                            activeValue: state.activeSeverityFilter,
                            onTap: controller.updateSeverityFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Incident Roster list
                Expanded(
                  child: filteredIncidents.isEmpty
                      ? Center(
                          child: Text(
                            'Perfect compliance record. No incidents logged.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredIncidents.length,
                          itemBuilder: (context, index) {
                            final inc = filteredIncidents[index];
                            final id = inc['id'] as String;
                            final severity = inc['severity'];
                            final status = inc['status'] as String;
                            final isCritical = severity == 'Critical';
                            final isHigh = severity == 'High';
                            final isResolved = status == 'Resolved Compliance Passed';

                            final severityColor = isCritical
                                ? Colors.red
                                : isHigh
                                    ? Colors.orange
                                    : Colors.blue;

                            final statusColor = isResolved ? Colors.green : Colors.amber;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: severityColor.withValues(alpha: 0.1),
                                    child: Icon(
                                      isCritical ? LucideIcons.octagon : LucideIcons.alertTriangle,
                                      color: severityColor,
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
                                              (inc['caregiver'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(LucideIcons.arrowRight, size: 14, color: theme.colors.onSurfaceVariant),
                                            const SizedBox(width: 8),
                                            Text(
                                              (inc['client'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: severityColor.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: severityColor.withValues(alpha: 0.2)),
                                              ),
                                              child: Text(
                                                '$severity Severity',
                                                style: TextStyle(
                                                  color: severityColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          (inc['description'] as String),
                                          style: theme.typography.bodyMedium.copyWith(
                                            color: theme.colors.onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Logged on: ${inc['date']} • Resolution status: $status',
                                          style: theme.typography.bodyMedium.copyWith(
                                            color: theme.colors.onSurfaceVariant,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  if (!isResolved)
                                    ElevatedButton(
                                      onPressed: state.isResolving
                                          ? null
                                          : () => controller.resolveIncident(id),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colors.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(theme.radiusMd),
                                        ),
                                      ),
                                      child: const Text('Sign-off Review'),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(theme.radiusMd),
                                        border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                                      ),
                                      child: Text(
                                        status,
                                        style: theme.typography.bodySmall.copyWith(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
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
          if (state.isResolving)
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
                          'Transmitting Incident Compliance Sign-Off...',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Logging signature validation keys into state compliance directory...',
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

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
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

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterChip({
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
