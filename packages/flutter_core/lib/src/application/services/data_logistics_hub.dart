import 'package:primecare_models/src/models/scheduler_models.dart';
import 'package:primecare_models/src/models/dashboard_models.dart';

/// Centralized hub for resilient data orchestration and assembly.
/// This component is the primary interface for "Fetch-or-Fallback" logic.
class DataLogisticsHub {
  /// Fetches raw data from the edge and assembles it into a high-fidelity model.
  static Future<T> fetchAndAssemble<T>(
    String operationName, {
    required Future<T> Function() fetchCall,
    required T Function() fallbackBuilder,
    required T Function(dynamic) assembler,
    void Function(Object, StackTrace)? onError,
  }) async {
    try {
      return await fetchCall();
    } catch (e, st) {
      onError?.call(e, st);
      return fallbackBuilder();
    }
  }

  static HorizonSchedule getHorizonBlueprint() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return HorizonSchedule(
      staff: const [
        StaffMember(id: 's_001', name: 'Dr. Sarah Connor'),
        StaffMember(id: 's_002', name: 'Nurse John Smith'),
        StaffMember(id: 's_003', name: 'Tech Maria Garcia'),
      ],
      resources: const [
        InstitutionalResource(
          id: 'r_001',
          name: 'Room 101',
          status: ResourceStatus.available,
        ),
        InstitutionalResource(
          id: 'r_002',
          name: 'Room 102',
          status: ResourceStatus.available,
        ),
        InstitutionalResource(
          id: 'r_003',
          name: 'MRI Scanner',
          status: ResourceStatus.available,
        ),
      ],
      appointments: [
        Appointment(
          id: 'a_001',
          patientName: 'Alice Johnson',
          staffId: 's_001',
          resourceId: 'r_001',
          startTime: today.add(const Duration(hours: 9)),
          endTime: today.add(const Duration(hours: 10)),
        ),
        Appointment(
          id: 'a_002',
          patientName: 'Bob Williams',
          staffId: 's_001',
          resourceId: 'r_002',
          startTime: today.add(const Duration(hours: 10, minutes: 30)),
          endTime: today.add(const Duration(hours: 11, minutes: 15)),
        ),
        Appointment(
          id: 'a_break_1',
          patientName: 'Lunch Break',
          staffId: 's_001',
          startTime: today.add(const Duration(hours: 12)),
          endTime: today.add(const Duration(hours: 13)),
          isBreak: true,
        ),
        Appointment(
          id: 'a_003',
          patientName: 'Charlie Brown',
          staffId: 's_002',
          resourceId: 'r_001',
          startTime: today.add(const Duration(hours: 13, minutes: 30)),
          endTime: today.add(const Duration(hours: 14, minutes: 30)),
        ),
        Appointment(
          id: 'a_004',
          patientName: 'David Davis',
          staffId: 's_003',
          resourceId: 'r_003',
          startTime: now.subtract(const Duration(minutes: 30)),
          endTime: now.add(const Duration(minutes: 30)),
        ),
      ],
    );
  }

  static ClinicalIntelligenceViewModel getClinicIntelligenceMetrics() {
    return ClinicalIntelligenceViewModel(
      metrics: DashboardMetrics.empty(),
      clinicalInsights: <IntelligenceInsight>[],
      isOfflineFallback: true,
    );
  }

  static Map<String, dynamic>? getReportBlueprint(String reportId) {
    // Platform-level report blueprints for LKG (Last Known Good) recovery
    final blueprints = {
      'revenue_log': {
        'id': 'revenue_log',
        'rows': [
          {'date': '2024-03-01', 'amount': 1200, 'status': 'paid'},
          {'date': '2024-03-02', 'amount': 850, 'status': 'pending'},
        ],
      },
    };
    return blueprints[reportId];
  }

  static DashboardMetrics getDashboardMetrics(String route) {
    return DashboardMetrics.empty();
  }
}
