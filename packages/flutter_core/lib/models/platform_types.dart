// Layer: 01_INFRASTRUCTURE
import '../src/models/blueprint_models.dart';
import '../src/models/scheduler_models.dart';
import '../src/models/dashboard_models.dart';

/// Primary subsystems across the PrimeCare Platform.
enum PlatformSubsystem {
  clinical,
  corporate,
  system,
  finance,
  governance,
  operations,
  metrics,
  office,
  infrastructure,
  portal,
  franchise,
}

/// Defines the type of shell layout to use for the application.
enum AppShellType {
  admin,
  clinical,
  patient,
  system,
  provider,
}


/// Standardized labels for UI components and classification.
enum PrimeCareLabel {
  dashboard,
  metrics,
  timeline,
  insights,
  analytics,
  registry,
  controls,
  form,
  report,
}

/// Standardized form definitions for the platform.
enum PrimeCareForm {
  patientIntake,
  staffOnboarding,
  billingSubmission,
  incidentReport,
  carePlan,
  schedulerEntry,
  ceoDashboard,
  pswDashboard,
}


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
    return const HorizonSchedule(
      appointments: <Appointment>[],
      resources: <InstitutionalResource>[],
      staff: <StaffMember>[],
    );
  }

  static ClinicalIntelligenceViewModel getClinicIntelligenceMetrics() {
    return ClinicalIntelligenceViewModel(
      metrics: DashboardMetrics.empty(),
      clinicalInsights: <IntelligenceInsight>[],
      isOfflineFallback: true,
      blueprints: [
        const StatGridBlueprint(
          id: 'clinical_stats',
          title: 'Clinical Statistics',
          metrics: ['patients_seen', 'active_orders'],
        ),
      ],
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
      }
    };
    return blueprints[reportId];
  }

  static DashboardMetrics getDashboardMetrics(String route) {
    return DashboardMetrics.empty();
  }
}

extension PrimeCareLabelExtension on PrimeCareLabel {
  String get(String langCode) {
    final translations = {
      'en': {
        PrimeCareLabel.dashboard: 'Dashboard',
        PrimeCareLabel.metrics: 'Metrics',
        PrimeCareLabel.timeline: 'Timeline',
        PrimeCareLabel.insights: 'Insights',
        PrimeCareLabel.analytics: 'Analytics',
        PrimeCareLabel.registry: 'Registry',
        PrimeCareLabel.controls: 'Controls',
        PrimeCareLabel.form: 'Form',
        PrimeCareLabel.report: 'Report',
      },
    };
    return translations[langCode]?[this] ?? name;
  }
}
