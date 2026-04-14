// Master export file for flutter_core.

export 'adapters/primecare_form_provider.dart';
export 'adapter_providers.dart';
export 'api_providers.dart';
export 'auth_service.dart';
export 'dashboard_providers.dart';
export 'dashboard_service.dart';
export 'domain_service.dart';
export 'dynamic_page_providers.dart';
export 'preference_service.dart';
export 'provider_service.dart';
export 'telemetry_service.dart';
export 'src/services/resilience_service.dart';
export 'src/resilience/app_error_boundary.dart';
export 'network/circuit_breaker.dart';
export 'network/retry_interceptor.dart';
export 'src/resilience/connectivity_service.dart';
export 'src/resilience/provider_ttl.dart';

export 'providers/portal_providers.dart';
export 'config/api_config.dart';
export 'config/data_source_mode.dart';
export 'config/feature_flags.dart';
export 'config/screen_registry.dart';
export 'config/screen_breakpoints.dart';
export 'config/adaptive_scaling_config.dart';
export 'config/navigation_registry.dart';
export 'models/navigation_item.dart';

export 'manifest/action_manifest.dart';
export 'network/api_client.dart';
export 'network/api_error.dart';
export 'network/result.dart';
export 'network/error_mapper.dart';
export 'registry/file_registry.dart';
export 'registry/screen_data_registry.dart';
export 'routes/groups/admin_routes.dart';
export 'routes/groups/business_development_routes.dart';
export 'routes/groups/client_routes.dart';
export 'routes/groups/clinical_routes.dart';
export 'routes/groups/corporate_routes.dart';
export 'routes/groups/franchise_routes.dart';
export 'routes/groups/marketing_routes.dart';
export 'routes/groups/support_routes.dart';
export 'routes/groups/common_routes.dart';
export 'theme/app_theme.dart';

export 'features/franchise_owner_dashboard/domain/models/franchise_owner_view_model.dart';

// Auto-scaled adapters
export 'features/franchise_sales_manager_dashboard/domain/models/franchise_sales_manager_dashboard_view_model.dart';
export 'features/general_manager_dashboard/domain/models/general_manager_dashboard_view_model.dart';
export 'features/partnership_manager_dashboard/domain/models/partnership_manager_dashboard_view_model.dart';
export 'features/regional_manager_ontario_dashboard/domain/models/regional_manager_ontario_dashboard_view_model.dart';
export 'features/regional_manager_usa_dashboard/domain/models/regional_manager_usa_dashboard_view_model.dart';
export 'features/territory_expansion_manager_dashboard/domain/models/territory_expansion_manager_dashboard_view_model.dart';
export 'features/client_dashboard/domain/models/client_dashboard_view_model.dart';
export 'features/family_dashboard/domain/models/family_dashboard_view_model.dart';
export 'features/billing_admin_dashboard/domain/models/billing_admin_dashboard_view_model.dart';
export 'features/ceo_dashboard/domain/models/ceo_dashboard_view_model.dart';
export 'features/clinic_dashboard/domain/models/clinic_dashboard_view_model.dart';
export 'features/compliance_manager_dashboard/domain/models/compliance_manager_dashboard_view_model.dart';
export 'features/customer_support_dashboard/domain/models/customer_support_dashboard_view_model.dart';
export 'features/head_of_bus_dev_dashboard/domain/models/head_of_bus_dev_dashboard_view_model.dart';
export 'features/cfo_dashboard/domain/models/cfo_dashboard_view_model.dart';
export 'features/coo_dashboard/domain/models/coo_dashboard_view_model.dart';
export 'features/cto_dashboard/domain/models/cto_dashboard_view_model.dart';
export 'features/training_director_dashboard/domain/models/training_director_dashboard_view_model.dart';
export 'features/hr_hiring_dashboard/domain/models/hr_hiring_dashboard_view_model.dart';
export 'features/operations_manager_dashboard/domain/models/operations_manager_dashboard_view_model.dart';
export 'features/owner_dashboard/domain/models/owner_dashboard_view_model.dart';
export 'features/scheduler_dashboard/domain/models/scheduler_dashboard_view_model.dart';
export 'features/community_outreach_dashboard/domain/models/community_outreach_dashboard_view_model.dart';
export 'features/head_of_marketing_dashboard/domain/models/head_of_marketing_dashboard_view_model.dart';
export 'features/local_marketing_manager_dashboard/domain/models/local_marketing_manager_dashboard_view_model.dart';
export 'features/territory_sales_manager_dashboard/domain/models/territory_sales_manager_dashboard_view_model.dart';
export 'features/qa_dashboard/domain/models/qa_dashboard_view_model.dart';
export 'features/intake_dashboard/domain/models/intake_dashboard_view_model.dart';
export 'features/support_dashboard/domain/models/support_dashboard_view_model.dart';
export 'features/training_coordinator_dashboard/domain/models/training_coordinator_dashboard_view_model.dart';
export 'features/franchise_refunds_dashboard/domain/models/franchise_refunds_dashboard_view_model.dart';
export 'features/franchise_reports_dashboard/domain/models/franchise_reports_dashboard_view_model.dart';
export 'features/admin_reconciliation_dashboard/domain/models/admin_reconciliation_dashboard_view_model.dart';
export 'features/franchise_reconciliation_dashboard/domain/models/franchise_reconciliation_dashboard_view_model.dart';

