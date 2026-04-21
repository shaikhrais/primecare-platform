// Layer: 00_ENTRY_POINT
library;

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_riverpod/legacy.dart';

// Layer: 01_INFRASTRUCTURE
export 'src/infrastructure/01_I_result.dart';
export 'src/infrastructure/01_I_api_client.dart';
export 'src/infrastructure/01_I_telemetry_service.dart';
export 'src/infrastructure/01_I_api_config.dart';
export 'src/infrastructure/01_I_resilience_service.dart';
export 'src/infrastructure/01_I_dashboard_service.dart';
export 'src/infrastructure/01_I_dashboard_providers.dart';
export 'src/infrastructure/01_I_storage_providers.dart';
export 'src/infrastructure/01_I_retry_interceptor.dart';
export 'src/infrastructure/01_I_circuit_breaker.dart';

// Layer: 02_MODELS_FOUNDATION
export 'src/models/02_M_view_model.dart';
export 'src/models/02_M_dashboard_view_model.dart';

// Layer: 03_CORE_DOMAIN_MODELS
export 'src/models/core/02_M_dashboard_models.dart';
export 'src/models/core/02_M_ui_blueprint.dart';
export 'src/models/core/02_M_intelligence_insight.dart';
export 'src/models/core/02_M_scheduler_models.dart';
export 'src/models/core/02_M_data_logistics_hub.dart';
export 'src/models/core/02_M_domain_response.dart';
export 'src/models/corporate/02_M_training_models.dart';

// Layer: 04_ROLE_VIEW_MODELS
export 'src/models/roles/03_V_admin_dashboard_view_model.dart';
export 'src/models/roles/03_V_admin_reconciliation_dashboard_view_model.dart';
export 'src/models/roles/03_V_billing_admin_dashboard_view_model.dart';
export 'src/models/roles/03_V_ceo_dashboard_view_model.dart';
export 'src/models/roles/03_V_cfo_dashboard_view_model.dart';
export 'src/models/roles/03_V_finance_director_dashboard_view_model.dart';
export 'src/models/roles/03_V_client_dashboard_view_model.dart';
export 'src/models/roles/03_V_clinical_lead_dashboard_view_model.dart';
export 'src/models/roles/03_V_clinic_dashboard_view_model.dart';
export 'src/models/roles/03_V_community_outreach_dashboard_view_model.dart';
export 'src/models/roles/03_V_compliance_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_coo_dashboard_view_model.dart';
export 'src/models/roles/03_V_cto_dashboard_view_model.dart';
export 'src/models/roles/03_V_customer_support_dashboard_view_model.dart';
export 'src/models/roles/03_V_demo_dashboard_view_model.dart';
export 'src/models/roles/03_V_family_dashboard_view_model.dart';
export 'src/models/roles/03_V_franchise_dashboard_view_model.dart';
export 'src/models/roles/03_V_franchise_owner_dashboard_view_model.dart';
export 'src/models/roles/03_V_franchise_reconciliation_dashboard_view_model.dart';
export 'src/models/roles/03_V_franchise_refunds_dashboard_view_model.dart';
export 'src/models/roles/03_V_franchise_reports_dashboard_view_model.dart';
export 'src/models/roles/03_V_franchise_sales_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_general_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_guest_dashboard_view_model.dart';
export 'src/models/roles/03_V_head_of_bus_dev_dashboard_view_model.dart';
export 'src/models/roles/03_V_head_of_marketing_dashboard_view_model.dart';
export 'src/models/roles/03_V_hr_hiring_dashboard_view_model.dart';
export 'src/models/roles/03_V_intake_dashboard_view_model.dart';
export 'src/models/roles/03_V_local_marketing_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_operations_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_owner_dashboard_view_model.dart';
export 'src/models/roles/03_V_partnership_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_patient_dashboard_view_model.dart';
export 'src/models/roles/03_V_psw_dashboard_view_model.dart';
export 'src/models/roles/03_V_qa_dashboard_view_model.dart';
export 'src/models/roles/03_V_receptionist_dashboard_view_model.dart';
export 'src/models/roles/03_V_regional_bdm_dashboard_view_model.dart';
export 'src/models/roles/03_V_regional_manager_ontario_dashboard_view_model.dart';
export 'src/models/roles/03_V_regional_manager_usa_dashboard_view_model.dart';
export 'src/models/roles/03_V_rn_dashboard_view_model.dart';
export 'src/models/roles/03_V_scheduler_dashboard_view_model.dart';
export 'src/models/roles/03_V_scrum_master_dashboard_view_model.dart';
export 'src/models/roles/03_V_support_dashboard_view_model.dart';
export 'src/models/roles/03_V_territory_expansion_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_territory_sales_manager_dashboard_view_model.dart';
export 'src/models/roles/03_V_training_coordinator_dashboard_view_model.dart';
export 'src/models/roles/03_V_training_director_dashboard_view_model.dart';
export 'src/models/roles/03_V_training_hub_view_model.dart';
export 'src/models/roles/03_V_course_architect_view_model.dart';
export 'src/models/roles/03_V_system_verification_view_model.dart';

