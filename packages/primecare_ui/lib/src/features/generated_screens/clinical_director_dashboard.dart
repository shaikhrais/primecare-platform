import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class ClinicalDirectorDashboardState {
  final List<Map<String, dynamic>> vitalAlerts;
  final List<Map<String, dynamic>> nurseComplianceList;
  final String activeAlertFilter;
  final bool isMutatingState;

  const ClinicalDirectorDashboardState({
    required this.vitalAlerts,
    required this.nurseComplianceList,
    required this.activeAlertFilter,
    required this.isMutatingState,
  });

  ClinicalDirectorDashboardState copyWith({
    List<Map<String, dynamic>>? vitalAlerts,
    List<Map<String, dynamic>>? nurseComplianceList,
    String? activeAlertFilter,
    bool? isMutatingState,
  }) {
    return ClinicalDirectorDashboardState(
      vitalAlerts: vitalAlerts ?? this.vitalAlerts,
      nurseComplianceList: nurseComplianceList ?? this.nurseComplianceList,
      activeAlertFilter: activeAlertFilter ?? this.activeAlertFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class ClinicalDirectorDashboardController extends StateNotifier<ClinicalDirectorDashboardState> {
  final Ref _ref;

  ClinicalDirectorDashboardController(this._ref)
      : super(
          const ClinicalDirectorDashboardState(
            vitalAlerts: [
              {
                'id': 'v-201',
                'client': 'Arthur Pendelton',
                'vital': 'Blood Pressure',
                'value': '165/102',
                'severity': 'Critical',
                'date': '2025-05-20 09:30',
                'status': 'Open',
              },
              {
                'id': 'v-202',
                'client': 'Clara Higgins',
                'vital': 'Oxygen Saturation',
                'value': '91%',
                'severity': 'Critical',
                'date': '2025-05-20 08:15',
                'status': 'Open',
              },
              {
                'id': 'v-203',
                'client': 'Robert Vance',
                'vital': 'Heart Rate',
                'value': '112 bpm',
                'severity': 'Warning',
                'date': '2025-05-20 07:45',
                'status': 'Resolved',
              },
            ],
            nurseComplianceList: [
              {
                'id': 'n-301',
                'name': 'Sarah Jenkins (RN)',
                'credential': 'CPR Certification',
                'expiry': '2025-06-01',
                'status': 'Expiring Soon',
              },
              {
                'id': 'n-302',
                'name': 'David Miller (RPN)',
                'credential': 'HIPAA Compliance',
                'expiry': '2025-05-28',
                'status': 'Expiring Soon',
              },
              {
                'id': 'n-303',
                'name': 'Emily Watson (PSW)',
                'credential': 'Vulnerable Sector Check',
                'expiry': '2026-04-12',
                'status': 'Compliant',
              },
            ],
            activeAlertFilter: 'all',
            isMutatingState: false,
          ),
        );

  void updateFilter(String filter) {
    state = state.copyWith(activeAlertFilter: filter);
  }

  void resolveAlert(String alertId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/clinical_director_dashboard',
            eventType: 'vital_alert_resolved',
            metadata: {'alertId': alertId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updatedAlerts = state.vitalAlerts.map((a) {
        if (a['id'] == alertId) {
          return {...a, 'status': 'Resolved'};
        }
        return a;
      }).toList();

      state = state.copyWith(
        vitalAlerts: updatedAlerts,
        isMutatingState: false,
      );
    });
  }

  void triggerComplianceAudit() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/clinical_director_dashboard',
            eventType: 'compliance_audit_triggered',
            metadata: {'auditor': 'Clinical Director'},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      state = state.copyWith(isMutatingState: false);
    });
  }
}

// --- Provider ---
final clinicalDirectorDashboardControllerProvider =
    StateNotifierProvider<ClinicalDirectorDashboardController, ClinicalDirectorDashboardState>((ref) {
  return ClinicalDirectorDashboardController(ref);
});

// --- View ---
class ClinicalDirectorDashboard extends GovernedConsumerWidget {
  const ClinicalDirectorDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicalDirectorDashboardControllerProvider);
    final controller = ref.read(clinicalDirectorDashboardControllerProvider.notifier);
    final theme = context.theme;

    final filteredAlerts = state.vitalAlerts.where((a) {
      if (state.activeAlertFilter == 'all') return true;
      if (state.activeAlertFilter == 'open') return a['status'] == 'Open';
      return a['status'] == 'Resolved';
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.heartPulse, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Clinical Director Dashboard',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.shieldAlert, color: theme.colors.primary),
            onPressed: () => controller.triggerComplianceAudit(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header stats
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: theme.colors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: theme.colors.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Active Vital Warnings', style: theme.typography.bodySmall),
                          const SizedBox(height: 8),
                          Text(
                            '${state.vitalAlerts.where((a) => a['status'] == 'Open').length}',
                            style: theme.typography.h1.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    color: theme.colors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: theme.colors.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Credential Warnings', style: theme.typography.bodySmall),
                          const SizedBox(height: 8),
                          Text(
                            '${state.nurseComplianceList.where((n) => n['status'] == 'Expiring Soon').length}',
                            style: theme.typography.h1.copyWith(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tabs / Filters for Alerts
            Row(
              children: [
                Text(
                  'Patient Care Alerts',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: state.activeAlertFilter,
                  onChanged: (val) {
                    if (val != null) controller.updateFilter(val);
                  },
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Alerts')),
                    DropdownMenuItem(value: 'open', child: Text('Open Alerts')),
                    DropdownMenuItem(value: 'resolved', child: Text('Resolved Alerts')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Alerts list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredAlerts.length,
              itemBuilder: (context, index) {
                final alert = filteredAlerts[index];
                final isOpen = alert['status'] == 'Open';
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: theme.colors.surface,
                  child: ListTile(
                    leading: Icon(
                      isOpen ? LucideIcons.alertTriangle : LucideIcons.checkCircle,
                      color: isOpen ? Colors.red : Colors.green,
                    ),
                    title: Text('${alert['client']} - ${alert['vital']} (${alert['value']})'),
                    subtitle: Text('Recorded: ${alert['date']}'),
                    trailing: isOpen
                        ? ElevatedButton(
                            onPressed: () => controller.resolveAlert((alert['id'] as String)),
                            child: const Text('Resolve'),
                          )
                        : const Icon(LucideIcons.check, color: Colors.green),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy BorderBorder implementation to match theme properties
class BorderBorder extends Border {
  const BorderBorder({super.top, super.right, super.bottom, super.left});
  factory BorderBorder.all({Color color = const Color(0xFF000000), double width = 1.0, BorderStyle style = BorderStyle.solid}) {
    return BorderBorder(
      top: BorderSide(color: color, width: width, style: style),
      right: BorderSide(color: color, width: width, style: style),
      bottom: BorderSide(color: color, width: width, style: style),
      left: BorderSide(color: color, width: width, style: style),
    );
  }
}