// Office: system
export 'features/guest_dashboard/domain/models/guest_dashboard_view_model.dart';
export 'features/scrum_master_dashboard/domain/models/scrum_master_dashboard_view_model.dart';

// Office: patient
export 'features/patient_dashboard/domain/models/patient_dashboard_view_model.dart';
export 'features/regional_bdm_dashboard/domain/models/regional_bdm_dashboard_view_model.dart';
export 'features/franchise_dashboard/domain/models/franchise_dashboard_view_model.dart';

export 'report_service.dart';
export 'report_providers.dart';
export 'intelligence_service.dart';
export 'intelligence_providers.dart';
export 'aura_command_service.dart';
export 'aura_pulse_service.dart';
export 'aura_providers.dart';

// Institutional Scheduler
export 'src/models/scheduler_models.dart';
export 'src/services/scheduler_service.dart';
export 'scheduler_providers.dart';
export 'src/models/aura_intent.dart';
export 'src/models/aura_event.dart';
export 'src/models/intelligence_insight.dart';
export 'src/factory_floor/data_logistics_hub.dart';
export 'src/factory_floor/data_fallback_engine.dart';

// Administrative Forms
export 'features/administrative_forms/domain/models/approve_leave_request_form_view_model.dart';
export 'features/administrative_forms/data/adapters/approve_leave_request_form_adapter.dart';
export 'features/administrative_forms/domain/models/approve_expense_reimbursement_form_view_model.dart';
export 'features/administrative_forms/data/adapters/approve_expense_reimbursement_form_adapter.dart';
export 'features/administrative_forms/domain/models/approve_payroll_run_form_view_model.dart';
export 'features/administrative_forms/data/adapters/approve_payroll_run_form_adapter.dart';

// Clinical Forms
export 'features/clinical_forms/domain/models/patient_intake_form_view_model.dart';
export 'features/clinical_forms/data/adapters/patient_intake_form_adapter.dart';
export 'features/clinical_forms/domain/models/daily_vitals_card_form_view_model.dart';
export 'features/clinical_forms/data/adapters/daily_vitals_card_form_adapter.dart';
export 'features/clinical_forms/domain/models/approve_medication_refill_form_view_model.dart';
export 'features/clinical_forms/data/adapters/approve_medication_refill_form_adapter.dart';

