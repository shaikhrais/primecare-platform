// Governance - Category: view | Purpose: UI Screen component rendering the Coordinator Sos Screen workspace interface.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class CoordinatorSosState {
  final List<Map<String, dynamic>> activeAlarms;
  final Map<String, List<String>> checklistStatus; // maps alarmId to list of completed protocol steps
  final List<String> availableProtocols;
  final bool isLoading;
  final bool isBroadcasting;

  const CoordinatorSosState({
    this.activeAlarms = const [],
    this.checklistStatus = const {},
    this.availableProtocols = const [
      'Establish Audio Connection',
      'Verify Caregiver & Client Location',
      'Initiate emergency service dispatch if critical',
      'Alert Family Members / Emergency Contact',
      'Notify Director of Clinical Operations',
      'Log full compliance incident statement',
    ],
    this.isLoading = false,
    this.isBroadcasting = false,
  });

  CoordinatorSosState copyWith({
    List<Map<String, dynamic>>? activeAlarms,
    Map<String, List<String>>? checklistStatus,
    List<String>? availableProtocols,
    bool? isLoading,
    bool? isBroadcasting,
  }) {
    return CoordinatorSosState(
      activeAlarms: activeAlarms ?? this.activeAlarms,
      checklistStatus: checklistStatus ?? this.checklistStatus,
      availableProtocols: availableProtocols ?? this.availableProtocols,
      isLoading: isLoading ?? this.isLoading,
      isBroadcasting: isBroadcasting ?? this.isBroadcasting,
    );
  }
}

// --- Controller ---
class CoordinatorSosController extends StateNotifier<CoordinatorSosState> {
  final Ref _ref;

  CoordinatorSosController(this._ref)
      : super(
          const CoordinatorSosState(
            activeAlarms: [
              {
                'id': 'SOS-001',
                'caregiver': 'Sarah Jenkins, PSW',
                'client': 'Margaret Thompson',
                'severity': 'critical',
                'triggerTime': '3 mins ago',
                'location': 'North Sector (Apt 4B - 12 Elm St)',
                'reason': 'Panic Button Pressed - Physical Fall Suspected',
                'resolved': false,
              },
              {
                'id': 'SOS-002',
                'caregiver': 'David Miller, RPN',
                'client': 'Arthur Pendelton',
                'severity': 'high',
                'triggerTime': '11 mins ago',
                'location': 'Central Sector (Room 209 - Prime Residence)',
                'reason': 'Aggressive Behavior Warning Raised',
                'resolved': false,
              },
            ],
            checklistStatus: {
              'SOS-001': [],
              'SOS-002': ['Establish Audio Connection'],
            },
          ),
        );

  void toggleProtocolStep(String alarmId, String step) {
    final currentSteps = List<String>.from(state.checklistStatus[alarmId] ?? []);
    if (currentSteps.contains(step)) {
      currentSteps.remove(step);
    } else {
      currentSteps.add(step);
    }

    final newChecklist = Map<String, List<String>>.from(state.checklistStatus);
    newChecklist[alarmId] = currentSteps;

    state = state.copyWith(checklistStatus: newChecklist);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-sos',
            eventType: 'sos_protocol_step_toggled',
            metadata: {'alarmId': alarmId, 'step': step, 'completed': currentSteps.contains(step)},
          );
    } catch (_) {}
  }

  Future<void> dispatchEmergencyResponse(String alarmId, String unitName) async {
    state = state.copyWith(isBroadcasting: true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(isBroadcasting: false);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-sos',
            eventType: 'sos_response_unit_dispatched',
            metadata: {'alarmId': alarmId, 'unit': unitName},
          );
    } catch (_) {}
  }

  Future<void> resolveSos(String alarmId) async {
    final updatedAlarms = state.activeAlarms.where((a) => a['id'] != alarmId).toList();
    state = state.copyWith(activeAlarms: updatedAlarms);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-sos',
            eventType: 'sos_resolved',
            metadata: {'alarmId': alarmId},
          );
    } catch (_) {}
  }

  Future<void> sendBroadcastAlert(String message) async {
    state = state.copyWith(isBroadcasting: true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(isBroadcasting: false);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-sos',
            eventType: 'sos_broadcast_sent',
            metadata: {'message': message},
          );
    } catch (_) {}
  }

  Future<void> refreshSos() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isLoading: false);
  }
}

// --- Provider ---
final coordinatorSosControllerProvider =
    StateNotifierProvider<CoordinatorSosController, CoordinatorSosState>((ref) {
  return CoordinatorSosController(ref);
});