// Layer: 05_UI_ADAPTERS
export 'src/corporate/ceo/adapters/04_A_ceo_dashboard_adapter.dart';
export 'src/corporate/cfo/adapters/04_A_cfo_dashboard_adapter.dart';
export 'src/corporate/finance_director/adapters/04_A_finance_director_dashboard_adapter.dart';
export 'src/corporate/cto/adapters/04_A_cto_dashboard_adapter.dart';
export 'src/corporate/cto/adapters/04_A_architecture_planning_adapter.dart';
export 'src/corporate/cto/adapters/04_A_system_verification_adapter.dart';
export 'src/corporate/coo/adapters/04_A_coo_dashboard_adapter.dart';
export 'src/corporate/compliance_manager/adapters/04_A_compliance_manager_dashboard_adapter.dart';
export 'src/corporate/training_director/adapters/04_A_training_director_dashboard_adapter.dart';
export 'src/corporate/training_director/adapters/04_A_training_director_certificate_adapter.dart';
export 'src/corporate/training_director/adapters/04_A_training_hub_adapter.dart';
export 'src/corporate/training_director/adapters/04_A_course_architect_adapter.dart';
export 'src/corporate/head_of_business_development/adapters/04_A_head_of_bus_dev_dashboard_adapter.dart';
export 'src/corporate/general_manager/adapters/04_A_general_manager_dashboard_adapter.dart';
export 'src/corporate/scrum_master/adapters/04_A_scrum_master_dashboard_adapter.dart';
export 'src/clinical/clinic_manager/adapters/04_A_clinic_dashboard_adapter.dart';
export 'src/clinical/patient/adapters/04_A_patient_dashboard_adapter.dart';
export 'src/client_family/client/adapters/04_A_client_dashboard_adapter.dart';
export 'src/client_family/family_member/adapters/04_A_family_dashboard_adapter.dart';
export 'src/client_family/guest/adapters/04_A_guest_dashboard_adapter.dart';
export 'src/customer_support/customer_support/adapters/04_A_customer_support_dashboard_adapter.dart';
export 'src/customer_support/intake_coordinator/adapters/04_A_intake_dashboard_adapter.dart';
export 'src/customer_support/quality_assurance/adapters/04_A_qa_dashboard_adapter.dart';
export 'src/customer_support/support/adapters/04_A_support_dashboard_adapter.dart';
export 'src/customer_support/training_coordinator/adapters/04_A_training_coordinator_dashboard_adapter.dart';
export 'src/franchise/billing_admin/adapters/04_A_billing_admin_dashboard_adapter.dart';
export 'src/franchise/franchise_owner/adapters/04_A_franchise_owner_adapter.dart';
export 'src/franchise/hr_manager/adapters/04_A_hr_hiring_dashboard_adapter.dart';
export 'src/franchise/operations_manager/adapters/04_A_operations_manager_dashboard_adapter.dart';
export 'src/franchise/owner/adapters/04_A_owner_dashboard_adapter.dart';
export 'src/franchise/scheduler_coordinator/adapters/04_A_scheduler_dashboard_adapter.dart';
export 'src/business_development/franchise_sales_manager/adapters/04_A_franchise_sales_manager_dashboard_adapter.dart';
export 'src/business_development/partnership_manager/adapters/04_A_partnership_manager_dashboard_adapter.dart';
export 'src/business_development/regional_bdm_ontario/adapters/04_A_regional_manager_ontario_dashboard_adapter.dart';
export 'src/business_development/regional_bdm_usa/adapters/04_A_regional_manager_usa_dashboard_adapter.dart';
export 'src/business_development/territory_expansion_manager/adapters/04_A_territory_expansion_manager_dashboard_adapter.dart';
export 'src/marketing/community_outreach/adapters/04_A_community_outreach_dashboard_adapter.dart';
export 'src/marketing/head_of_marketing/adapters/04_A_head_of_marketing_dashboard_adapter.dart';
export 'src/marketing/local_marketing_manager/adapters/04_A_local_marketing_manager_dashboard_adapter.dart';
export 'src/marketing/territory_sales_manager/adapters/04_A_territory_sales_manager_dashboard_adapter.dart';
export 'src/generic/04_A_dynamic_screen_adapter.dart';
export 'src/generic/04_A_dynamic_adapter_provider.dart';

// Unified Form Registry
export 'src/registry/05_G_primecare_form_enum.dart';
export 'src/registry/05_G_primecare_form_provider.dart';
export 'src/utils/05_G_primecare_formatters.dart';