// CRM Forms
export 'features/crm_forms/domain/models/add_franchise_lead_form_view_model.dart';
export 'features/crm_forms/data/adapters/add_franchise_lead_form_adapter.dart';
export 'features/crm_forms/domain/models/assign_lead_form_view_model.dart';
export 'features/crm_forms/data/adapters/assign_lead_form_adapter.dart';
export 'features/crm_forms/domain/models/submit_marketing_budget_form_view_model.dart';
export 'features/crm_forms/data/adapters/submit_marketing_budget_form_adapter.dart';
export 'features/crm_forms/domain/models/approve_franchise_disclosure_form_view_model.dart';
export 'features/crm_forms/data/adapters/approve_franchise_disclosure_form_adapter.dart';
export 'features/crm_forms/domain/models/create_ad_placement_form_view_model.dart';
export 'features/crm_forms/data/adapters/create_ad_placement_form_adapter.dart';
export 'features/crm_forms/domain/models/franchise_onboarding_checklist_form_view_model.dart';
export 'features/crm_forms/data/adapters/franchise_onboarding_checklist_form_adapter.dart';
export 'features/crm_forms/domain/models/log_franchisee_vetting_call_form_view_model.dart';
export 'features/crm_forms/data/adapters/log_franchisee_vetting_call_form_adapter.dart';
export 'features/crm_forms/domain/models/nurture_localized_lead_form_view_model.dart';
export 'features/crm_forms/data/adapters/nurture_localized_lead_form_adapter.dart';
export 'features/crm_forms/domain/models/review_lead_conversion_form_view_model.dart';
export 'features/crm_forms/data/adapters/review_lead_conversion_form_adapter.dart';
export 'features/crm_forms/domain/models/review_market_share_form_view_model.dart';
export 'features/crm_forms/data/adapters/review_market_share_form_adapter.dart';
export 'features/crm_forms/domain/models/schedule_open_house_form_view_model.dart';
export 'features/crm_forms/data/adapters/schedule_open_house_form_adapter.dart';

// Common Forms
export 'features/common_forms/domain/models/single_input_form_view_model.dart';
export 'features/common_forms/data/adapters/single_input_form_adapter.dart';

// HR Forms
export 'features/hr_forms/domain/models/assign_training_module_form_view_model.dart';
export 'features/hr_forms/data/adapters/assign_training_module_form_adapter.dart';
export 'features/hr_forms/domain/models/audit_payroll_discrepancy_form_view_model.dart';
export 'features/hr_forms/data/adapters/audit_payroll_discrepancy_form_adapter.dart';
export 'features/hr_forms/domain/models/discipline_log_form_view_model.dart';
export 'features/hr_forms/data/adapters/discipline_log_form_adapter.dart';

export 'features/hr_forms/domain/models/leave_request_form_view_model.dart';
export 'features/hr_forms/data/adapters/leave_request_form_adapter.dart';
export 'features/hr_forms/domain/models/log_employee_grievance_form_view_model.dart';
export 'features/hr_forms/data/adapters/log_employee_grievance_form_adapter.dart';
export 'features/hr_forms/domain/models/new_employee_onboarding_form_view_model.dart';
export 'features/hr_forms/data/adapters/new_employee_onboarding_form_adapter.dart';
export 'features/hr_forms/domain/models/request_shift_adjustment_form_view_model.dart';
export 'features/hr_forms/data/adapters/request_shift_adjustment_form_adapter.dart';
export 'features/hr_forms/domain/models/review_onboarding_status_form_view_model.dart';
export 'features/hr_forms/data/adapters/review_onboarding_status_form_adapter.dart';
export 'features/hr_forms/domain/models/review_peer_performance_form_view_model.dart';
export 'features/hr_forms/data/adapters/review_peer_performance_form_adapter.dart';
export 'features/hr_forms/domain/models/schedule_interview_form_view_model.dart';
export 'features/hr_forms/data/adapters/schedule_interview_form_adapter.dart';
export 'features/hr_forms/domain/models/submit_exit_interview_form_view_model.dart';
export 'features/hr_forms/data/adapters/submit_exit_interview_form_adapter.dart';