// --- View ---
class CoordinatorSosScreen extends GovernedConsumerWidget {
  const CoordinatorSosScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinatorSosControllerProvider);
    final controller = ref.read(coordinatorSosControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'SOS Emergency Command Center',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary, size: 20),
            onPressed: () => controller.refreshSos(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alarm Warning Banner
                  if (state.activeAlarms.isNotEmpty) _buildEmergencyBanner(context, state.activeAlarms.length),

                  const SizedBox(height: 24),

                  // Layout: Two Panels if space permits
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 950;
                      
                      final alertList = _buildAlarmList(context, state, controller);
                      final broadcastPanel = _buildBroadcastPanel(context, state, controller);

                      return isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 3, child: alertList),
                                const SizedBox(width: 24),
                                Expanded(flex: 2, child: broadcastPanel),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                alertList,
                                const SizedBox(height: 24),
                                broadcastPanel,
                              ],
                            );
                    },
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildEmergencyBanner(BuildContext context, int count) {
    final theme = context.theme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.error, width: 1.5),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.alertOctagon, color: Colors.red, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distress Signals Active',
                  style: theme.typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  '$count caregiver panic alert(s) require immediate operational attention.',
                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurface),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAlarmList(
    BuildContext context,
    CoordinatorSosState state,
    CoordinatorSosController controller,
  ) {
    final theme = context.theme;

    if (state.activeAlarms.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: theme.colors.border),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(LucideIcons.shieldAlert, size: 48, color: Colors.teal),
              const SizedBox(height: 16),
              Text(
                'All Systems Normal',
                style: theme.typography.h3.copyWith(color: Colors.teal),
              ),
              const SizedBox(height: 8),
              Text(
                'No active emergency SOS coordinates are raised at this time.',
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Emergency Signals',
          style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...state.activeAlarms.map((alarm) {
          final isCritical = alarm['severity'] == 'critical';
          final accentColor = isCritical ? Colors.red : Colors.orange;
          final completedSteps = state.checklistStatus[alarm['id']] ?? [];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: BorderRadius.circular(theme.radiusMd),
              border: Border.all(color: accentColor, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            alarm['severity'].toString().toUpperCase(),
                            style: theme.typography.labelSmall.copyWith(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                    Text(
                      'ID: ${alarm['id']}',
                      style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  (alarm['triggerTime'] as String?) ?? '',
                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Details Text
            Text(
              'Caregiver: ${alarm['caregiver']}',
              style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Client Focus: ${alarm['client']}',
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(context, LucideIcons.mapPin, (alarm['location'] as String?) ?? ''),
            _buildInfoRow(context, LucideIcons.alertTriangle, (alarm['reason'] as String?) ?? '', color: accentColor),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Incident Response Protocol Checklist
            Text(
              'Distress Protocol Execution Checklist',
              style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...state.availableProtocols.map((step) {
              final isDone = completedSteps.contains(step);
              return CheckboxListTile(
                value: isDone,
                onChanged: (_) => controller.toggleProtocolStep((alarm['id'] as String?) ?? '', step),
                title: Text(
                  step,
                  style: theme.typography.bodySmall.copyWith(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone ? theme.colors.onSurfaceVariant : theme.colors.onSurface,
                  ),
                ),
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: theme.colors.primary,
              );
            }),

            const SizedBox(height: 16),

            // Interactive Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.teal),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(LucideIcons.phoneCall, color: Colors.teal, size: 16),
                    label: const Text('Dial Caregiver', style: TextStyle(color: Colors.teal)),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(LucideIcons.shieldAlert, color: Colors.white, size: 16),
                    label: const Text('Dispatch Nurse Unit', style: TextStyle(color: Colors.white)),
                    onPressed: () => controller.dispatchEmergencyResponse((alarm['id'] as String?) ?? '', 'Rapid Response Team Alpha'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.success,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: completedSteps.length == state.availableProtocols.length
                    ? () => controller.resolveSos((alarm['id'] as String?) ?? '')
                    : null, // Force compliance flow completion
                child: const Text('Mark SOS Resolved & File Incident', style: TextStyle(color: Colors.white)),
              ),
            ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBroadcastPanel(
    BuildContext context,
    CoordinatorSosState state,
    CoordinatorSosController controller,
  ) {
    final theme = context.theme;
    final textController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Broadcast Portal',
            style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Transmit global push warnings, severe weather notices, or site evac flags to all clinicians.',
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: textController,
            maxLines: 4,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Enter severe broadcast directive details...',
              hintStyle: TextStyle(color: theme.colors.onSurfaceVariant.withValues(alpha: 0.7)),
              filled: true,
              fillColor: theme.colors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.colors.border),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: const Icon(LucideIcons.megaphone, color: Colors.white, size: 16),
              label: const Text('Broadcast Warning', style: TextStyle(color: Colors.white)),
              onPressed: state.isBroadcasting
                  ? null
                  : () {
                      if (textController.text.isNotEmpty) {
                        controller.sendBroadcastAlert(textController.text);
                        textController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Global Emergency Warning Transmitted Successfully.')),
                        );
                      }
                    },
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Operational Quick Contacts',
            style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildContactTile(context, '911 Emergency Line', 'Critical Trauma Dispatch', LucideIcons.phone, Colors.red),
          _buildContactTile(context, 'Clinical Director Hub', 'Senior Clinical Supervisor', LucideIcons.shieldCheck, theme.colors.primary),
          _buildContactTile(context, 'Telehealth Advisory', 'Non-critical Medical Guidance', LucideIcons.activity, Colors.teal),
        ],
      ),
    );
  }

  Widget _buildContactTile(
    BuildContext context,
    String title,
    String desc,
    IconData icon,
    Color iconColor,
  ) {
    final theme = context.theme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withValues(alpha: 0.1),
            radius: 16,
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: theme.typography.bodySmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.phoneOutgoing, size: 14),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text, {Color? color}) {
    final theme = context.theme;
    final displayColor = color ?? theme.colors.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: displayColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.typography.bodySmall.copyWith(color: displayColor),
            ),
          ),
        ],
      ),
    );
  }
}
