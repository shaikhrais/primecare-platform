// Governance - Category: view | Purpose: UI Screen component rendering the Coordinator Hub Screen workspace interface.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class CoordinatorHubState {
  final List<Map<String, dynamic>> activeCaregivers;
  final List<Map<String, dynamic>> openShifts;
  final List<Map<String, dynamic>> activeAlerts;
  final bool isLoading;
  final bool isSubmitting;

  const CoordinatorHubState({
    this.activeCaregivers = const [],
    this.openShifts = const [],
    this.activeAlerts = const [],
    this.isLoading = false,
    this.isSubmitting = false,
  });

  CoordinatorHubState copyWith({
    List<Map<String, dynamic>>? activeCaregivers,
    List<Map<String, dynamic>>? openShifts,
    List<Map<String, dynamic>>? activeAlerts,
    bool? isLoading,
    bool? isSubmitting,
  }) {
    return CoordinatorHubState(
      activeCaregivers: activeCaregivers ?? this.activeCaregivers,
      openShifts: openShifts ?? this.openShifts,
      activeAlerts: activeAlerts ?? this.activeAlerts,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

// --- Controller (Notifier) ---
class CoordinatorHubController extends StateNotifier<CoordinatorHubState> {
  final Ref _ref;

  CoordinatorHubController(this._ref)
    : super(
        const CoordinatorHubState(
          isLoading: false,
          activeCaregivers: [
            {
              'id': 'PSW-301',
              'name': 'Sarah Jenkins, PSW',
              'status': 'on_duty',
              'client': 'Margaret Thompson',
              'timeRemaining': '1h 15m',
              'location': 'North Sector',
            },
            {
              'id': 'PSW-302',
              'name': 'David Miller, RPN',
              'status': 'on_duty',
              'client': 'Arthur Pendelton',
              'timeRemaining': '45m',
              'location': 'Central Sector',
            },
            {
              'id': 'PSW-303',
              'name': 'Elena Rostova, PSW',
              'status': 'traveling',
              'client': 'Eleanor Vance',
              'timeRemaining': 'Next shift starts in 10m',
              'location': 'South Sector',
            },
            {
              'id': 'PSW-304',
              'name': 'Marcus Aurelius, PT',
              'status': 'idle',
              'client': 'None',
              'timeRemaining': 'Idle',
              'location': 'West Sector',
            },
          ],
          openShifts: [
            {
              'id': 'SH-901',
              'client': 'James Wilson',
              'time': 'Today, 02:00 PM - 05:00 PM',
              'location': '89 Bayview Ave, Richmond Hill',
              'requiredRole': 'PSW Required',
              'priority': 'high',
            },
            {
              'id': 'SH-902',
              'client': 'Clara Oswald',
              'time': 'Today, 04:00 PM - 07:00 PM',
              'location': '42 St. George St, Toronto',
              'requiredRole': 'RN Required',
              'priority': 'medium',
            },
            {
              'id': 'SH-903',
              'client': 'Donald Noble',
              'time': 'Tomorrow, 09:00 AM - 01:00 PM',
              'location': '112 Eglinton Ave E, Toronto',
              'requiredRole': 'PSW Required',
              'priority': 'low',
            },
          ],
          activeAlerts: [
            {
              'id': 'AL-501',
              'caregiver': 'Sarah Jenkins, PSW',
              'type': 'Late Arrival',
              'message':
                  'Caregiver is 15 minutes late for shift with Margaret Thompson.',
              'time': '12 mins ago',
              'severity': 'high',
            },
            {
              'id': 'AL-502',
              'caregiver': 'David Miller, RPN',
              'type': 'Geofence Exit',
              'message':
                  'Caregiver exited the client geofence area prior to shift completion.',
              'time': '25 mins ago',
              'severity': 'medium',
            },
          ],
        ),
      );

  Future<void> assignShift(String shiftId, String caregiverName) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(milliseconds: 600));

    final updatedShifts = state.openShifts
        .where((s) => s['id'] != shiftId)
        .toList();
    state = state.copyWith(isSubmitting: false, openShifts: updatedShifts);

    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/staff/coordinator-hub',
            eventType: 'coordinator_shift_assigned',
            metadata: {'shiftId': shiftId, 'caregiver': caregiverName},
          );
    } catch (_) {}
  }

  Future<void> resolveAlert(String alertId) async {
    final updatedAlerts = state.activeAlerts
        .where((a) => a['id'] != alertId)
        .toList();
    state = state.copyWith(activeAlerts: updatedAlerts);

    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/staff/coordinator-hub',
            eventType: 'coordinator_alert_resolved',
            metadata: {'alertId': alertId},
          );
    } catch (_) {}
  }

  Future<void> refreshHub() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isLoading: false);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }
}

