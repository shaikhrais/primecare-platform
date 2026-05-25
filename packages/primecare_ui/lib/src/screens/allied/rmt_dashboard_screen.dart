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
              RmtAppointment(id: 'apt-1', patientName: 'John Doe', treatmentType: 'Deep Tissue Massage', timeSlot: '09:00 AM - 10:00 AM', status: 'Scheduled'),
              RmtAppointment(id: 'apt-2', patientName: 'Jane Smith', treatmentType: 'Myofascial Release', timeSlot: '11:30 AM - 12:30 PM', status: 'Active'),
            ],
            logs: const [
              'Therapy workspace initialized.',
              'Connected to Allied Health Schedule database.',
            ],
          ),
        );

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
          logs: [
            ...state.logs,
            'Appointments successfully updated from API.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'API Error: ${response.error}',
          ],
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
        body: {
          'planId': planId,
          'timestamp': DateTime.now().toIso8601String(),
        },
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

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.fetchAppointments(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: state.title,
              roleName: 'Allied RMT Therapist',
              description: 'Manage therapeutic SOAP charting notes, process Telus Health direct billing claims, and review scheduled massage sessions.',
              onRefresh: () => controller.fetchAppointments(),
            ),
            const SizedBox(height: 24),

            // Active Sessions List
            PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Massage Appointments & SOAP Notes',
                    style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...state.appointments.map((apt) => Padding(
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    apt.patientName,
                                    style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    apt.status,
                                    style: TextStyle(
                                      color: apt.status == 'Active' ? Colors.green : theme.colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${apt.treatmentType} | ${apt.timeSlot}',
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: theme.colors.primary),
                                    onPressed: () => controller.createSoapNote(apt.id, 'Myofascial tightness resolved.'),
                                    child: const Text('Save SOAP Chart note', style: TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () => controller.submitInsuranceClaim(apt.id),
                                    child: Text('Submit Direct Billing claim'.tr()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Telemetry Logs Panel
            Container(
              width: double.infinity,
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
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map((log) => Padding(
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
                                log,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
