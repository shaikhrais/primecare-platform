// Layer: 00_ENTRY_POINT
library;

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_riverpod/legacy.dart';

// Layer: 01_INFRASTRUCTURE
export 'old/infrastructure/01_I_result.dart';
export 'old/infrastructure/01_I_api_client.dart';
export 'old/infrastructure/01_I_telemetry_service.dart';
export 'old/infrastructure/01_I_api_config.dart';
export 'old/infrastructure/01_I_resilience_service.dart';
export 'old/infrastructure/01_I_dashboard_service.dart';
export 'old/infrastructure/01_I_dashboard_providers.dart';
export 'old/infrastructure/01_I_legacy_bridge.dart';
export 'old/infrastructure/01_I_storage_providers.dart';
export 'old/infrastructure/01_I_retry_interceptor.dart';
export 'old/infrastructure/01_I_circuit_breaker.dart';
export 'old/infrastructure/01_I_modulation_governance_registry.dart';
export 'old/infrastructure/01_I_adapter_modulation_governor.dart';
export 'old/infrastructure/01_I_governance_policies.dart';

// Layer: 02_MODELS_FOUNDATION
export 'old/models/02_M_view_model.dart';
export 'old/infrastructure/01_I_self_healing_notifier.dart';
export 'old/models/02_M_dashboard_view_model.dart';

// Layer: 03_CORE_DOMAIN_MODELS
export 'old/models/core/01_I_render_config.dart';
export 'old/models/core/02_M_dashboard_models.dart';
export 'old/models/core/02_M_ui_blueprint.dart';
export 'old/models/core/02_M_intelligence_insight.dart';
export 'old/models/core/02_M_scheduler_models.dart';
export 'old/models/core/02_M_data_logistics_hub.dart';
export 'old/models/core/02_M_domain_response.dart';
export 'old/models/corporate/02_M_training_models.dart';

// Layer: 04_ROLE_VIEW_MODELS
export 'old/models/roles/03_V_admin_dashboard_view_model.dart';
export 'old/models/roles/03_V_admin_reconciliation_dashboard_view_model.dart';
export 'old/models/roles/03_V_billing_admin_dashboard_view_model.dart';
export 'old/models/roles/03_V_ceo_dashboard_view_model.dart';
export 'old/models/roles/03_V_cfo_dashboard_view_model.dart';
export 'old/models/roles/03_V_finance_director_dashboard_view_model.dart';
export 'old/models/roles/03_V_client_dashboard_view_model.dart';
export 'old/models/roles/03_V_clinical_lead_dashboard_view_model.dart';
export 'old/models/roles/03_V_clinical_director_dashboard_view_model.dart';
export 'old/models/roles/03_V_clinic_dashboard_view_model.dart';
export 'old/models/roles/03_V_community_outreach_dashboard_view_model.dart';
export 'old/models/roles/03_V_compliance_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_coo_dashboard_view_model.dart';
export 'old/models/roles/03_V_cto_dashboard_view_model.dart';
export 'old/models/roles/03_V_customer_support_dashboard_view_model.dart';
export 'old/models/roles/03_V_demo_dashboard_view_model.dart';
export 'old/models/roles/03_V_family_dashboard_view_model.dart';
export 'old/models/roles/03_V_franchise_dashboard_view_model.dart';
export 'old/models/roles/03_V_franchise_owner_dashboard_view_model.dart';
export 'old/models/roles/03_V_franchise_reconciliation_dashboard_view_model.dart';
export 'old/models/roles/03_V_franchise_refunds_dashboard_view_model.dart';
export 'old/models/roles/03_V_franchise_reports_dashboard_view_model.dart';
export 'old/models/roles/03_V_franchise_sales_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_general_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_guest_dashboard_view_model.dart';
export 'old/models/roles/03_V_head_of_bus_dev_dashboard_view_model.dart';
export 'old/models/roles/03_V_head_of_marketing_dashboard_view_model.dart';
export 'old/models/roles/03_V_hr_hiring_dashboard_view_model.dart';
export 'old/models/roles/03_V_intake_dashboard_view_model.dart';
export 'old/models/roles/03_V_local_marketing_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_operations_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_owner_dashboard_view_model.dart';
export 'old/models/roles/03_V_partnership_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_patient_dashboard_view_model.dart';
export 'old/models/roles/03_V_psw_dashboard_view_model.dart';
export 'old/models/roles/03_V_qa_dashboard_view_model.dart';
export 'old/models/roles/03_V_receptionist_dashboard_view_model.dart';
export 'old/models/roles/03_V_regional_bdm_dashboard_view_model.dart';
export 'old/models/roles/03_V_regional_manager_ontario_dashboard_view_model.dart';
export 'old/models/roles/03_V_regional_manager_usa_dashboard_view_model.dart';
export 'old/models/roles/03_V_rn_dashboard_view_model.dart';
export 'old/models/roles/03_V_scheduler_dashboard_view_model.dart';
export 'old/models/roles/03_V_scrum_master_dashboard_view_model.dart';
export 'old/models/roles/03_V_support_dashboard_view_model.dart';
export 'old/models/roles/03_V_territory_expansion_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_territory_sales_manager_dashboard_view_model.dart';
export 'old/models/roles/03_V_training_coordinator_dashboard_view_model.dart';
export 'old/models/roles/03_V_training_director_dashboard_view_model.dart';
export 'old/models/roles/03_V_training_hub_view_model.dart';
export 'old/models/roles/03_V_training_director_certificate_dashboard_view_model.dart';
export 'old/models/roles/03_V_infection_control_dashboard_view_model.dart';
export 'old/models/roles/03_V_social_worker_dashboard_view_model.dart';
export 'old/models/roles/03_V_course_architect_view_model.dart';
export 'old/models/roles/03_V_system_verification_view_model.dart';
export 'old/models/roles/03_V_hr_director_dashboard_view_model.dart';
export 'old/models/roles/03_V_cx_director_dashboard_view_model.dart';
export 'old/models/roles/03_V_volunteer_coordinator_dashboard_view_model.dart';
export 'old/models/roles/03_V_family_member_dashboard_view_model.dart';
export 'old/models/roles/03_V_architecture_planning_view_model.dart';
export 'old/governance_generated/models/03_V_quality_assurance_dashboard_view_model.dart';
export 'old/governance_generated/models/03_V_intake_coordinator_dashboard_view_model.dart';
export 'old/models/roles/03_V_it_security_dashboard_view_model.dart';
export 'old/governance_generated/models/03_V_rmt_dashboard_view_model.dart';

