// Layer: 00_ENTRY_POINT
// Master export file for flutter_core.
export 'package:primecare_adapters/primecare_adapters.dart'
    hide architecturePurposeProvider, databaseReportProvider;
export 'package:primecare_ui/00_B_primecare_ui.dart' hide AppTheme;

export '01_I_adapter_providers.dart';
export '01_I_auth_service.dart';
export '01_I_dashboard_providers.dart'
    hide dashboardServiceProvider, dashboardMetricsProvider;
export '01_I_domain_service.dart';
export '01_I_dynamic_page_providers.dart';
export '01_I_dynamic_adapter_resolver.dart';
export '01_I_preference_service.dart';
export '01_I_provider_service.dart';
export 'routes/01_I_route_guard.dart';

export 'src/resilience/01_I_app_error_boundary.dart';
export 'src/resilience/01_I_connectivity_service.dart';
export 'src/resilience/01_I_provider_ttl.dart';
export '01_I_verification_service.dart';
export '01_I_verification_providers.dart';

// Mission-critical symbols for standardized Notifiers and Resilience
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'src/resilience/01_I_resilient_notifier_mixin.dart';

export 'package:lucide_icons/lucide_icons.dart';

export 'providers/03_D_portal_providers.dart';
export 'providers/03_D_user_management_provider.dart';

export 'config/01_I_data_source_mode.dart';
export 'config/01_I_feature_flags.dart';
export 'config/01_I_screen_registry.dart';
export 'config/01_I_screen_breakpoints.dart';
export 'config/01_I_adaptive_scaling_config.dart';
export 'config/01_I_navigation_registry.dart';
export 'models/01_I_navigation_item.dart';

export 'manifest/01_I_action_manifest.dart';

export 'network/01_I_error_mapper.dart';
export 'registry/01_I_file_registry.dart';
export 'registry/01_I_screen_data_registry.dart';
export 'routes/groups/01_I_admin_routes.dart';
export 'routes/groups/01_I_business_development_routes.dart';
export 'routes/groups/01_I_client_routes.dart';
export 'routes/groups/01_I_clinical_routes.dart';
export 'routes/groups/01_I_corporate_routes.dart';
export 'routes/groups/01_I_franchise_routes.dart';
export 'routes/groups/01_I_marketing_routes.dart';
export 'routes/groups/01_I_support_routes.dart';
export 'routes/groups/01_I_common_routes.dart';
export 'theme/01_I_app_theme.dart';

// Dashboards and ViewModels are now consolidated in primecare_adapters
// Direct exports from local features have been removed to maintain decoupling.

export '01_I_report_service.dart';
export '01_I_report_providers.dart';
export '01_I_intelligence_service.dart';
export '01_I_intelligence_providers.dart';
export '01_I_aura_command_service.dart';
export '01_I_aura_pulse_service.dart';
export '01_I_aura_providers.dart';

// Institutional Scheduler
export 'src/services/01_I_scheduler_service.dart';
export '01_I_scheduler_providers.dart';
export 'src/models/02_M_aura_intent.dart';
export 'src/models/02_M_aura_event.dart';

// Administrative Forms
export 'features/administrative_forms/domain/models/02_M_approve_leave_request_form_view_model.dart';
export 'features/administrative_forms/data/adapters/01_I_approve_leave_request_form_adapter.dart';
export 'features/administrative_forms/domain/models/02_M_approve_expense_reimbursement_form_view_model.dart';
export 'features/administrative_forms/data/adapters/01_I_approve_expense_reimbursement_form_adapter.dart';
export 'features/administrative_forms/domain/models/02_M_approve_payroll_run_form_view_model.dart';
export 'features/administrative_forms/data/adapters/01_I_approve_payroll_run_form_adapter.dart';

// Clinical Forms
export 'features/clinical_forms/domain/models/02_M_patient_intake_form_view_model.dart';
export 'features/clinical_forms/data/adapters/01_I_patient_intake_form_adapter.dart';
export 'features/clinical_forms/domain/models/02_M_daily_vitals_card_form_view_model.dart';
export 'features/clinical_forms/data/adapters/01_I_daily_vitals_card_form_adapter.dart';
export 'features/clinical_forms/domain/models/02_M_approve_medication_refill_form_view_model.dart';
export 'features/clinical_forms/data/adapters/01_I_approve_medication_refill_form_adapter.dart';

// CRM Forms
export 'features/crm_forms/domain/models/02_M_add_franchise_lead_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_add_franchise_lead_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_assign_lead_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_assign_lead_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_submit_marketing_budget_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_submit_marketing_budget_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_approve_franchise_disclosure_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_approve_franchise_disclosure_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_create_ad_placement_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_create_ad_placement_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_franchise_onboarding_checklist_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_franchise_onboarding_checklist_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_log_franchisee_vetting_call_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_log_franchisee_vetting_call_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_nurture_localized_lead_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_nurture_localized_lead_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_review_lead_conversion_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_review_lead_conversion_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_review_market_share_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_review_market_share_form_adapter.dart';
export 'features/crm_forms/domain/models/02_M_schedule_open_house_form_view_model.dart';
export 'features/crm_forms/data/adapters/01_I_schedule_open_house_form_adapter.dart';

// Common Forms
export 'features/common_forms/domain/models/02_M_single_input_form_view_model.dart';
export 'features/common_forms/data/adapters/01_I_single_input_form_adapter.dart';

// HR Forms
export 'features/hr_forms/domain/models/02_M_assign_training_module_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_assign_training_module_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_audit_payroll_discrepancy_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_audit_payroll_discrepancy_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_discipline_log_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_discipline_log_form_adapter.dart';

export 'features/hr_forms/domain/models/02_M_leave_request_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_leave_request_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_log_employee_grievance_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_log_employee_grievance_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_new_employee_onboarding_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_new_employee_onboarding_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_request_shift_adjustment_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_request_shift_adjustment_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_review_onboarding_status_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_review_onboarding_status_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_review_peer_performance_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_review_peer_performance_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_schedule_interview_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_schedule_interview_form_adapter.dart';
export 'features/hr_forms/domain/models/02_M_submit_exit_interview_form_view_model.dart';
export 'features/hr_forms/data/adapters/01_I_submit_exit_interview_form_adapter.dart';

export 'src/utils/01_I_prime_logger.dart';
