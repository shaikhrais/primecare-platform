/// PrimeCare Adapters Package
/// Core layer handling role-based, decoupled data bindings across 7 operational offices.
library;

// -------------------------------------------------------------
// DATA LOGISTICS HUB & FALLBACK ENGINE
// -------------------------------------------------------------
// Data Logistics Hub is now centrally located in primecare_core

// -------------------------------------------------------------
// HYDRATED UI DATA BOUND ADAPTERS
// Automatically segmented by Office/Department Architecture
// -------------------------------------------------------------

// --- Office: BUSINESS_DEVELOPMENT ---
export 'src/business_development/franchise_sales_manager/adapters/franchise_sales_manager_dashboard_adapter.dart';
export 'src/business_development/partnership_manager/adapters/partnership_manager_dashboard_adapter.dart';
export 'src/business_development/regional_bdm_ontario/adapters/regional_manager_ontario_dashboard_adapter.dart';
export 'src/business_development/regional_bdm_usa/adapters/regional_manager_usa_dashboard_adapter.dart';
export 'src/business_development/territory_expansion_manager/adapters/territory_expansion_manager_dashboard_adapter.dart';

// --- Office: CLIENT_FAMILY ---
export 'src/client_family/client/adapters/client_dashboard_adapter.dart';
export 'src/client_family/family_member/adapters/family_dashboard_adapter.dart';
export 'src/client_family/guest/adapters/guest_dashboard_adapter.dart';

// --- Office: CLINICAL ---
export 'src/clinical/clinic_manager/adapters/clinic_dashboard_adapter.dart';
export 'src/clinical/patient/adapters/patient_dashboard_adapter.dart';

// --- Office: CORPORATE ---
export 'src/corporate/ceo/adapters/ceo_dashboard_adapter.dart';
export 'src/corporate/cfo/adapters/cfo_dashboard_adapter.dart';
export 'src/corporate/compliance_manager/adapters/compliance_manager_dashboard_adapter.dart';
export 'src/corporate/coo/adapters/coo_dashboard_adapter.dart';
export 'src/corporate/cto/adapters/cto_dashboard_adapter.dart';
export 'src/corporate/cto/adapters/system_verification_adapter.dart';
export 'src/corporate/cto/adapters/architecture_planning_adapter.dart';
export 'src/corporate/general_manager/adapters/general_manager_dashboard_adapter.dart';
export 'src/corporate/head_of_business_development/adapters/head_of_bus_dev_dashboard_adapter.dart';
export 'src/corporate/scrum_master/adapters/scrum_master_dashboard_adapter.dart';
export 'src/corporate/training_director/adapters/training_director_dashboard_adapter.dart';

// --- Office: CUSTOMER_SUPPORT ---
export 'src/customer_support/customer_support/adapters/customer_support_dashboard_adapter.dart';
export 'src/customer_support/intake_coordinator/adapters/intake_dashboard_adapter.dart';
export 'src/customer_support/quality_assurance/adapters/qa_dashboard_adapter.dart';
export 'src/customer_support/support/adapters/support_dashboard_adapter.dart';
export 'src/customer_support/training_coordinator/adapters/training_coordinator_dashboard_adapter.dart';

// --- Office: FRANCHISE ---
export 'src/franchise/billing_admin/adapters/billing_admin_dashboard_adapter.dart';
export 'src/franchise/franchise_owner/adapters/franchise_owner_adapter.dart';
export 'src/franchise/hr_manager/adapters/hr_hiring_dashboard_adapter.dart';
export 'src/franchise/operations_manager/adapters/operations_manager_dashboard_adapter.dart';
export 'src/franchise/owner/adapters/owner_dashboard_adapter.dart';
export 'src/franchise/scheduler_coordinator/adapters/scheduler_dashboard_adapter.dart';

// --- Office: MARKETING ---
export 'src/marketing/community_outreach/adapters/community_outreach_dashboard_adapter.dart';
export 'src/marketing/head_of_marketing/adapters/head_of_marketing_dashboard_adapter.dart';
export 'src/marketing/local_marketing_manager/adapters/local_marketing_manager_dashboard_adapter.dart';
export 'src/marketing/territory_sales_manager/adapters/territory_sales_manager_dashboard_adapter.dart';