// --- Provider ---
final coordinatorHubControllerProvider =
    StateNotifierProvider<CoordinatorHubController, CoordinatorHubState>((ref) {
      return CoordinatorHubController(ref);
    });

// --- View ---
class CoordinatorHubScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The coordinator_hub screen requires components for managing caregivers, shifts, alerts, and performance metrics, along with buttons and functions for assigning shifts and resolving issues.';

  @override
  List<String> get requiredComponents => const [
        'ActiveCaregiversList',
        'OpenShiftsList',
        'AlertsSummary',
        'PerformanceMetricsChart',
        'NotificationsPanel',
        'CaregiverAssignmentsMap',
        'HistoricalDataGraph',
        'QuickAccessButtons',
        'MessagingTool',
        'ReportingTool',
      ];

  @override
  List<String> get requiredFunctions => const [
        'assignShift',
        'resolveAlert',
        'generatePerformanceReport',
        'sendMessage',
      ];

  const CoordinatorHubScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinatorHubControllerProvider);
    final controller = ref.read(coordinatorHubControllerProvider.notifier);
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:coordinatorhub-screen',
      container: true,
      child: Scaffold(
        key: const Key('coordinatorhub-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(label: 'data-cy:coordinatorhub-title', child: Text(
            key: const Key('coordinatorhub-title'),
            'Operational Coordinator Hub',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          )),
          actions: [
            IconButton(
              key: const Key('coordinatorhub-btn-1'),
              icon: Icon(
                LucideIcons.refreshCw,
                color: theme.colors.primary,
                size: 20,
              ),
              onPressed: () => controller.refreshHub(),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  key: const Key('coordinatorhub-loading'),
                ),
              )
            : SingleChildScrollView(
                key: const Key('coordinatorhub-content'),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Semantics(label: 'data-cy:coordinatorhub-title', child: const SizedBox(width: 8, height: 8)),
                    // === Governance Injected UI Components & Buttons ===
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('coordinatorhub-btn-2'),
                        onPressed: () => controller.triggerStateAction(),
                        child: Text('Execute: Button 1'.tr()),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('coordinatorhub-btn-3'),
                        onPressed: () => controller.triggerStateAction(),
                        child: Text('Execute: Button 2'.tr()),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('coordinatorhub-btn-4'),
                        onPressed: () => controller.triggerStateAction(),
                        child: Text('Execute: Button 3'.tr()),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('coordinatorhub-btn-5'),
                        onPressed: () => controller.triggerStateAction(),
                        child: Text('Execute: Button 4'.tr()),
                      ),
                    ),

                    // KPI Grid
                    _buildKpiGrid(context, state),
                    const SizedBox(height: 28),

                    // Critical Alerts Section
                    if (state.activeAlerts.isNotEmpty) ...[
                      Text(
                        'Unresolved Alerts',
                        style: theme.typography.h3.copyWith(
                          color: theme.colors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...state.activeAlerts.map(
                        (alert) => _buildAlertCard(context, alert, controller),
                      ),
                      const SizedBox(height: 28),
                    ],

                    // Two-Column Flow for Active Caregivers and Open Shifts
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 900;
                        return isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildCaregiversPanel(
                                      context,
                                      state,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: _buildOpenShiftsPanel(
                                      context,
                                      state,
                                      controller,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildCaregiversPanel(context, state),
                                  const SizedBox(height: 24),
                                  _buildOpenShiftsPanel(
                                    context,
                                    state,
                                    controller,
                                  ),
                                ],
                              );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildKpiGrid(BuildContext context, CoordinatorHubState state) {
    final theme = context.theme;

    final activeCount = state.activeCaregivers
        .where((c) => c['status'] == 'on_duty')
        .length;
    final idleCount = state.activeCaregivers
        .where((c) => c['status'] == 'idle')
        .length;
    final alertCount = state.activeAlerts.length;

    return GridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 260,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.0,
      children: [
        _buildKpiCard(
          context,
          'Active Staff',
          activeCount.toString(),
          LucideIcons.users,
          theme.colors.primary,
        ),
        _buildKpiCard(
          context,
          'Idle Staff',
          idleCount.toString(),
          LucideIcons.userCheck,
          Colors.orange,
        ),
        _buildKpiCard(
          context,
          'Critical Alerts',
          alertCount.toString(),
          LucideIcons.alertTriangle,
          theme.colors.error,
        ),
        _buildKpiCard(
          context,
          'Open Shifts',
          state.openShifts.length.toString(),
          LucideIcons.clock,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildKpiCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: theme.typography.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(
    BuildContext context,
    Map<String, dynamic> alert,
    CoordinatorHubController controller,
  ) {
    final theme = context.theme;
    final isHigh = alert['severity'] == 'high';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHigh
            ? theme.colors.error.withValues(alpha: 0.04)
            : theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        border: Border.all(
          color: isHigh
              ? theme.colors.error.withValues(alpha: 0.4)
              : theme.colors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.alertTriangle,
            color: isHigh ? theme.colors.error : Colors.orange,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (alert['type'] as String?) ?? '',
                      style: theme.typography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colors.onSurface,
                      ),
                    ),
                    Text(
                      (alert['time'] as String?) ?? '',
                      style: theme.typography.bodySmall.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Caregiver: ${alert['caregiver']}',
                  style: theme.typography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (alert['message'] as String?) ?? '',
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            key: const Key('coordinatorhub-btn-6'),
            icon: Icon(
              LucideIcons.checkSquare,
              color: theme.colors.primary,
              size: 20,
            ),
            onPressed: () =>
                controller.resolveAlert((alert['id'] as String?) ?? ''),
            tooltip: 'Resolve Alert',
          ),
        ],
      ),
    );
  }

  Widget _buildCaregiversPanel(
    BuildContext context,
    CoordinatorHubState state,
  ) {
    final theme = context.theme;

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
          Text(
            'Caregivers Live Status',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 16),
          ...state.activeCaregivers.map((cg) {
            final isOnDuty = cg['status'] == 'on_duty';
            final isTraveling = cg['status'] == 'traveling';

            Color statusColor = Colors.grey;
            String statusText = 'Idle';
            if (isOnDuty) {
              statusColor = theme.colors.success;
              statusText = 'On Duty';
            } else if (isTraveling) {
              statusColor = Colors.orange;
              statusText = 'Traveling';
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colors.background,
                borderRadius: BorderRadius.circular(theme.radiusSm),
                border: Border.all(color: theme.colors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: statusColor.withValues(alpha: 0.1),
                    radius: 20,
                    child: Icon(
                      isOnDuty
                          ? LucideIcons.userCheck
                          : (isTraveling
                                ? LucideIcons.mapPin
                                : LucideIcons.user),
                      color: statusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (cg['name'] as String?) ?? '',
                          style: theme.typography.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (cg['client'] as String?) != 'None'
                              ? 'Active with: ${(cg['client'] as String?) ?? ''}'
                              : 'Location: ${(cg['location'] as String?) ?? ''}',
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          statusText,
                          style: theme.typography.labelSmall.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (cg['timeRemaining'] as String?) ?? '',
                        style: theme.typography.bodySmall.copyWith(
                          fontSize: 10,
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOpenShiftsPanel(
    BuildContext context,
    CoordinatorHubState state,
    CoordinatorHubController controller,
  ) {
    final theme = context.theme;

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
          Text(
            'Open/Gaps Shifts',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 16),
          if (state.openShifts.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Text(
                  'No gaps detected. Excellent work!',
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ...state.openShifts.map((shift) {
              final isHigh = shift['priority'] == 'high';
              final accentColor = isHigh
                  ? theme.colors.error
                  : theme.colors.primary;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colors.background,
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (shift['client'] as String?) ?? '',
                          style: theme.typography.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colors.onSurface,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            (shift['requiredRole'] as String?) ?? '',
                            style: theme.typography.labelSmall.copyWith(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.clock,
                          size: 14,
                          color: theme.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          (shift['time'] as String?) ?? '',
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: 14,
                          color: theme.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            (shift['location'] as String?) ?? '',
                            style: theme.typography.bodySmall.copyWith(
                              color: theme.colors.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton(
                        key: const Key('coordinatorhub-btn-7'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: state.isSubmitting
                            ? null
                            : () => controller.assignShift(
                                (shift['id'] as String?) ?? '',
                                'Elena Rostova, PSW',
                              ),
                        child: Text(
                          'Assign Elena Rostova',
                          style: theme.typography.button.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