// Layer: 05_UI_ADAPTERS
export 'old/corporate/ceo/adapters/04_A_ceo_dashboard_adapter.dart';
export 'old/corporate/cfo/adapters/04_A_cfo_dashboard_adapter.dart';
export 'old/corporate/finance_director/adapters/04_A_finance_director_dashboard_adapter.dart';
export 'old/corporate/cto/adapters/04_A_cto_dashboard_adapter.dart';
export 'old/corporate/cto/adapters/04_A_architecture_planning_adapter.dart';
export 'old/corporate/cto/adapters/04_A_system_verification_adapter.dart';
export 'old/corporate/coo/adapters/04_A_coo_dashboard_adapter.dart';
export 'old/corporate/compliance_manager/adapters/04_A_compliance_manager_dashboard_adapter.dart';
export 'old/corporate/training_director/adapters/04_A_training_director_dashboard_adapter.dart';
export 'old/corporate/training_director/adapters/04_A_training_director_certificate_adapter.dart';
export 'old/corporate/training_director/adapters/04_A_training_hub_adapter.dart';
export 'old/corporate/training_director/adapters/04_A_course_architect_adapter.dart';
export 'old/corporate/head_of_business_development/adapters/04_A_head_of_bus_dev_dashboard_adapter.dart';
export 'old/corporate/general_manager/adapters/04_A_general_manager_dashboard_adapter.dart';
export 'old/corporate/scrum_master/adapters/04_A_scrum_master_dashboard_adapter.dart';
export 'old/corporate/hr_director/adapters/04_A_hr_director_dashboard_adapter.dart';
export 'old/corporate/cx_director/adapters/04_A_cx_director_dashboard_adapter.dart';
export 'old/corporate/volunteer_coordinator/adapters/04_A_volunteer_coordinator_dashboard_adapter.dart';
export 'old/clinical/clinic_manager/adapters/04_A_clinic_dashboard_adapter.dart';
export 'old/clinical/clinical_director/adapters/04_A_clinical_director_dashboard_adapter.dart';
export 'old/clinical/patient/adapters/04_A_patient_dashboard_adapter.dart';
export 'old/clinical/social_worker/adapters/04_A_social_worker_dashboard_adapter.dart';
export 'old/clinical/infection_control/adapters/04_A_infection_control_dashboard_adapter.dart';
export 'old/clinical/intake_coordinator/adapters/04_A_intake_coordinator_dashboard_adapter.dart';
export 'old/client_family/client/adapters/04_A_client_dashboard_adapter.dart';
export 'old/client_family/family_member/adapters/04_A_family_dashboard_adapter.dart';
export 'old/client_family/family_member/adapters/04_A_family_member_dashboard_adapter.dart';
export 'old/client_family/guest/adapters/04_A_guest_dashboard_adapter.dart';
export 'old/customer_support/customer_support/adapters/04_A_customer_support_dashboard_adapter.dart';
export 'old/customer_support/intake_coordinator/adapters/04_A_intake_dashboard_adapter.dart';
export 'old/customer_support/quality_assurance/adapters/04_A_qa_dashboard_adapter.dart';
export 'old/customer_support/support/adapters/04_A_support_dashboard_adapter.dart';
export 'old/customer_support/training_coordinator/adapters/04_A_training_coordinator_dashboard_adapter.dart';
export 'old/franchise/billing_admin/adapters/04_A_billing_admin_dashboard_adapter.dart';
export 'old/franchise/franchise_owner/adapters/04_A_franchise_owner_adapter.dart';
export 'old/franchise/hr_manager/adapters/04_A_hr_hiring_dashboard_adapter.dart';
export 'old/franchise/operations_manager/adapters/04_A_operations_manager_dashboard_adapter.dart';
export 'old/franchise/owner/adapters/04_A_owner_dashboard_adapter.dart';
export 'old/franchise/scheduler_coordinator/adapters/04_A_scheduler_dashboard_adapter.dart';
export 'old/business_development/franchise_sales_manager/adapters/04_A_franchise_sales_manager_dashboard_adapter.dart';
export 'old/business_development/partnership_manager/adapters/04_A_partnership_manager_dashboard_adapter.dart';
export 'old/business_development/regional_bdm/adapters/04_A_regional_bdm_dashboard_adapter.dart';
export 'old/business_development/regional_bdm_ontario/adapters/04_A_regional_manager_ontario_dashboard_adapter.dart';
export 'old/business_development/regional_bdm_usa/adapters/04_A_regional_manager_usa_dashboard_adapter.dart';
export 'old/business_development/territory_expansion_manager/adapters/04_A_territory_expansion_manager_dashboard_adapter.dart';
export 'old/marketing/community_outreach/adapters/04_A_community_outreach_dashboard_adapter.dart';
export 'old/marketing/head_of_marketing/adapters/04_A_head_of_marketing_dashboard_adapter.dart';
export 'old/marketing/local_marketing_manager/adapters/04_A_local_marketing_manager_dashboard_adapter.dart';
export 'old/marketing/territory_sales_manager/adapters/04_A_territory_sales_manager_dashboard_adapter.dart';
export 'old/generic/04_A_dynamic_screen_adapter.dart';
export 'old/generic/04_A_dynamic_adapter_provider.dart';
export 'old/governance/corporate_governance/adapters/04_A_corporate_governance_dashboard_adapter.dart';
export 'old/infrastructure/it_security/adapters/04_A_it_security_dashboard_adapter.dart';
export 'old/clinical/rn/adapters/04_A_rn_dashboard_adapter.dart';
export 'old/clinical/rmt/adapters/04_A_rmt_dashboard_adapter.dart';
export 'old/clinical/psw/adapters/04_A_psw_dashboard_adapter.dart';
export 'old/customer_support/receptionist/adapters/04_A_receptionist_dashboard_adapter.dart';
export 'old/governance/quality_assurance/adapters/04_A_quality_assurance_dashboard_adapter.dart';
export 'old/governance_generated/adapters/04_A_clinical_director_dashboard_adapter.dart';
export 'old/corporate/shareholder/adapters/04_A_shareholder_intelligence_adapter.dart';

// Unified Form Registry
export 'old/registry/05_G_primecare_form_enum.dart';
export 'old/registry/05_G_primecare_form_provider.dart';
export 'old/utils/05_G_primecare_formatters.dart';
export 'old/config/00_I_locale_keys.dart';

// Legacy Registry

// Layer: 06_NEW_FRAMEWORK
export 'src/core/models.dart';
export 'src/core/registry.dart';
