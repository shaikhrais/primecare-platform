// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/shared/primecare_adapters.dart';

// --- Start of administrative_forms\administrative_forms_model.dart ---

class AdministrativeFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;
  final bool isSubmitting;

  const AdministrativeFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
    this.isSubmitting = false,
  });

  factory AdministrativeFormsViewModel.initial() {
    return const AdministrativeFormsViewModel(
      availableForms: [
        'Expense Reimbursement',
        'Leave Request Approval',
        'Payroll Run Approval',
      ],
      selectedForm: 'Expense Reimbursement',
    );
  }

  AdministrativeFormsViewModel copyWith({
    List<String>? availableForms,
    String? selectedForm,
    bool? isSubmitting,
  }) {
    return AdministrativeFormsViewModel(
      availableForms: availableForms ?? this.availableForms,
      selectedForm: selectedForm ?? this.selectedForm,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

// --- End of administrative_forms\administrative_forms_model.dart ---

// --- Start of architectural_planning\architectural_planning_model.dart ---

class ArchitecturalPlanningModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const ArchitecturalPlanningModel({
    required this.metrics,
    this.insights = const [],
  });

  factory ArchitecturalPlanningModel.empty() {
    return ArchitecturalPlanningModel(metrics: DashboardMetrics.empty());
  }
}

// --- End of architectural_planning\architectural_planning_model.dart ---

// --- Start of billing_admin_dashboard\billing_admin_dashboard_model.dart ---

class BillingAdminDashboardViewModel extends PrimeCareDashboardViewModel {
  const BillingAdminDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory BillingAdminDashboardViewModel.empty() {
    return BillingAdminDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of billing_admin_dashboard\billing_admin_dashboard_model.dart ---

// --- Start of ceo_dashboard\ceo_dashboard_model.dart ---

class CeoDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const CeoDashboardModel({required this.metrics, this.insights = const []});

  factory CeoDashboardModel.empty() {
    return CeoDashboardModel(metrics: DashboardMetrics.empty());
  }
}

// --- End of ceo_dashboard\ceo_dashboard_model.dart ---

// --- Start of cfo_dashboard\cfo_dashboard_model.dart ---

class CFODashboardModel {
  final List<KpiData> kpis;
  final List<FinancialData> revenueTrend;

  CFODashboardModel({required this.kpis, this.revenueTrend = const []});
}

class KpiData {
  final String title;
  final String value;
  final String? subtitle;

  KpiData({required this.title, required this.value, this.subtitle});
}

class FinancialData {
  final DateTime date;
  final double value;

  FinancialData(this.date, this.value);
}

// --- End of cfo_dashboard\cfo_dashboard_model.dart ---

// --- Start of chiropractor\chiropractor_model.dart ---

class ChiropractorViewModel {
  final String title;
  final List<String> appointments;

  const ChiropractorViewModel({
    required this.title,
    required this.appointments,
  });

  factory ChiropractorViewModel.initial() {
    return const ChiropractorViewModel(
      title: 'Chiropractic Care Portal',
      appointments: [
        '9:00 AM - Spinal Adjustment',
        '11:30 AM - Initial Assessment',
      ],
    );
  }
}

// --- End of chiropractor\chiropractor_model.dart ---

// --- Start of client\client_model.dart ---

class ClientViewModel extends PrimeCareDashboardViewModel {
  const ClientViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ClientViewModel.empty() {
    return ClientViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of client\client_model.dart ---

// --- Start of client_dashboard\client_dashboard_model.dart ---

class ClientDashboardViewModel extends PrimeCareDashboardViewModel {
  const ClientDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory ClientDashboardViewModel.empty() {
    return ClientDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of client_dashboard\client_dashboard_model.dart ---

// --- Start of clinical_director\clinical_director_model.dart ---

class ClinicalDirectorViewModel extends PrimeCareDashboardViewModel {
  const ClinicalDirectorViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ClinicalDirectorViewModel.empty() {
    return ClinicalDirectorViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of clinical_director\clinical_director_model.dart ---

// --- Start of clinical_director_dashboard\clinical_director_dashboard_model.dart ---

class ClinicalDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const ClinicalDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ClinicalDirectorDashboardViewModel.empty() {
    return ClinicalDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of clinical_director_dashboard\clinical_director_dashboard_model.dart ---

// --- Start of clinical_forms\clinical_forms_model.dart ---

class ClinicalFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;
  final bool isSubmitting;

  const ClinicalFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
    this.isSubmitting = false,
  });

  factory ClinicalFormsViewModel.initial() {
    return const ClinicalFormsViewModel(
      availableForms: [
        'Medication Refill',
        'Daily Vitals',
        'Clinical Incident',
        'Infection Control',
        'Care Plan Review',
        'Clinical Audit',
        'ADL Checklist',
        'Daily Census',
      ],
      selectedForm: 'Medication Refill',
    );
  }

  ClinicalFormsViewModel copyWith({
    List<String>? availableForms,
    String? selectedForm,
    bool? isSubmitting,
  }) {
    return ClinicalFormsViewModel(
      availableForms: availableForms ?? this.availableForms,
      selectedForm: selectedForm ?? this.selectedForm,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

// --- End of clinical_forms\clinical_forms_model.dart ---

// --- Start of clinic_dashboard\clinic_dashboard_model.dart ---

class ClinicDashboardModel {
  final DashboardMetrics metrics;
  final List<DashboardActivity> recentActivity;

  const ClinicDashboardModel({
    required this.metrics,
    this.recentActivity = const [],
  });

  factory ClinicDashboardModel.empty() {
    return ClinicDashboardModel(metrics: DashboardMetrics.empty());
  }
}

// --- End of clinic_dashboard\clinic_dashboard_model.dart ---

// --- Start of common\domain\common_feature_view_model.dart ---

// Layer: 02_MODELS_FOUNDATION

class CommonFeatureViewModel {
  final bool isOfflineFallback;
  final List<UniversalKpi> kpis;
  final List<dynamic> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const CommonFeatureViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  factory CommonFeatureViewModel.fromDomain(Map<String, dynamic> data) {
    final kpis =
        (data['kpis'] as List<dynamic>?)
            ?.map((k) => UniversalKpi.fromJson(k as Map<String, dynamic>))
            .toList() ??
        [];

    return CommonFeatureViewModel(
      isOfflineFallback: false,
      kpis: kpis,
      recentActivity: data['recentActivity'] as List<dynamic>? ?? [],
      blueprints: [
        StatGridBlueprint(dataPayload: kpis),
        ActivityFeedBlueprint(
          dataPayload: data['recentActivity'] as List<dynamic>? ?? [],
        ),
      ],
    );
  }

  factory CommonFeatureViewModel.assemble({required bool isOffline}) {
    return CommonFeatureViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: <dynamic>[]),
        const ActivityFeedBlueprint(dataPayload: <dynamic>[]),
      ],
    );
  }
}

// --- End of common\domain\common_feature_view_model.dart ---

// --- Start of common\domain\common_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class CommonViewModel {
  final String title;
  final String status;

  const CommonViewModel({required this.title, required this.status});
}

// --- End of common\domain\common_view_model.dart ---

// --- Start of common\domain\primecare_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class PrimeCareFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  PrimeCareFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  PrimeCareFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return PrimeCareFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of common\domain\primecare_form_view_model.dart ---

// --- Start of common_forms\common_forms_model.dart ---

class CommonFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;

  const CommonFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
  });

  factory CommonFormsViewModel.initial() {
    return const CommonFormsViewModel(
      availableForms: [
        'Real Estate',
        'System Access',
        'Care Pod',
        'Training',
        'Compliance',
        'Supply Order',
        'Shift Adjustment',
        'Fleet Maintenance',
      ],
      selectedForm: 'Real Estate',
    );
  }
}

// --- End of common_forms\common_forms_model.dart ---

// --- Start of common_forms\domain\approve_real_estate_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ApproveRealEstateFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ApproveRealEstateFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\approve_real_estate_form_view_model.dart ---

// --- Start of common_forms\domain\approve_system_access_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ApproveSystemAccessFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ApproveSystemAccessFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\approve_system_access_form_view_model.dart ---

// --- Start of common_forms\domain\assign_care_pod_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AssignCarePodFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AssignCarePodFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\assign_care_pod_form_view_model.dart ---

// --- Start of common_forms\domain\assign_training_module_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AssignTrainingModuleFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AssignTrainingModuleFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\assign_training_module_form_view_model.dart ---

// --- Start of common_forms\domain\audit_compliance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuditComplianceFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuditComplianceFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\audit_compliance_form_view_model.dart ---

// --- Start of common_forms\domain\audit_global_education_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuditGlobalEducationFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuditGlobalEducationFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\audit_global_education_form_view_model.dart ---

// --- Start of common_forms\domain\audit_override_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuditOverrideFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuditOverrideFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\audit_override_form_view_model.dart ---

// --- Start of common_forms\domain\audit_royalty_payment_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuditRoyaltyPaymentFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuditRoyaltyPaymentFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\audit_royalty_payment_form_view_model.dart ---

// --- Start of common_forms\domain\audit_security_compliance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuditSecurityComplianceFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuditSecurityComplianceFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\audit_security_compliance_form_view_model.dart ---

// --- Start of common_forms\domain\audit_system_logs_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuditSystemLogsFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuditSystemLogsFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\audit_system_logs_form_view_model.dart ---

// --- Start of common_forms\domain\base_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class BaseFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  BaseFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\base_form_view_model.dart ---

// --- Start of common_forms\domain\care_plan_evaluation_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class CarePlanEvaluationFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  CarePlanEvaluationFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\care_plan_evaluation_form_view_model.dart ---

// --- Start of common_forms\domain\create_canned_response_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class CreateCannedResponseFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  CreateCannedResponseFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\create_canned_response_form_view_model.dart ---

// --- Start of common_forms\domain\create_supply_order_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class CreateSupplyOrderFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  CreateSupplyOrderFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\create_supply_order_form_view_model.dart ---

// --- Start of common_forms\domain\discipline_log_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DisciplineLogFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DisciplineLogFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\discipline_log_form_view_model.dart ---

// --- Start of common_forms\domain\firebase_sign_in_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FirebaseSignInFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FirebaseSignInFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\firebase_sign_in_form_view_model.dart ---

// --- Start of common_forms\domain\firebase_sign_up_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FirebaseSignUpFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FirebaseSignUpFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\firebase_sign_up_form_view_model.dart ---

// --- Start of common_forms\domain\franchise_onboarding_checklist_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FranchiseOnboardingChecklistFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FranchiseOnboardingChecklistFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\franchise_onboarding_checklist_form_view_model.dart ---

// --- Start of common_forms\domain\index_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class IndexFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  IndexFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\index_form_view_model.dart ---

// --- Start of common_forms\domain\jwt_sign_in_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class JwtSignInFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  JwtSignInFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\jwt_sign_in_form_view_model.dart ---

// --- Start of common_forms\domain\jwt_sign_up_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class JwtSignUpFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  JwtSignUpFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\jwt_sign_up_form_view_model.dart ---

// --- Start of common_forms\domain\leave_request_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LeaveRequestFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LeaveRequestFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\leave_request_form_view_model.dart ---

// --- Start of common_forms\domain\log_inventory_spoilage_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LogInventorySpoilageFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LogInventorySpoilageFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\log_inventory_spoilage_form_view_model.dart ---

// --- Start of common_forms\domain\number_form_controller_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NumberFormControllerViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NumberFormControllerViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\number_form_controller_view_model.dart ---

// --- Start of common_forms\domain\override_global_schedule_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class OverrideGlobalScheduleFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  OverrideGlobalScheduleFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\override_global_schedule_form_view_model.dart ---

// --- Start of common_forms\domain\patient_intake_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PatientIntakeFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PatientIntakeFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\patient_intake_form_view_model.dart ---

// --- Start of common_forms\domain\radio_form_controller_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RadioFormControllerViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RadioFormControllerViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\radio_form_controller_view_model.dart ---

// --- Start of common_forms\domain\register_corporate_risk_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RegisterCorporateRiskFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RegisterCorporateRiskFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\register_corporate_risk_form_view_model.dart ---

// --- Start of common_forms\domain\request_shift_adjustment_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RequestShiftAdjustmentFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RequestShiftAdjustmentFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\request_shift_adjustment_form_view_model.dart ---

// --- Start of common_forms\domain\review_fleet_maintenance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ReviewFleetMaintenanceFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ReviewFleetMaintenanceFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\review_fleet_maintenance_form_view_model.dart ---

// --- Start of common_forms\domain\review_legal_contract_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ReviewLegalContractFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ReviewLegalContractFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\review_legal_contract_form_view_model.dart ---

// --- Start of common_forms\domain\review_onboarding_status_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ReviewOnboardingStatusFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ReviewOnboardingStatusFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\review_onboarding_status_form_view_model.dart ---

// --- Start of common_forms\domain\review_peer_performance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ReviewPeerPerformanceFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ReviewPeerPerformanceFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\review_peer_performance_form_view_model.dart ---

// --- Start of common_forms\domain\review_vendor_contracts_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ReviewVendorContractsFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ReviewVendorContractsFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\review_vendor_contracts_form_view_model.dart ---

// --- Start of common_forms\domain\role_permissions_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RolePermissionsFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RolePermissionsFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\role_permissions_form_view_model.dart ---

// --- Start of common_forms\domain\schedule_facility_maintenance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ScheduleFacilityMaintenanceFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ScheduleFacilityMaintenanceFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\schedule_facility_maintenance_form_view_model.dart ---

// --- Start of common_forms\domain\schedule_open_house_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ScheduleOpenHouseFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ScheduleOpenHouseFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\schedule_open_house_form_view_model.dart ---

// --- Start of common_forms\domain\sign_in_page_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignInPageFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignInPageFormViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\sign_in_page_form_view_model.dart ---

// --- Start of common_forms\domain\single_input_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class SingleInputFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  SingleInputFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  SingleInputFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return SingleInputFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of common_forms\domain\single_input_form_view_model.dart ---

// --- Start of common_forms\domain\submit_healthcare_claim_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SubmitHealthcareClaimFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SubmitHealthcareClaimFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\submit_healthcare_claim_form_view_model.dart ---

// --- Start of common_forms\domain\switch_form_controller_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SwitchFormControllerViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SwitchFormControllerViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_forms\domain\switch_form_controller_view_model.dart ---

// --- Start of common_ui\domain\adjust_font_size_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AdjustFontSizeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AdjustFontSizeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\adjust_font_size_view_model.dart ---

// --- Start of common_ui\domain\app_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AppViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AppViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\app_view_model.dart ---

// --- Start of common_ui\domain\authentication_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuthenticationViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuthenticationViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\authentication_view_model.dart ---

// --- Start of common_ui\domain\auth_pages_message_section_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuthPagesMessageSectionViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuthPagesMessageSectionViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\auth_pages_message_section_view_model.dart ---

// --- Start of common_ui\domain\aws_sign_in_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AwsSignInTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AwsSignInTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\aws_sign_in_tab_view_model.dart ---

// --- Start of common_ui\domain\aws_sign_up_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AwsSignUpTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AwsSignUpTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\aws_sign_up_tab_view_model.dart ---

// --- Start of common_ui\domain\a_w_s_authenticator_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AWSAuthenticatorViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AWSAuthenticatorViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\a_w_s_authenticator_view_model.dart ---

// --- Start of common_ui\domain\a_w_s_auth_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AWSAuthContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AWSAuthContextViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\a_w_s_auth_context_view_model.dart ---

// --- Start of common_ui\domain\button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\button_view_model.dart ---

// --- Start of common_ui\domain\configurator_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ConfiguratorViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ConfiguratorViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\configurator_view_model.dart ---

// --- Start of common_ui\domain\data_table_top_toolbar_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DataTableTopToolbarViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DataTableTopToolbarViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\data_table_top_toolbar_view_model.dart ---

// --- Start of common_ui\domain\data_table_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DataTableViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DataTableViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\data_table_view_model.dart ---

// --- Start of common_ui\domain\demo_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DemoContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DemoContentViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\demo_content_view_model.dart ---

// --- Start of common_ui\domain\demo_frame_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DemoFrameViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DemoFrameViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\demo_frame_view_model.dart ---

// --- Start of common_ui\domain\demo_sidebar_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DemoSidebarContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DemoSidebarContentViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\demo_sidebar_content_view_model.dart ---

// --- Start of common_ui\domain\documentation_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DocumentationButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DocumentationButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\documentation_button_view_model.dart ---

// --- Start of common_ui\domain\drag_assign_widget_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DragAssignWidgetViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DragAssignWidgetViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\drag_assign_widget_view_model.dart ---

// --- Start of common_ui\domain\dropdown_menu_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DropdownMenuViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DropdownMenuViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\dropdown_menu_view_model.dart ---

// --- Start of common_ui\domain\error401_page_view_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Error401PageViewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Error401PageViewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\error401_page_view_view_model.dart ---

// --- Start of common_ui\domain\error404_page_view_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Error404PageViewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Error404PageViewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\error404_page_view_view_model.dart ---

// --- Start of common_ui\domain\error_boundary_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ErrorBoundaryViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ErrorBoundaryViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\error_boundary_view_model.dart ---

// --- Start of common_ui\domain\eta_tracker_widget_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class EtaTrackerWidgetViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  EtaTrackerWidgetViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\eta_tracker_widget_view_model.dart ---

// --- Start of common_ui\domain\example_view_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ExampleViewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ExampleViewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\example_view_view_model.dart ---

// --- Start of common_ui\domain\firebase_auth_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FirebaseAuthContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FirebaseAuthContextViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\firebase_auth_context_view_model.dart ---

// --- Start of common_ui\domain\firebase_sign_in_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FirebaseSignInTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FirebaseSignInTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\firebase_sign_in_tab_view_model.dart ---

// --- Start of common_ui\domain\firebase_sign_up_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FirebaseSignUpTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FirebaseSignUpTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\firebase_sign_up_tab_view_model.dart ---

// --- Start of common_ui\domain\footer_theme_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FooterThemeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FooterThemeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\footer_theme_view_model.dart ---

// --- Start of common_ui\domain\framed_demo_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FramedDemoViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FramedDemoViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\framed_demo_view_model.dart ---

// --- Start of common_ui\domain\full_screen_toggle_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FullScreenToggleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FullScreenToggleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\full_screen_toggle_view_model.dart ---

// --- Start of common_ui\domain\fuse_authorization_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseAuthorizationViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseAuthorizationViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_authorization_view_model.dart ---

// --- Start of common_ui\domain\fuse_auth_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseAuthContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseAuthContextViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_auth_context_view_model.dart ---

// --- Start of common_ui\domain\fuse_await_render_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseAwaitRenderViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseAwaitRenderViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_await_render_view_model.dart ---

// --- Start of common_ui\domain\fuse_countdown_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseCountdownViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseCountdownViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_countdown_view_model.dart ---

// --- Start of common_ui\domain\fuse_dialog_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseDialogViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseDialogViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_dialog_view_model.dart ---

// --- Start of common_ui\domain\fuse_example_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseExampleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseExampleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_example_view_model.dart ---

// --- Start of common_ui\domain\fuse_highlight_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseHighlightViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseHighlightViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_highlight_view_model.dart ---

// --- Start of common_ui\domain\fuse_loading_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseLoadingViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseLoadingViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_loading_view_model.dart ---

// --- Start of common_ui\domain\fuse_navigation_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavigationViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavigationViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_navigation_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_badge_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavBadgeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavBadgeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_badge_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_horizontal_collapse_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavHorizontalCollapseViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavHorizontalCollapseViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_horizontal_collapse_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_horizontal_group_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavHorizontalGroupViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavHorizontalGroupViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_horizontal_group_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_horizontal_item_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavHorizontalItemViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavHorizontalItemViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_horizontal_item_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_horizontal_link_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavHorizontalLinkViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavHorizontalLinkViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_horizontal_link_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_item_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavItemViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavItemViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_item_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_vertical_collapse_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalCollapseViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalCollapseViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_vertical_collapse_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_vertical_group_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalGroupViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalGroupViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_vertical_group_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_vertical_item_base_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalItemBaseViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalItemBaseViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_vertical_item_base_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_vertical_item_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalItemViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalItemViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_vertical_item_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_vertical_link_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalLinkViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalLinkViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_vertical_link_view_model.dart ---

// --- Start of common_ui\domain\fuse_nav_vertical_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_nav_vertical_tab_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_carded_header_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageCardedHeaderViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageCardedHeaderViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_carded_header_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_carded_sidebar_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageCardedSidebarContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageCardedSidebarContentViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_carded_sidebar_content_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_carded_sidebar_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageCardedSidebarViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageCardedSidebarViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_carded_sidebar_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_carded_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageCardedViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageCardedViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_carded_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_simple_header_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageSimpleHeaderViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageSimpleHeaderViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_simple_header_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_simple_sidebar_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageSimpleSidebarContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageSimpleSidebarContentViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_simple_sidebar_content_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_simple_sidebar_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageSimpleSidebarViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageSimpleSidebarViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_simple_sidebar_view_model.dart ---

// --- Start of common_ui\domain\fuse_page_simple_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FusePageSimpleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FusePageSimpleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_page_simple_view_model.dart ---

// --- Start of common_ui\domain\fuse_scrollbars_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseScrollbarsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseScrollbarsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_scrollbars_view_model.dart ---

// --- Start of common_ui\domain\fuse_search_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSearchViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSearchViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_search_view_model.dart ---

// --- Start of common_ui\domain\fuse_settings_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSettingsContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSettingsContextViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_settings_context_view_model.dart ---

// --- Start of common_ui\domain\fuse_settings_viewer_dialog_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSettingsViewerDialogViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSettingsViewerDialogViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_settings_viewer_dialog_view_model.dart ---

// --- Start of common_ui\domain\fuse_settings_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSettingsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSettingsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_settings_view_model.dart ---

// --- Start of common_ui\domain\fuse_shortcuts_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseShortcutsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseShortcutsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_shortcuts_view_model.dart ---

// --- Start of common_ui\domain\fuse_side_panel_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSidePanelViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSidePanelViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_side_panel_view_model.dart ---

// --- Start of common_ui\domain\fuse_suspense_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSuspenseViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSuspenseViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_suspense_view_model.dart ---

// --- Start of common_ui\domain\fuse_theme_hooks_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseThemeHooksViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseThemeHooksViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_theme_hooks_view_model.dart ---

// --- Start of common_ui\domain\fuse_theme_selector_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseThemeSelectorViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseThemeSelectorViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_theme_selector_view_model.dart ---

// --- Start of common_ui\domain\fuse_theme_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseThemeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseThemeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\fuse_theme_view_model.dart ---

// --- Start of common_ui\domain\go_to_doc_box_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class GoToDocBoxViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  GoToDocBoxViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\go_to_doc_box_view_model.dart ---

// --- Start of common_ui\domain\greeting_header_widget_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class GreetingHeaderWidgetViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  GreetingHeaderWidgetViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\greeting_header_widget_view_model.dart ---

// --- Start of common_ui\domain\heading_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\heading_button_view_model.dart ---

// --- Start of common_ui\domain\heading_dropdown_menu_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingDropdownMenuViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingDropdownMenuViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\heading_dropdown_menu_view_model.dart ---

// --- Start of common_ui\domain\highlight_popover_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HighlightPopoverViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HighlightPopoverViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\highlight_popover_view_model.dart ---

// --- Start of common_ui\domain\image_upload_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ImageUploadButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ImageUploadButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\image_upload_button_view_model.dart ---

// --- Start of common_ui\domain\image_upload_node_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ImageUploadNodeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ImageUploadNodeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\image_upload_node_view_model.dart ---

// --- Start of common_ui\domain\initialize_firebase_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class InitializeFirebaseViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  InitializeFirebaseViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\initialize_firebase_view_model.dart ---

// --- Start of common_ui\domain\jwt_auth_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class JwtAuthContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  JwtAuthContextViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\jwt_auth_context_view_model.dart ---

// --- Start of common_ui\domain\jwt_sign_in_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class JwtSignInTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  JwtSignInTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\jwt_sign_in_tab_view_model.dart ---

// --- Start of common_ui\domain\jw_sign_up_tab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class JwSignUpTabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  JwSignUpTabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\jw_sign_up_tab_view_model.dart ---

// --- Start of common_ui\domain\language_switcher_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LanguageSwitcherViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LanguageSwitcherViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\language_switcher_view_model.dart ---

// --- Start of common_ui\domain\layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Layout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Layout1ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\layout1_view_model.dart ---

// --- Start of common_ui\domain\layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Layout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Layout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\layout2_view_model.dart ---

// --- Start of common_ui\domain\layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Layout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Layout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\layout3_view_model.dart ---

// --- Start of common_ui\domain\light_dark_mode_toggle_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LightDarkModeToggleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LightDarkModeToggleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\light_dark_mode_toggle_view_model.dart ---

// --- Start of common_ui\domain\link_popover_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LinkPopoverViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LinkPopoverViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\link_popover_view_model.dart ---

// --- Start of common_ui\domain\link_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LinkViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LinkViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\link_view_model.dart ---

// --- Start of common_ui\domain\list_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ListButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ListButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\list_button_view_model.dart ---

// --- Start of common_ui\domain\list_dropdown_menu_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ListDropdownMenuViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ListDropdownMenuViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\list_dropdown_menu_view_model.dart ---

// --- Start of common_ui\domain\logo_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LogoViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LogoViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\logo_view_model.dart ---

// --- Start of common_ui\domain\main_project_selection_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MainProjectSelectionViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MainProjectSelectionViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\main_project_selection_view_model.dart ---

// --- Start of common_ui\domain\mark_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MarkButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MarkButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\mark_button_view_model.dart ---

// --- Start of common_ui\domain\master_app_shell_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MasterAppShellViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MasterAppShellViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\master_app_shell_view_model.dart ---

// --- Start of common_ui\domain\mock_api_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MockApiViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MockApiViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\mock_api_view_model.dart ---

// --- Start of common_ui\domain\mood_slider_widget_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MoodSliderWidgetViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MoodSliderWidgetViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\mood_slider_widget_view_model.dart ---

// --- Start of common_ui\domain\navbar_pin_toggle_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarPinToggleButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarPinToggleButtonViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_pin_toggle_button_view_model.dart ---

// --- Start of common_ui\domain\navbar_style1_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarStyle1ContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarStyle1ContentViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_style1_content_view_model.dart ---

// --- Start of common_ui\domain\navbar_style1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarStyle1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarStyle1ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_style1_view_model.dart ---

// --- Start of common_ui\domain\navbar_style2_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarStyle2ContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarStyle2ContentViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_style2_content_view_model.dart ---

// --- Start of common_ui\domain\navbar_style2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarStyle2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarStyle2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_style2_view_model.dart ---

// --- Start of common_ui\domain\navbar_theme_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarThemeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarThemeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_theme_view_model.dart ---

// --- Start of common_ui\domain\navbar_toggle_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarToggleButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarToggleButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_toggle_button_view_model.dart ---

// --- Start of common_ui\domain\navbar_toggle_fab_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarToggleFabViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarToggleFabViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navbar_toggle_fab_view_model.dart ---

// --- Start of common_ui\domain\navigation_search_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavigationSearchViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavigationSearchViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navigation_search_view_model.dart ---

// --- Start of common_ui\domain\navigation_shortcuts_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavigationShortcutsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavigationShortcutsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navigation_shortcuts_view_model.dart ---

// --- Start of common_ui\domain\navigation_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavigationViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavigationViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\navigation_view_model.dart ---

// --- Start of common_ui\domain\node_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NodeButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NodeButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\node_button_view_model.dart ---

// --- Start of common_ui\domain\page_breadcrumb_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PageBreadcrumbViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PageBreadcrumbViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\page_breadcrumb_view_model.dart ---

// --- Start of common_ui\domain\page_title_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PageTitleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PageTitleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\page_title_view_model.dart ---

// --- Start of common_ui\domain\palette_preview_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PalettePreviewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PalettePreviewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\palette_preview_view_model.dart ---

// --- Start of common_ui\domain\palette_selector_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PaletteSelectorViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PaletteSelectorViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\palette_selector_view_model.dart ---

// --- Start of common_ui\domain\popover_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PopoverViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PopoverViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\popover_view_model.dart ---

// --- Start of common_ui\domain\powered_by_links_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PoweredByLinksViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PoweredByLinksViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\powered_by_links_view_model.dart ---

// --- Start of common_ui\domain\primecare_responsive_shell_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PrimecareResponsiveShellViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PrimecareResponsiveShellViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\primecare_responsive_shell_view_model.dart ---

// --- Start of common_ui\domain\purchase_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class PurchaseButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  PurchaseButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\purchase_button_view_model.dart ---

// --- Start of common_ui\domain\quick_panel_toggle_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class QuickPanelToggleButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  QuickPanelToggleButtonViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\quick_panel_toggle_button_view_model.dart ---

// --- Start of common_ui\domain\quick_panel_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class QuickPanelViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  QuickPanelViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\quick_panel_view_model.dart ---

// --- Start of common_ui\domain\routes_config_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RoutesConfigViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RoutesConfigViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\routes_config_view_model.dart ---

// --- Start of common_ui\domain\route_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RouteViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RouteViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\route_view_model.dart ---

// --- Start of common_ui\domain\scheme_preview_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SchemePreviewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SchemePreviewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\scheme_preview_view_model.dart ---

// --- Start of common_ui\domain\section_preview_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SectionPreviewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SectionPreviewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\section_preview_view_model.dart ---

// --- Start of common_ui\domain\separator_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SeparatorViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SeparatorViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\separator_view_model.dart ---

// --- Start of common_ui\domain\settings_panel_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SettingsPanelViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SettingsPanelViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\settings_panel_view_model.dart ---

// --- Start of common_ui\domain\sign_in_page_title_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignInPageTitleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignInPageTitleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\sign_in_page_title_view_model.dart ---

// --- Start of common_ui\domain\sign_in_page_view_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignInPageViewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignInPageViewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\sign_in_page_view_view_model.dart ---

// --- Start of common_ui\domain\sign_out_page_title_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignOutPageTitleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignOutPageTitleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\sign_out_page_title_view_model.dart ---

// --- Start of common_ui\domain\sign_out_page_view_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignOutPageViewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignOutPageViewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\sign_out_page_view_view_model.dart ---

// --- Start of common_ui\domain\sign_up_page_title_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignUpPageTitleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignUpPageTitleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\sign_up_page_title_view_model.dart ---

// --- Start of common_ui\domain\sign_up_page_view_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SignUpPageViewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SignUpPageViewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\sign_up_page_view_view_model.dart ---

// --- Start of common_ui\domain\simple_editor_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SimpleEditorViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SimpleEditorViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\simple_editor_view_model.dart ---

// --- Start of common_ui\domain\slide_to_clock_in_widget_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SlideToClockInWidgetViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SlideToClockInWidgetViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\slide_to_clock_in_widget_view_model.dart ---

// --- Start of common_ui\domain\spacer_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SpacerViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SpacerViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\spacer_view_model.dart ---

// --- Start of common_ui\domain\text_align_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class TextAlignButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  TextAlignButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\text_align_button_view_model.dart ---

// --- Start of common_ui\domain\themes_panel_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ThemesPanelViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ThemesPanelViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\themes_panel_view_model.dart ---

// --- Start of common_ui\domain\theme_preview_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ThemePreviewViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ThemePreviewViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\theme_preview_view_model.dart ---

// --- Start of common_ui\domain\theme_toggle_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ThemeToggleViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ThemeToggleViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\theme_toggle_view_model.dart ---

// --- Start of common_ui\domain\title_reference_link_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class TitleReferenceLinkViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  TitleReferenceLinkViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\title_reference_link_view_model.dart ---

// --- Start of common_ui\domain\toolbar_theme_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ToolbarThemeViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ToolbarThemeViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\toolbar_theme_view_model.dart ---

// --- Start of common_ui\domain\toolbar_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ToolbarViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ToolbarViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\toolbar_view_model.dart ---

// --- Start of common_ui\domain\tooltip_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class TooltipViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  TooltipViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\tooltip_view_model.dart ---

// --- Start of common_ui\domain\undo_redo_button_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UndoRedoButtonViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UndoRedoButtonViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\undo_redo_button_view_model.dart ---

// --- Start of common_ui\domain\user_menu_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UserMenuViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UserMenuViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\user_menu_view_model.dart ---

// --- Start of common_ui\domain\use_auth_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseAuthViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseAuthViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_auth_view_model.dart ---

// --- Start of common_ui\domain\use_aws_auth_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseAwsAuthViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseAwsAuthViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_aws_auth_view_model.dart ---

// --- Start of common_ui\domain\use_firebase_auth_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseFirebaseAuthViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseFirebaseAuthViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_firebase_auth_view_model.dart ---

// --- Start of common_ui\domain\use_fuse_dialog_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseFuseDialogContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseFuseDialogContextViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_fuse_dialog_context_view_model.dart ---

// --- Start of common_ui\domain\use_fuse_route_parameter_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseFuseRouteParameterViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseFuseRouteParameterViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_fuse_route_parameter_view_model.dart ---

// --- Start of common_ui\domain\use_fuse_settings_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseFuseSettingsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseFuseSettingsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_fuse_settings_view_model.dart ---

// --- Start of common_ui\domain\use_jwt_auth_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseJwtAuthViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseJwtAuthViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_jwt_auth_view_model.dart ---

// --- Start of common_ui\domain\use_local_storage_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseLocalStorageViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseLocalStorageViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_local_storage_view_model.dart ---

// --- Start of common_ui\domain\use_navigate_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseNavigateViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseNavigateViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_navigate_view_model.dart ---

// --- Start of common_ui\domain\use_navigation_items_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseNavigationItemsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseNavigationItemsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_navigation_items_view_model.dart ---

// --- Start of common_ui\domain\use_pathname_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UsePathnameViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UsePathnameViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_pathname_view_model.dart ---

// --- Start of common_ui\domain\use_user_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseUserViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseUserViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\use_user_view_model.dart ---

// --- Start of common_ui\domain\with_router_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class WithRouterViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  WithRouterViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\with_router_view_model.dart ---

// --- Start of common_ui\domain\with_user_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class WithUserViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  WithUserViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of common_ui\domain\with_user_view_model.dart ---

// --- Start of community_outreach_dashboard\community_outreach_dashboard_model.dart ---

class CommunityOutreachDashboardViewModel extends PrimeCareDashboardViewModel {
  const CommunityOutreachDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory CommunityOutreachDashboardViewModel.empty() {
    return CommunityOutreachDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of community_outreach_dashboard\community_outreach_dashboard_model.dart ---

// --- Start of compliance_hub\compliance_hub_model.dart ---

class ComplianceHubModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const ComplianceHubModel({required this.metrics, this.insights = const []});

  factory ComplianceHubModel.empty() {
    return ComplianceHubModel(metrics: DashboardMetrics.empty());
  }
}

// --- End of compliance_hub\compliance_hub_model.dart ---

// --- Start of compliance_manager\compliance_manager_model.dart ---

class ComplianceManagerViewModel {
  final List<String> pendingAudits;
  final double complianceScore;

  const ComplianceManagerViewModel({
    required this.pendingAudits,
    required this.complianceScore,
  });

  factory ComplianceManagerViewModel.initial() {
    return const ComplianceManagerViewModel(
      pendingAudits: ['Quarterly Safety Audit', 'Staff Certification Review'],
      complianceScore: 0.98,
    );
  }
}

// --- End of compliance_manager\compliance_manager_model.dart ---

// --- Start of coo_dashboard\coo_dashboard_model.dart ---

class COODashboardModel {
  final List<KpiData> kpis;

  COODashboardModel({required this.kpis});
}

// --- End of coo_dashboard\coo_dashboard_model.dart ---

// --- Start of corporate_governance_dashboard\corporate_governance_dashboard_model.dart ---

class CorporateGovernanceDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const CorporateGovernanceDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory CorporateGovernanceDashboardViewModel.empty() {
    return CorporateGovernanceDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of corporate_governance_dashboard\corporate_governance_dashboard_model.dart ---

// --- Start of course_architect_dashboard\course_architect_dashboard_model.dart ---

class CourseArchitectDashboardViewModel extends PrimeCareDashboardViewModel {
  const CourseArchitectDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory CourseArchitectDashboardViewModel.empty() {
    return CourseArchitectDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of course_architect_dashboard\course_architect_dashboard_model.dart ---

// --- Start of crm_forms\crm_forms_model.dart ---

class CrmFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;

  const CrmFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
  });

  factory CrmFormsViewModel.initial() {
    return const CrmFormsViewModel(
      availableForms: [
        'Franchise Lead',
        'Disclosure Approval',
        'Lead Assignment',
        'Ad Placement',
        'Vetting Call',
        'Market Share',
        'Marketing Budget',
      ],
      selectedForm: 'Franchise Lead',
    );
  }
}

// --- End of crm_forms\crm_forms_model.dart ---

// --- Start of cto_dashboard\cto_dashboard_model.dart ---

class CTODashboardModel {
  final List<KpiData> kpis;

  CTODashboardModel({required this.kpis});
}

// --- End of cto_dashboard\cto_dashboard_model.dart ---

// --- Start of customer_support\domain\customer_support_view_model.dart ---
// Layer: 02_MODELS
class CustomerSupportViewModel {
  final bool isSkeleton;
  CustomerSupportViewModel({this.isSkeleton = true});
}

// --- End of customer_support\domain\customer_support_view_model.dart ---

// --- Start of customer_support_dashboard\customer_support_dashboard_model.dart ---

class CustomerSupportDashboardViewModel extends PrimeCareDashboardViewModel {
  const CustomerSupportDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory CustomerSupportDashboardViewModel.empty() {
    return CustomerSupportDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of customer_support_dashboard\customer_support_dashboard_model.dart ---

// --- Start of cx_director_dashboard\cx_director_dashboard_model.dart ---

class CXDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const CXDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory CXDirectorDashboardViewModel.empty() {
    return CXDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of cx_director_dashboard\cx_director_dashboard_model.dart ---

// --- Start of developer_samples\domain\developer_samples_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class DeveloperSamplesViewModel {
  final String title;
  final String status;

  const DeveloperSamplesViewModel({required this.title, required this.status});
}

// --- End of developer_samples\domain\developer_samples_view_model.dart ---

// --- Start of dynamic_screen_dashboard\dynamic_screen_dashboard_model.dart ---

class DynamicScreenDashboardViewModel extends PrimeCareDashboardViewModel {
  const DynamicScreenDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory DynamicScreenDashboardViewModel.empty() {
    return DynamicScreenDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of dynamic_screen_dashboard\dynamic_screen_dashboard_model.dart ---

// --- Start of family_dashboard\family_dashboard_model.dart ---

class FamilyDashboardViewModel extends PrimeCareDashboardViewModel {
  const FamilyDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory FamilyDashboardViewModel.empty() {
    return FamilyDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of family_dashboard\family_dashboard_model.dart ---

// --- Start of family_member\family_member_model.dart ---

class FamilyMemberViewModel {
  final String patientName;
  final List<String> updates;

  const FamilyMemberViewModel({
    required this.patientName,
    required this.updates,
  });

  factory FamilyMemberViewModel.initial() {
    return const FamilyMemberViewModel(
      patientName: 'John Doe',
      updates: ['Medication administered at 8:00 AM', 'Vitals checked: Normal'],
    );
  }
}

// --- End of family_member\family_member_model.dart ---

// --- Start of family_member_dashboard\family_member_dashboard_model.dart ---

class FamilyMemberDashboardViewModel extends PrimeCareDashboardViewModel {
  const FamilyMemberDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory FamilyMemberDashboardViewModel.empty() {
    return FamilyMemberDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of family_member_dashboard\family_member_dashboard_model.dart ---

// --- Start of finance_director_dashboard\finance_director_dashboard_model.dart ---

class FinanceDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const FinanceDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory FinanceDirectorDashboardViewModel.empty() {
    return FinanceDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of finance_director_dashboard\finance_director_dashboard_model.dart ---

// --- Start of financial_forms\financial_forms_model.dart ---

class FinancialFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;

  const FinancialFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
  });

  factory FinancialFormsViewModel.initial() {
    return const FinancialFormsViewModel(
      availableForms: [
        'Expense Reimbursement',
        'Payroll Run',
        'Payroll Discrepancy',
        'Custom Invoice',
        'Revenue Report',
        'Petty Cash',
      ],
      selectedForm: 'Expense Reimbursement',
    );
  }
}

// --- End of financial_forms\financial_forms_model.dart ---

// --- Start of franchise_owner\franchise_owner_model.dart ---

class FranchiseOwnerViewModel {
  final String region;
  final double monthlyRevenue;
  final int activeStaff;

  const FranchiseOwnerViewModel({
    required this.region,
    required this.monthlyRevenue,
    required this.activeStaff,
  });

  factory FranchiseOwnerViewModel.initial() {
    return const FranchiseOwnerViewModel(
      region: 'North York',
      monthlyRevenue: 125000.0,
      activeStaff: 42,
    );
  }
}

// --- End of franchise_owner\franchise_owner_model.dart ---

// --- Start of franchise_owner_dashboard\franchise_owner_dashboard_model.dart ---

class FranchiseOwnerDashboardViewModel extends PrimeCareDashboardViewModel {
  const FranchiseOwnerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory FranchiseOwnerDashboardViewModel.empty() {
    return FranchiseOwnerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of franchise_owner_dashboard\franchise_owner_dashboard_model.dart ---

// --- Start of franchise_sales_manager_dashboard\franchise_sales_manager_dashboard_model.dart ---

class FranchiseSalesManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const FranchiseSalesManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory FranchiseSalesManagerDashboardViewModel.empty() {
    return FranchiseSalesManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of franchise_sales_manager_dashboard\franchise_sales_manager_dashboard_model.dart ---

// --- Start of general_manager_dashboard\general_manager_dashboard_model.dart ---

class GeneralManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const GeneralManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory GeneralManagerDashboardViewModel.empty() {
    return GeneralManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of general_manager_dashboard\general_manager_dashboard_model.dart ---

// --- Start of guest_dashboard\guest_dashboard_model.dart ---

class GuestDashboardViewModel extends PrimeCareDashboardViewModel {
  const GuestDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory GuestDashboardViewModel.empty() {
    return GuestDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of guest_dashboard\guest_dashboard_model.dart ---

// --- Start of head_of_bus_dev_dashboard\head_of_bus_dev_dashboard_model.dart ---

class HeadOfBusDevDashboardViewModel extends PrimeCareDashboardViewModel {
  const HeadOfBusDevDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HeadOfBusDevDashboardViewModel.empty() {
    return HeadOfBusDevDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of head_of_bus_dev_dashboard\head_of_bus_dev_dashboard_model.dart ---

// --- Start of head_of_marketing_dashboard\head_of_marketing_dashboard_model.dart ---

class HeadOfMarketingDashboardViewModel extends PrimeCareDashboardViewModel {
  const HeadOfMarketingDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HeadOfMarketingDashboardViewModel.empty() {
    return HeadOfMarketingDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of head_of_marketing_dashboard\head_of_marketing_dashboard_model.dart ---

// --- Start of hr_director_dashboard\hr_director_dashboard_model.dart ---

class HumanResourcesDirectorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const HumanResourcesDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HumanResourcesDirectorDashboardViewModel.empty() {
    return HumanResourcesDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of hr_director_dashboard\hr_director_dashboard_model.dart ---

// --- Start of hr_forms\hr_forms_model.dart ---

class HrFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;
  final bool isSubmitting;

  const HrFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
    this.isSubmitting = false,
  });

  factory HrFormsViewModel.initial() {
    return const HrFormsViewModel(
      availableForms: [
        'Leave Request',
        'Grievance',
        'Onboarding',
        'Interview',
        'Exit Interview',
      ],
      selectedForm: 'Leave Request',
    );
  }

  HrFormsViewModel copyWith({
    List<String>? availableForms,
    String? selectedForm,
    bool? isSubmitting,
  }) {
    return HrFormsViewModel(
      availableForms: availableForms ?? this.availableForms,
      selectedForm: selectedForm ?? this.selectedForm,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

// --- End of hr_forms\hr_forms_model.dart ---

// --- Start of hr_forms\domain\approve_leave_request_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ApproveLeaveRequestFormViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ApproveLeaveRequestFormViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of hr_forms\domain\approve_leave_request_form_view_model.dart ---

// --- Start of hr_forms\domain\assign_training_module_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

// --- End of hr_forms\domain\assign_training_module_form_view_model.dart ---

// --- Start of hr_forms\domain\audit_payroll_discrepancy_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class AuditPayrollDiscrepancyFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  AuditPayrollDiscrepancyFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  AuditPayrollDiscrepancyFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return AuditPayrollDiscrepancyFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of hr_forms\domain\audit_payroll_discrepancy_form_view_model.dart ---

// --- Start of hr_forms\domain\discipline_log_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

// --- End of hr_forms\domain\discipline_log_form_view_model.dart ---

// --- Start of hr_forms\domain\leave_request_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

// --- End of hr_forms\domain\leave_request_form_view_model.dart ---

// --- Start of hr_forms\domain\log_employee_grievance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class LogEmployeeGrievanceFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  LogEmployeeGrievanceFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  LogEmployeeGrievanceFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return LogEmployeeGrievanceFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of hr_forms\domain\log_employee_grievance_form_view_model.dart ---

// --- Start of hr_forms\domain\new_employee_onboarding_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class NewEmployeeOnboardingFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  NewEmployeeOnboardingFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  NewEmployeeOnboardingFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return NewEmployeeOnboardingFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of hr_forms\domain\new_employee_onboarding_form_view_model.dart ---

// --- Start of hr_forms\domain\request_shift_adjustment_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

// --- End of hr_forms\domain\request_shift_adjustment_form_view_model.dart ---

// --- Start of hr_forms\domain\review_onboarding_status_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

// --- End of hr_forms\domain\review_onboarding_status_form_view_model.dart ---

// --- Start of hr_forms\domain\review_peer_performance_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

// --- End of hr_forms\domain\review_peer_performance_form_view_model.dart ---

// --- Start of hr_forms\domain\schedule_interview_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class ScheduleInterviewFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  ScheduleInterviewFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  ScheduleInterviewFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return ScheduleInterviewFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of hr_forms\domain\schedule_interview_form_view_model.dart ---

// --- Start of hr_forms\domain\submit_exit_interview_form_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class SubmitExitInterviewFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;

  SubmitExitInterviewFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
  });

  SubmitExitInterviewFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return SubmitExitInterviewFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

// --- End of hr_forms\domain\submit_exit_interview_form_view_model.dart ---

// --- Start of hr_hiring_dashboard\hr_hiring_dashboard_model.dart ---

class HrHiringDashboardViewModel extends PrimeCareDashboardViewModel {
  const HrHiringDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HrHiringDashboardViewModel.empty() {
    return HrHiringDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of hr_hiring_dashboard\hr_hiring_dashboard_model.dart ---

// --- Start of hr_manager_dashboard\hr_manager_dashboard_model.dart ---

class HumanResourcesManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const HumanResourcesManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HumanResourcesManagerDashboardViewModel.empty() {
    return HumanResourcesManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of hr_manager_dashboard\hr_manager_dashboard_model.dart ---

// --- Start of infection_control_dashboard\infection_control_dashboard_model.dart ---

class InfectionControlDashboardViewModel extends PrimeCareDashboardViewModel {
  const InfectionControlDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory InfectionControlDashboardViewModel.empty() {
    return InfectionControlDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of infection_control_dashboard\infection_control_dashboard_model.dart ---

// --- Start of intake_coordinator\intake_coordinator_model.dart ---

class IntakeCoordinatorViewModel extends PrimeCareDashboardViewModel {
  const IntakeCoordinatorViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory IntakeCoordinatorViewModel.empty() {
    return IntakeCoordinatorViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of intake_coordinator\intake_coordinator_model.dart ---

// --- Start of intake_coordinator_dashboard\intake_coordinator_dashboard_model.dart ---

class IntakeCoordinatorDashboardViewModel extends PrimeCareDashboardViewModel {
  const IntakeCoordinatorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory IntakeCoordinatorDashboardViewModel.empty() {
    return IntakeCoordinatorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of intake_coordinator_dashboard\intake_coordinator_dashboard_model.dart ---

// --- Start of intake_dashboard\intake_dashboard_model.dart ---

class IntakeDashboardViewModel extends PrimeCareDashboardViewModel {
  const IntakeDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory IntakeDashboardViewModel.empty() {
    return IntakeDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of intake_dashboard\intake_dashboard_model.dart ---

// --- Start of it_security_dashboard\it_security_dashboard_model.dart ---

class ITSecurityDashboardViewModel extends PrimeCareDashboardViewModel {
  const ITSecurityDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ITSecurityDashboardViewModel.empty() {
    return ITSecurityDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of it_security_dashboard\it_security_dashboard_model.dart ---

// --- Start of local_marketing_manager_dashboard\local_marketing_manager_dashboard_model.dart ---

class LocalMarketingManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const LocalMarketingManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory LocalMarketingManagerDashboardViewModel.empty() {
    return LocalMarketingManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of local_marketing_manager_dashboard\local_marketing_manager_dashboard_model.dart ---

// --- Start of marketing_manager\marketing_manager_dashboard_model.dart ---

class MarketingManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const MarketingManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory MarketingManagerDashboardViewModel.empty() {
    return MarketingManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of marketing_manager\marketing_manager_dashboard_model.dart ---

// --- Start of marketing_manager\marketing_manager_model.dart ---

class MarketingManagerViewModel {
  final int activeCampaigns;
  final int leadConversions;

  const MarketingManagerViewModel({
    required this.activeCampaigns,
    required this.leadConversions,
  });

  factory MarketingManagerViewModel.initial() {
    return const MarketingManagerViewModel(
      activeCampaigns: 12,
      leadConversions: 450,
    );
  }
}

// --- End of marketing_manager\marketing_manager_model.dart ---

// --- Start of operations_manager_dashboard\operations_manager_dashboard_model.dart ---

class OperationsManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const OperationsManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory OperationsManagerDashboardViewModel.empty() {
    return OperationsManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of operations_manager_dashboard\operations_manager_dashboard_model.dart ---

// --- Start of owner_dashboard\owner_dashboard_model.dart ---

class OwnerDashboardViewModel extends PrimeCareDashboardViewModel {
  const OwnerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory OwnerDashboardViewModel.empty() {
    return OwnerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of owner_dashboard\owner_dashboard_model.dart ---

// --- Start of partnership_manager_dashboard\partnership_manager_dashboard_model.dart ---

class PartnershipManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const PartnershipManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PartnershipManagerDashboardViewModel.empty() {
    return PartnershipManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of partnership_manager_dashboard\partnership_manager_dashboard_model.dart ---

// --- Start of patient_dashboard\patient_dashboard_model.dart ---

class PatientDashboardViewModel extends PrimeCareDashboardViewModel {
  const PatientDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory PatientDashboardViewModel.empty() {
    return PatientDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of patient_dashboard\patient_dashboard_model.dart ---

// --- Start of physiotherapist\physiotherapist_model.dart ---

class PhysiotherapistViewModel {
  final String title;
  final List<String> sessions;

  const PhysiotherapistViewModel({required this.title, required this.sessions});

  factory PhysiotherapistViewModel.initial() {
    return const PhysiotherapistViewModel(
      title: 'Physiotherapy Rehabilitation Center',
      sessions: ['10:00 AM - Knee Rehab', '2:00 PM - Post-Op Assessment'],
    );
  }
}

// --- End of physiotherapist\physiotherapist_model.dart ---

// --- Start of psw\psw_model.dart ---

class PswViewModel extends PrimeCareDashboardViewModel {
  const PswViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PswViewModel.empty() {
    return PswViewModel(metrics: DashboardMetrics.empty(), insights: const []);
  }
}

// --- End of psw\psw_model.dart ---

// --- Start of psw_dashboard\psw_dashboard_model.dart ---

class PswDashboardViewModel extends PrimeCareDashboardViewModel {
  const PswDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PswDashboardViewModel.empty() {
    return PswDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of psw_dashboard\psw_dashboard_model.dart ---

// --- Start of qa_dashboard\qa_dashboard_model.dart ---

class QaDashboardViewModel extends PrimeCareDashboardViewModel {
  const QaDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory QaDashboardViewModel.empty() {
    return QaDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of qa_dashboard\qa_dashboard_model.dart ---

// --- Start of quality_assurance_dashboard\quality_assurance_dashboard_model.dart ---

class QualityAssuranceDashboardViewModel extends PrimeCareDashboardViewModel {
  const QualityAssuranceDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory QualityAssuranceDashboardViewModel.empty() {
    return QualityAssuranceDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of quality_assurance_dashboard\quality_assurance_dashboard_model.dart ---

// --- Start of receptionist_dashboard\receptionist_dashboard_model.dart ---

class ReceptionistDashboardViewModel extends PrimeCareDashboardViewModel {
  const ReceptionistDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ReceptionistDashboardViewModel.empty() {
    return ReceptionistDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of receptionist_dashboard\receptionist_dashboard_model.dart ---

// --- Start of regional_bdm_dashboard\regional_bdm_dashboard_model.dart ---

class RegionalBdmDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalBdmDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalBdmDashboardViewModel.empty() {
    return RegionalBdmDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of regional_bdm_dashboard\regional_bdm_dashboard_model.dart ---

// --- Start of regional_manager\regional_manager_dashboard_model.dart ---

class RegionalManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalManagerDashboardViewModel.empty() {
    return RegionalManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of regional_manager\regional_manager_dashboard_model.dart ---

// --- Start of regional_manager_ontario_dashboard\regional_manager_ontario_dashboard_model.dart ---

class RegionalManagerOntarioDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const RegionalManagerOntarioDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalManagerOntarioDashboardViewModel.empty() {
    return RegionalManagerOntarioDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of regional_manager_ontario_dashboard\regional_manager_ontario_dashboard_model.dart ---

// --- Start of regional_manager_usa_dashboard\regional_manager_usa_dashboard_model.dart ---

class RegionalManagerUsaDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerUsaDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalManagerUsaDashboardViewModel.empty() {
    return RegionalManagerUsaDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of regional_manager_usa_dashboard\regional_manager_usa_dashboard_model.dart ---

// --- Start of region_dashboard\region_dashboard_model.dart ---

class RegionDashboardModel {
  final List<KpiData> kpis;

  RegionDashboardModel({required this.kpis});
}

// --- End of region_dashboard\region_dashboard_model.dart ---

// --- Start of rmt_dashboard\rmt_dashboard_model.dart ---

class RmtDashboardViewModel extends PrimeCareDashboardViewModel {
  const RmtDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RmtDashboardViewModel.empty() {
    return RmtDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of rmt_dashboard\rmt_dashboard_model.dart ---

// --- Start of rn\rn_model.dart ---

class RnViewModel extends PrimeCareDashboardViewModel {
  const RnViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RnViewModel.empty() {
    return RnViewModel(metrics: DashboardMetrics.empty(), insights: const []);
  }
}

// --- End of rn\rn_model.dart ---

// --- Start of rn_dashboard\rn_dashboard_model.dart ---

class RnDashboardViewModel extends PrimeCareDashboardViewModel {
  const RnDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RnDashboardViewModel.empty() {
    return RnDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of rn_dashboard\rn_dashboard_model.dart ---

// --- Start of rpn\rpn_model.dart ---

class RpnViewModel extends PrimeCareDashboardViewModel {
  const RpnViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RpnViewModel.empty() {
    return RpnViewModel(metrics: DashboardMetrics.empty(), insights: const []);
  }
}

// --- End of rpn\rpn_model.dart ---

// --- Start of scheduler\domain\scheduler_view_model.dart ---
// Layer: 02_MODELS
class SchedulerViewModel {
  final bool isSkeleton;
  SchedulerViewModel({this.isSkeleton = true});
}

// --- End of scheduler\domain\scheduler_view_model.dart ---

// --- Start of scheduler_dashboard\scheduler_dashboard_model.dart ---

class SchedulerDashboardViewModel extends PrimeCareDashboardViewModel {
  const SchedulerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SchedulerDashboardViewModel.empty() {
    return SchedulerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of scheduler_dashboard\scheduler_dashboard_model.dart ---

// --- Start of scrum_master_dashboard\scrum_master_dashboard_model.dart ---

class ScrumMasterDashboardViewModel extends PrimeCareDashboardViewModel {
  const ScrumMasterDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ScrumMasterDashboardViewModel.empty() {
    return ScrumMasterDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of scrum_master_dashboard\scrum_master_dashboard_model.dart ---

// --- Start of shared\icons\domain\align_center_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AlignCenterIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AlignCenterIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\align_center_icon_view_model.dart ---

// --- Start of shared\icons\domain\align_justify_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AlignJustifyIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AlignJustifyIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\align_justify_icon_view_model.dart ---

// --- Start of shared\icons\domain\align_left_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AlignLeftIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AlignLeftIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\align_left_icon_view_model.dart ---

// --- Start of shared\icons\domain\align_right_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AlignRightIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AlignRightIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\align_right_icon_view_model.dart ---

// --- Start of shared\icons\domain\arrow_left_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ArrowLeftIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ArrowLeftIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\arrow_left_icon_view_model.dart ---

// --- Start of shared\icons\domain\ban_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class BanIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  BanIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\ban_icon_view_model.dart ---

// --- Start of shared\icons\domain\block_quote_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class BlockQuoteIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  BlockQuoteIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\block_quote_icon_view_model.dart ---

// --- Start of shared\icons\domain\bold_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class BoldIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  BoldIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\bold_icon_view_model.dart ---

// --- Start of shared\icons\domain\chevron_down_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ChevronDownIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ChevronDownIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\chevron_down_icon_view_model.dart ---

// --- Start of shared\icons\domain\close_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class CloseIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  CloseIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\close_icon_view_model.dart ---

// --- Start of shared\icons\domain\code2_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Code2IconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Code2IconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\code2_icon_view_model.dart ---

// --- Start of shared\icons\domain\code_block_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class CodeBlockIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  CodeBlockIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\code_block_icon_view_model.dart ---

// --- Start of shared\icons\domain\corner_down_left_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class CornerDownLeftIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  CornerDownLeftIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\corner_down_left_icon_view_model.dart ---

// --- Start of shared\icons\domain\external_link_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ExternalLinkIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ExternalLinkIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\external_link_icon_view_model.dart ---

// --- Start of shared\icons\domain\fuse_svg_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseSvgIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseSvgIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\fuse_svg_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_five_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingFiveIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingFiveIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_five_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_four_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingFourIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingFourIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_four_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_one_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingOneIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingOneIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_one_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_six_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingSixIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingSixIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_six_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_three_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingThreeIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingThreeIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_three_icon_view_model.dart ---

// --- Start of shared\icons\domain\heading_two_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HeadingTwoIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HeadingTwoIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\heading_two_icon_view_model.dart ---

// --- Start of shared\icons\domain\highlighter_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class HighlighterIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  HighlighterIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\highlighter_icon_view_model.dart ---

// --- Start of shared\icons\domain\image_plus_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ImagePlusIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ImagePlusIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\image_plus_icon_view_model.dart ---

// --- Start of shared\icons\domain\italic_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ItalicIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ItalicIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\italic_icon_view_model.dart ---

// --- Start of shared\icons\domain\link_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LinkIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LinkIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\link_icon_view_model.dart ---

// --- Start of shared\icons\domain\list_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ListIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ListIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\list_icon_view_model.dart ---

// --- Start of shared\icons\domain\list_ordered_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ListOrderedIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ListOrderedIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\list_ordered_icon_view_model.dart ---

// --- Start of shared\icons\domain\list_todo_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ListTodoIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ListTodoIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\list_todo_icon_view_model.dart ---

// --- Start of shared\icons\domain\moon_star_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MoonStarIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MoonStarIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\moon_star_icon_view_model.dart ---

// --- Start of shared\icons\domain\redo2_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Redo2IconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Redo2IconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\redo2_icon_view_model.dart ---

// --- Start of shared\icons\domain\strike_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class StrikeIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  StrikeIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\strike_icon_view_model.dart ---

// --- Start of shared\icons\domain\subscript_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SubscriptIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SubscriptIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\subscript_icon_view_model.dart ---

// --- Start of shared\icons\domain\sun_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SunIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SunIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\sun_icon_view_model.dart ---

// --- Start of shared\icons\domain\superscript_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class SuperscriptIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  SuperscriptIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\superscript_icon_view_model.dart ---

// --- Start of shared\icons\domain\trash_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class TrashIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  TrashIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\trash_icon_view_model.dart ---

// --- Start of shared\icons\domain\underline_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UnderlineIconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UnderlineIconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\underline_icon_view_model.dart ---

// --- Start of shared\icons\domain\undo2_icon_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class Undo2IconViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  Undo2IconViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\icons\domain\undo2_icon_view_model.dart ---

// --- Start of shared\layouts\domain\admin_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AdminLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AdminLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\admin_layout_view_model.dart ---

// --- Start of shared\layouts\domain\auth_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuthLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuthLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\auth_layout_view_model.dart ---

// --- Start of shared\layouts\domain\auth_split_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class AuthSplitLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  AuthSplitLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\auth_split_layout_view_model.dart ---

// --- Start of shared\layouts\domain\client_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ClientLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ClientLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\client_layout_view_model.dart ---

// --- Start of shared\layouts\domain\demo_layout_footer_content_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class DemoLayoutFooterContentViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  DemoLayoutFooterContentViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\demo_layout_footer_content_view_model.dart ---

// --- Start of shared\layouts\domain\footer_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FooterLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FooterLayout1ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\footer_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\footer_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FooterLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FooterLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\footer_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\footer_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FooterLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FooterLayout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\footer_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_layout_configs_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseLayoutConfigsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseLayoutConfigsViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_layout_configs_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_layout_config_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseLayoutConfigViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseLayoutConfigViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_layout_config_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_layout_settings_context_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseLayoutSettingsContextViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseLayoutSettingsContextViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_layout_settings_context_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_layout_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_nav_horizontal_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavHorizontalLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavHorizontalLayout1ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_nav_horizontal_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_nav_vertical_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalLayout1ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_nav_vertical_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\fuse_nav_vertical_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class FuseNavVerticalLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  FuseNavVerticalLayout2ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\fuse_nav_vertical_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\left_side_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LeftSideLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LeftSideLayout1ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\left_side_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\left_side_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LeftSideLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LeftSideLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\left_side_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\left_side_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class LeftSideLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  LeftSideLayout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\left_side_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\master_detail_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MasterDetailLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MasterDetailLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\master_detail_layout_view_model.dart ---

// --- Start of shared\layouts\domain\master_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class MasterLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  MasterLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\master_layout_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarLayout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_mobile_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarMobileLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarMobileLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_mobile_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_mobile_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarMobileLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarMobileLayout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_mobile_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_toggle_fab_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarToggleFabLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarToggleFabLayout1ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_toggle_fab_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_toggle_fab_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarToggleFabLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarToggleFabLayout2ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_toggle_fab_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_wrapper_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarWrapperLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarWrapperLayout1ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_wrapper_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_wrapper_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarWrapperLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarWrapperLayout2ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_wrapper_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\navbar_wrapper_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class NavbarWrapperLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  NavbarWrapperLayout3ViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\navbar_wrapper_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\provider_layout_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ProviderLayoutViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ProviderLayoutViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\provider_layout_view_model.dart ---

// --- Start of shared\layouts\domain\right_side_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RightSideLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RightSideLayout1ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\right_side_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\right_side_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RightSideLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RightSideLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\right_side_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\right_side_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class RightSideLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  RightSideLayout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\right_side_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\toolbar_layout1_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ToolbarLayout1ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ToolbarLayout1ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\toolbar_layout1_view_model.dart ---

// --- Start of shared\layouts\domain\toolbar_layout2_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ToolbarLayout2ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ToolbarLayout2ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\toolbar_layout2_view_model.dart ---

// --- Start of shared\layouts\domain\toolbar_layout3_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class ToolbarLayout3ViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  ToolbarLayout3ViewModel({required this.title, this.metadata = const {}});

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\toolbar_layout3_view_model.dart ---

// --- Start of shared\layouts\domain\use_fuse_layout_settings_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION

class UseFuseLayoutSettingsViewModel extends PrimeCareViewModel {
  final String title;
  final Map<String, dynamic> metadata;

  UseFuseLayoutSettingsViewModel({
    required this.title,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [title, metadata];

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metadata': metadata,
    'isOfflineFallback': isOfflineFallback,
  };
}

// --- End of shared\layouts\domain\use_fuse_layout_settings_view_model.dart ---

// --- Start of shareholder_intelligence\shareholder_intelligence_model.dart ---

class ShareholderIntelligenceViewModel extends PrimeCareDashboardViewModel {
  const ShareholderIntelligenceViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ShareholderIntelligenceViewModel.empty() {
    return ShareholderIntelligenceViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of shareholder_intelligence\shareholder_intelligence_model.dart ---

// --- Start of sign_in_view\sign_in_model.dart ---

class SignInViewModel {
  const SignInViewModel();
}

// --- End of sign_in_view\sign_in_model.dart ---

// --- Start of sign_out_view\sign_out_model.dart ---

class SignOutViewModel {
  const SignOutViewModel();
}

// --- End of sign_out_view\sign_out_model.dart ---

// --- Start of sign_up_view\sign_up_model.dart ---

class SignUpViewModel {
  const SignUpViewModel();
}

// --- End of sign_up_view\sign_up_model.dart ---

// --- Start of social_worker_dashboard\social_worker_dashboard_model.dart ---

class SocialWorkerDashboardViewModel extends PrimeCareDashboardViewModel {
  const SocialWorkerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SocialWorkerDashboardViewModel.empty() {
    return SocialWorkerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of social_worker_dashboard\social_worker_dashboard_model.dart ---

// --- Start of support_dashboard\support_dashboard_model.dart ---

class SupportDashboardViewModel extends PrimeCareDashboardViewModel {
  const SupportDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SupportDashboardViewModel.empty() {
    return SupportDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of support_dashboard\support_dashboard_model.dart ---

// --- Start of system_dashboard\system_dashboard_model.dart ---

class SystemDashboardModel {
  final List<KpiData> kpis;

  SystemDashboardModel({required this.kpis});
}

// --- End of system_dashboard\system_dashboard_model.dart ---

// --- Start of system_verification\domain\system_verification_view_model.dart ---
// Layer: 02_MODELS_FOUNDATION
class SystemVerificationViewModel {
  final String status;
  final Map<String, int> modelCounts;
  final bool isOffline;

  const SystemVerificationViewModel({
    required this.status,
    required this.modelCounts,
    this.isOffline = false,
  });

  factory SystemVerificationViewModel.fromJson(Map<String, dynamic> json) {
    // The new Cloudflare edge endpoint returns:
    // {"success": true, "totalTables": X, "data": [{"relname": "User", "n_live_tup": 10}]}
    final dbStatus = json['success'] == true ? 'connected' : 'error';

    final countsRaw = json['data'] as List<dynamic>? ?? [];
    final parsedCounts = <String, int>{};

    for (final item in countsRaw) {
      if (item is Map) {
        final key = item['relname'] as String?;
        final value = item['n_live_tup'];
        if (key != null) {
          if (value is int) {
            parsedCounts[key] = value;
          } else if (value is String) {
            parsedCounts[key] = int.tryParse(value) ?? 0;
          }
        }
      }
    }

    return SystemVerificationViewModel(
      status: dbStatus,
      modelCounts: parsedCounts,
    );
  }

  Map<String, dynamic> toJson() {
    return {'db': status, 'counts': modelCounts, 'isOffline': isOffline};
  }

  static SystemVerificationViewModel assemble({bool isOffline = false}) {
    return SystemVerificationViewModel(
      status: isOffline ? 'offline' : 'fallback',
      modelCounts: const {'PlatformScreen': 266, 'VerificationLog': 0},
      isOffline: isOffline,
    );
  }
}

// --- End of system_verification\domain\system_verification_view_model.dart ---

// --- Start of system_verification_dashboard\system_verification_dashboard_model.dart ---

class SystemVerificationDashboardViewModel extends PrimeCareDashboardViewModel {
  const SystemVerificationDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SystemVerificationDashboardViewModel.empty() {
    return SystemVerificationDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of system_verification_dashboard\system_verification_dashboard_model.dart ---

// --- Start of territory_expansion_manager_dashboard\territory_expansion_manager_dashboard_model.dart ---

class TerritoryExpansionManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TerritoryExpansionManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TerritoryExpansionManagerDashboardViewModel.empty() {
    return TerritoryExpansionManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of territory_expansion_manager_dashboard\territory_expansion_manager_dashboard_model.dart ---

// --- Start of territory_sales_manager_dashboard\territory_sales_manager_dashboard_model.dart ---

class TerritorySalesManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TerritorySalesManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TerritorySalesManagerDashboardViewModel.empty() {
    return TerritorySalesManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of territory_sales_manager_dashboard\territory_sales_manager_dashboard_model.dart ---

// --- Start of training_coordinator_dashboard\training_coordinator_dashboard_model.dart ---

class TrainingCoordinatorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TrainingCoordinatorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingCoordinatorDashboardViewModel.empty() {
    return TrainingCoordinatorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of training_coordinator_dashboard\training_coordinator_dashboard_model.dart ---

// --- Start of training_director_certificate_dashboard\training_director_certificate_dashboard_model.dart ---

class TrainingDirectorCertificateDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TrainingDirectorCertificateDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingDirectorCertificateDashboardViewModel.empty() {
    return TrainingDirectorCertificateDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of training_director_certificate_dashboard\training_director_certificate_dashboard_model.dart ---

// --- Start of training_director_dashboard\training_director_dashboard_model.dart ---

class TrainingDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const TrainingDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingDirectorDashboardViewModel.empty() {
    return TrainingDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of training_director_dashboard\training_director_dashboard_model.dart ---

// --- Start of training_hub_dashboard\training_hub_dashboard_model.dart ---

class TrainingHubDashboardViewModel extends PrimeCareDashboardViewModel {
  const TrainingHubDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingHubDashboardViewModel.empty() {
    return TrainingHubDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of training_hub_dashboard\training_hub_dashboard_model.dart ---

// --- Start of verification_hub\verification_hub_model.dart ---

class VerificationHubModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;

  const VerificationHubModel({required this.metrics, this.insights = const []});

  factory VerificationHubModel.empty() {
    return VerificationHubModel(metrics: DashboardMetrics.empty());
  }
}

// --- End of verification_hub\verification_hub_model.dart ---

// --- Start of volunteer_coordinator_dashboard\volunteer_coordinator_dashboard_model.dart ---

class VolunteerCoordinatorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const VolunteerCoordinatorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory VolunteerCoordinatorDashboardViewModel.empty() {
    return VolunteerCoordinatorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}

// --- End of volunteer_coordinator_dashboard\volunteer_coordinator_dashboard_model.dart ---
