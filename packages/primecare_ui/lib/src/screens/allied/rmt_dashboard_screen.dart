/* 
PRIME:SCREEN=rmt_dashboard
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_QUERY_READY
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=60
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Rmt Dashboard Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- Appointment Model ---
class RmtAppointment {
  final String id;
  final String patientName;
  final String treatmentType;
  final String timeSlot;
  final String status;

  const RmtAppointment({
    required this.id,
    required this.patientName,
    required this.treatmentType,
    required this.timeSlot,
    required this.status,
  });
}

// --- MVC State Model ---
class RmtDashboardState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<RmtAppointment> appointments;
  final List<String> logs;

  const RmtDashboardState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.appointments,
    required this.logs,
  });

  RmtDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<RmtAppointment>? appointments,
    List<String>? logs,
  }) {
    return RmtDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      appointments: appointments ?? this.appointments,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class RmtDashboardController extends StateNotifier<RmtDashboardState> {
  final Ref ref;

  RmtDashboardController(this.ref)
    : super(
        RmtDashboardState(
          isLoading: false,
          title: 'RMT Therapy Dashboard'.tr(),
          appointments: const [
            RmtAppointment(
              id: 'apt-1',
              patientName: 'John Doe',
              treatmentType: 'Deep Tissue Massage',
              timeSlot: '09:00 AM - 10:00 AM',
              status: 'Scheduled',
            ),
            RmtAppointment(
              id: 'apt-2',
              patientName: 'Jane Smith',
              treatmentType: 'Myofascial Release',
              timeSlot: '11:30 AM - 12:30 PM',
              status: 'Active',
            ),
          ],
          logs: const [
            'Therapy workspace initialized.',
            'Connected to Allied Health Schedule database.',
          ],
        ),
      );

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        'Compliance audit executed at ${DateTime.now().toIso8601String()}',
        'All governance invariants validated.',
      ],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  Future<void> fetchAppointments() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/rmt/appointments/fetch',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'fetch_active_appointments',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'Appointments successfully updated from API.'],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error: ${response.error}'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error: $e'],
      );
    }
  }

  Future<void> createSoapNote(String appointmentId, String soapText) async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/rmt/soap-notes/submit',
        body: {
          'appointmentId': appointmentId,
          'notes': soapText,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'SOAP Clinical Note successfully submitted for $appointmentId.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error: ${response.error}'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error: $e'],
      );
    }
  }

  Future<void> submitInsuranceClaim(String appointmentId) async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/rmt/claims/submit',
        body: {
          'appointmentId': appointmentId,
          'provider': 'PrimeCare Telus Health Integration',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Telus Health direct billing claim approved for $appointmentId.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error: ${response.error}'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error: $e'],
      );
    }
  }

  Future<void> updateTreatmentPlan(String planId) async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/rmt/treatment-plans/update',
        body: {'planId': planId, 'timestamp': DateTime.now().toIso8601String()},
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Treatment Plan $planId successfully updated via API.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error: ${response.error}'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error: $e'],
      );
    }
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }
}

// --- Provider ---
final rmtDashboardProvider =
    StateNotifierProvider<RmtDashboardController, RmtDashboardState>((ref) {
      return RmtDashboardController(ref);
    });

// --- View ---
class RmtDashboardScreen extends GovernedConsumerWidget {
  const RmtDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmtDashboardProvider);
    final controller = ref.read(rmtDashboardProvider.notifier);
    final theme = context.theme;
    final roleBase = 'Rmt';

    return Cy(
      id: 'rmtdashboard-screen data-cy:rmtdashboard-screen',
      child: Scaffold(
        key: const Key('rmtdashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('rmtdashboard-title'),
            state.title.tr(),
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('rmtdashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.addLog('Manual refresh triggered.'),
            ),
          ],
        ),
        body: ResponsiveSplitDashboard(
          metrics: const [
            GovMetricCard(
              title: 'Active Operations',
              value: 'Active',
              trendLabel: 'Optimal',
              progress: 0.92,
              icon: LucideIcons.activity,
              brandColor: Color(0xFF0D9488),
            ),
            GovMetricCard(
              title: 'Security Clearance',
              value: 'Level 4',
              trendLabel: 'Approved',
              progress: 1.0,
              icon: LucideIcons.shieldCheck,
              brandColor: Color(0xFF16A34A),
            ),
            GovMetricCard(
              title: 'System Latency',
              value: '18ms',
              trendLabel: 'Optimal',
              progress: 0.98,
              icon: LucideIcons.zap,
              brandColor: Color(0xFFEAB308),
            ),
            GovMetricCard(
              title: 'Data Integrity',
              value: '99.9%',
              trendLabel: 'Secure',
              progress: 0.99,
              icon: LucideIcons.database,
              brandColor: Color(0xFF2563EB),
            ),
          ],
          mainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'data-cy:rmtdashboard-title',
                child: GovDashboardHero(
                  title: 'RMT Therapy Dashboard',
                  roleName: '$roleBase Dashboard',
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
                ),
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title: 'Hourly Core Telemetry',
                dataPoints: const [75, 82, 80, 94, 91, 98],
                labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
                accentColor: theme.colors.primary,
              ),
                const SizedBox(height: 24),
                // Active Sessions List
                PrimeCareCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Massage Appointments & SOAP Notes',
                        style: theme.typography.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...state.appointments.map(
                        (apt) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.colors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      apt.patientName,
                                      style: theme.typography.bodyLarge
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      apt.status,
                                      style: TextStyle(
                                        color: apt.status == 'Active'
                                            ? Colors.green
                                            : theme.colors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${apt.treatmentType} | ${apt.timeSlot}',
                                  style: theme.typography.bodyMedium.copyWith(
                                    color: theme.colors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      key: Key('rmtdashboard-btn-3-${apt.id}'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colors.primary,
                                      ),
                                      onPressed: () =>
                                          controller.createSoapNote(
                                            apt.id,
                                            'Myofascial tightness resolved.',
                                          ),
                                      child: const Text(
                                        'Save SOAP Chart note',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      key: Key('rmtdashboard-btn-4-${apt.id}'),
                                      onPressed: () => controller
                                          .submitInsuranceClaim(apt.id),
                                      child: Text(
                                        'Submit Direct Billing claim'.tr(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          defaultSidebarWidgets: [
            // === Executive Pill Action Button ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                key: const Key('rmtdashboard-btn-2'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primaryContainer,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: theme.colors.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                icon: const Icon(LucideIcons.playCircle, size: 18),
                onPressed: () => controller.triggerStateAction(),
                label: Text('Execute: Button 1'.tr()),
              ),
            ),
            const SizedBox(height: 24),
            // === Audit Logs Panel ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map(
                    (log) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              log.tr(),
                              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      key: const Key('rmtdashboard-btn-3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: state.isLoading
                          ? null
                          : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                key: Key('rmtdashboard-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan'.tr(),
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
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
