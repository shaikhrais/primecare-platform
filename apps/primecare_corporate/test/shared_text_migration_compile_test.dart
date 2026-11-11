// Compile smoke coverage for migrated shared controls.
// Compilation does not establish screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_corporate/features/busdev/screens/head_of_bus_dev_dashboard_screen.dart' as migrated0;
import 'package:primecare_corporate/features/ceo/screens/ceo_alerts_and_risks_screen.dart' as migrated1;
import 'package:primecare_corporate/features/ceo/screens/ceo_approvals_screen.dart' as migrated2;
import 'package:primecare_corporate/features/ceo/screens/ceo_dashboard_screen.dart' as migrated3;
import 'package:primecare_corporate/features/ceo/screens/ceo_enterprise_overview_screen.dart' as migrated4;
import 'package:primecare_corporate/features/ceo/screens/ceo_franchise_overview_screen.dart' as migrated5;
import 'package:primecare_corporate/features/ceo/screens/ceo_growth_pipeline_screen.dart' as migrated6;
import 'package:primecare_corporate/features/ceo/screens/ceo_leadership_reports_screen.dart' as migrated7;
import 'package:primecare_corporate/features/ceo/screens/ceo_organization_map_screen.dart' as migrated8;
import 'package:primecare_corporate/features/ceo/screens/ceo_region_performance_screen.dart' as migrated9;
import 'package:primecare_corporate/features/ceo/screens/ceo_reports_screen.dart' as migrated10;
import 'package:primecare_corporate/features/ceo/screens/ceo_revenue_summary_screen.dart' as migrated11;
import 'package:primecare_corporate/features/ceo/screens/ceo_strategic_kpis_screen.dart' as migrated12;
import 'package:primecare_corporate/features/cfo/screens/cfo_accounts_payable_screen.dart' as migrated13;
import 'package:primecare_corporate/features/cfo/screens/cfo_accounts_receivable_screen.dart' as migrated14;
import 'package:primecare_corporate/features/cfo/screens/cfo_dashboard_screen.dart' as migrated15;
import 'package:primecare_corporate/features/cfo/screens/cfo_expenses_screen.dart' as migrated16;
import 'package:primecare_corporate/features/cfo/screens/cfo_financial_overview_screen.dart' as migrated17;
import 'package:primecare_corporate/features/cfo/screens/cfo_franchise_financials_screen.dart' as migrated18;
import 'package:primecare_corporate/features/cfo/screens/cfo_invoices_screen.dart' as migrated19;
import 'package:primecare_corporate/features/cfo/screens/cfo_payroll_screen.dart' as migrated20;
import 'package:primecare_corporate/features/cfo/screens/cfo_profitability_screen.dart' as migrated21;
import 'package:primecare_corporate/features/cfo/screens/cfo_reports_screen.dart' as migrated22;
import 'package:primecare_corporate/features/cfo/screens/cfo_revenue_screen.dart' as migrated23;
import 'package:primecare_corporate/features/cfo/screens/cfo_tax_and_remittance_screen.dart' as migrated24;
import 'package:primecare_corporate/features/ciso/screens/ciso_dashboard_screen.dart' as migrated25;
import 'package:primecare_corporate/features/compliance/screens/audits/sections/audits_action_bar_section.dart' as migrated26;
import 'package:primecare_corporate/features/compliance/screens/audits/sections/audits_content_summary_section.dart' as migrated27;
import 'package:primecare_corporate/features/compliance/screens/audits/sections/audits_header_section.dart' as migrated28;
import 'package:primecare_corporate/features/compliance/screens/audits/sections/audits_primary_content_section.dart' as migrated29;
import 'package:primecare_corporate/features/compliance/screens/audits_screen.dart' as migrated30;
import 'package:primecare_corporate/features/compliance/screens/compliance_cases/sections/compliance_cases_action_bar_section.dart' as migrated31;
import 'package:primecare_corporate/features/compliance/screens/compliance_cases/sections/compliance_cases_content_summary_section.dart' as migrated32;
import 'package:primecare_corporate/features/compliance/screens/compliance_cases/sections/compliance_cases_header_section.dart' as migrated33;
import 'package:primecare_corporate/features/compliance/screens/compliance_cases/sections/compliance_cases_primary_content_section.dart' as migrated34;
import 'package:primecare_corporate/features/compliance/screens/compliance_cases_screen.dart' as migrated35;
import 'package:primecare_corporate/features/compliance/screens/compliance_manager_dashboard_screen.dart' as migrated36;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports/sections/compliance_reports_chart_area_section.dart' as migrated37;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports/sections/compliance_reports_export_actions_section.dart' as migrated38;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports/sections/compliance_reports_filter_bar_section.dart' as migrated39;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports/sections/compliance_reports_header_section.dart' as migrated40;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports/sections/compliance_reports_metrics_summary_section.dart' as migrated41;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports_screen.dart' as migrated42;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions/sections/corrective_actions_action_bar_section.dart' as migrated43;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions/sections/corrective_actions_header_section.dart' as migrated44;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions/sections/corrective_actions_task_details_section.dart' as migrated45;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions/sections/corrective_actions_task_filters_section.dart' as migrated46;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions/sections/corrective_actions_task_list_section.dart' as migrated47;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions_screen.dart' as migrated48;
import 'package:primecare_corporate/features/compliance/screens/credential_tracking/sections/credential_tracking_action_bar_section.dart' as migrated49;
import 'package:primecare_corporate/features/compliance/screens/credential_tracking/sections/credential_tracking_content_summary_section.dart' as migrated50;
import 'package:primecare_corporate/features/compliance/screens/credential_tracking/sections/credential_tracking_header_section.dart' as migrated51;
import 'package:primecare_corporate/features/compliance/screens/credential_tracking/sections/credential_tracking_primary_content_section.dart' as migrated52;
import 'package:primecare_corporate/features/compliance/screens/credential_tracking_screen.dart' as migrated53;
import 'package:primecare_corporate/features/compliance/screens/document_expiry/sections/document_expiry_action_bar_section.dart' as migrated54;
import 'package:primecare_corporate/features/compliance/screens/document_expiry/sections/document_expiry_content_summary_section.dart' as migrated55;
import 'package:primecare_corporate/features/compliance/screens/document_expiry/sections/document_expiry_header_section.dart' as migrated56;
import 'package:primecare_corporate/features/compliance/screens/document_expiry/sections/document_expiry_primary_content_section.dart' as migrated57;
import 'package:primecare_corporate/features/compliance/screens/document_expiry_screen.dart' as migrated58;
import 'package:primecare_corporate/features/compliance/screens/incident_review_screen.dart' as migrated59;
import 'package:primecare_corporate/features/compliance/screens/policies/sections/policies_action_bar_section.dart' as migrated60;
import 'package:primecare_corporate/features/compliance/screens/policies/sections/policies_content_summary_section.dart' as migrated61;
import 'package:primecare_corporate/features/compliance/screens/policies/sections/policies_header_section.dart' as migrated62;
import 'package:primecare_corporate/features/compliance/screens/policies/sections/policies_primary_content_section.dart' as migrated63;
import 'package:primecare_corporate/features/compliance/screens/policies_screen.dart' as migrated64;
import 'package:primecare_corporate/features/compliance/screens/risk_register/sections/risk_register_action_bar_section.dart' as migrated65;
import 'package:primecare_corporate/features/compliance/screens/risk_register/sections/risk_register_content_summary_section.dart' as migrated66;
import 'package:primecare_corporate/features/compliance/screens/risk_register/sections/risk_register_header_section.dart' as migrated67;
import 'package:primecare_corporate/features/compliance/screens/risk_register/sections/risk_register_primary_content_section.dart' as migrated68;
import 'package:primecare_corporate/features/compliance/screens/risk_register_screen.dart' as migrated69;
import 'package:primecare_corporate/features/compliance/screens/sections/audits_action_bar_section.dart' as migrated70;
import 'package:primecare_corporate/features/compliance/screens/sections/audits_content_summary_section.dart' as migrated71;
import 'package:primecare_corporate/features/compliance/screens/sections/audits_header_section.dart' as migrated72;
import 'package:primecare_corporate/features/compliance/screens/sections/audits_primary_content_section.dart' as migrated73;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_cases_action_bar_section.dart' as migrated74;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_cases_content_summary_section.dart' as migrated75;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_cases_header_section.dart' as migrated76;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_cases_primary_content_section.dart' as migrated77;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_reports_chart_area_section.dart' as migrated78;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_reports_export_actions_section.dart' as migrated79;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_reports_filter_bar_section.dart' as migrated80;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_reports_header_section.dart' as migrated81;
import 'package:primecare_corporate/features/compliance/screens/sections/compliance_reports_metrics_summary_section.dart' as migrated82;
import 'package:primecare_corporate/features/compliance/screens/sections/corrective_actions_action_bar_section.dart' as migrated83;
import 'package:primecare_corporate/features/compliance/screens/sections/corrective_actions_header_section.dart' as migrated84;
import 'package:primecare_corporate/features/compliance/screens/sections/corrective_actions_task_details_section.dart' as migrated85;
import 'package:primecare_corporate/features/compliance/screens/sections/corrective_actions_task_filters_section.dart' as migrated86;
import 'package:primecare_corporate/features/compliance/screens/sections/corrective_actions_task_list_section.dart' as migrated87;
import 'package:primecare_corporate/features/compliance/screens/sections/credential_tracking_action_bar_section.dart' as migrated88;
import 'package:primecare_corporate/features/compliance/screens/sections/credential_tracking_content_summary_section.dart' as migrated89;
import 'package:primecare_corporate/features/compliance/screens/sections/credential_tracking_header_section.dart' as migrated90;
import 'package:primecare_corporate/features/compliance/screens/sections/credential_tracking_primary_content_section.dart' as migrated91;
import 'package:primecare_corporate/features/compliance/screens/sections/document_expiry_action_bar_section.dart' as migrated92;
import 'package:primecare_corporate/features/compliance/screens/sections/document_expiry_content_summary_section.dart' as migrated93;
import 'package:primecare_corporate/features/compliance/screens/sections/document_expiry_header_section.dart' as migrated94;
import 'package:primecare_corporate/features/compliance/screens/sections/document_expiry_primary_content_section.dart' as migrated95;
import 'package:primecare_corporate/features/compliance/screens/sections/policies_action_bar_section.dart' as migrated96;
import 'package:primecare_corporate/features/compliance/screens/sections/policies_content_summary_section.dart' as migrated97;
import 'package:primecare_corporate/features/compliance/screens/sections/policies_header_section.dart' as migrated98;
import 'package:primecare_corporate/features/compliance/screens/sections/policies_primary_content_section.dart' as migrated99;
import 'package:primecare_corporate/features/compliance/screens/sections/risk_register_action_bar_section.dart' as migrated100;
import 'package:primecare_corporate/features/compliance/screens/sections/risk_register_content_summary_section.dart' as migrated101;
import 'package:primecare_corporate/features/compliance/screens/sections/risk_register_header_section.dart' as migrated102;
import 'package:primecare_corporate/features/compliance/screens/sections/risk_register_primary_content_section.dart' as migrated103;
import 'package:primecare_corporate/features/compliance/screens/sections/training_compliance_action_bar_section.dart' as migrated104;
import 'package:primecare_corporate/features/compliance/screens/sections/training_compliance_content_summary_section.dart' as migrated105;
import 'package:primecare_corporate/features/compliance/screens/sections/training_compliance_header_section.dart' as migrated106;
import 'package:primecare_corporate/features/compliance/screens/sections/training_compliance_primary_content_section.dart' as migrated107;
import 'package:primecare_corporate/features/compliance/screens/training_compliance/sections/training_compliance_action_bar_section.dart' as migrated108;
import 'package:primecare_corporate/features/compliance/screens/training_compliance/sections/training_compliance_content_summary_section.dart' as migrated109;
import 'package:primecare_corporate/features/compliance/screens/training_compliance/sections/training_compliance_header_section.dart' as migrated110;
import 'package:primecare_corporate/features/compliance/screens/training_compliance/sections/training_compliance_primary_content_section.dart' as migrated111;
import 'package:primecare_corporate/features/compliance/screens/training_compliance_screen.dart' as migrated112;
import 'package:primecare_corporate/features/coo/screens/coo_branch_comparison_screen.dart' as migrated113;
import 'package:primecare_corporate/features/coo/screens/coo_branch_operations_screen.dart' as migrated114;
import 'package:primecare_corporate/features/coo/screens/coo_compliance_view_screen.dart' as migrated115;
import 'package:primecare_corporate/features/coo/screens/coo_dashboard_screen.dart' as migrated116;
import 'package:primecare_corporate/features/coo/screens/coo_issue_escalations_screen.dart' as migrated117;
import 'package:primecare_corporate/features/coo/screens/coo_operations_overview_screen.dart' as migrated118;
import 'package:primecare_corporate/features/coo/screens/coo_reports_screen.dart' as migrated119;
import 'package:primecare_corporate/features/coo/screens/coo_scheduling_health_screen.dart' as migrated120;
import 'package:primecare_corporate/features/coo/screens/coo_service_delivery_screen.dart' as migrated121;
import 'package:primecare_corporate/features/coo/screens/coo_staffing_efficiency_screen.dart' as migrated122;
import 'package:primecare_corporate/features/coo/screens/coo_workflow_performance_screen.dart' as migrated123;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_alerts_and_risks_screen.dart' as migrated124;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_approvals_screen.dart' as migrated125;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_enterprise_overview_screen.dart' as migrated126;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_franchise_overview_screen.dart' as migrated127;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_growth_pipeline_screen.dart' as migrated128;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_leadership_reports_screen.dart' as migrated129;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_organization_map_screen.dart' as migrated130;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_region_performance_screen.dart' as migrated131;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_reports_screen.dart' as migrated132;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_revenue_summary_screen.dart' as migrated133;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ceo_strategic_kpis_screen.dart' as migrated134;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_accounts_payable_screen.dart' as migrated135;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_accounts_receivable_screen.dart' as migrated136;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_dashboard_screen.dart' as migrated137;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_expenses_screen.dart' as migrated138;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_financial_overview_screen.dart' as migrated139;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_franchise_financials_screen.dart' as migrated140;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_invoices_screen.dart' as migrated141;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_payroll_screen.dart' as migrated142;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_profitability_screen.dart' as migrated143;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_reports_screen.dart' as migrated144;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_revenue_screen.dart' as migrated145;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cfo_tax_and_remittance_screen.dart' as migrated146;
import 'package:primecare_corporate/features/corporate/presentation/widgets/ciso_dashboard_screen.dart' as migrated147;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_audits_screen.dart' as migrated148;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_compliance_cases_screen.dart' as migrated149;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_corrective_actions_screen.dart' as migrated150;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_credential_tracking_screen.dart' as migrated151;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_dashboard_screen.dart' as migrated152;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_document_expiry_screen.dart' as migrated153;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_incident_review_screen.dart' as migrated154;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_policies_screen.dart' as migrated155;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_reports_screen.dart' as migrated156;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_risk_register_screen.dart' as migrated157;
import 'package:primecare_corporate/features/corporate/presentation/widgets/compliance_manager_training_compliance_screen.dart' as migrated158;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_branch_comparison_screen.dart' as migrated159;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_branch_operations_screen.dart' as migrated160;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_compliance_view_screen.dart' as migrated161;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_dashboard_screen.dart' as migrated162;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_issue_escalations_screen.dart' as migrated163;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_operations_overview_screen.dart' as migrated164;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_reports_screen.dart' as migrated165;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_scheduling_health_screen.dart' as migrated166;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_service_delivery_screen.dart' as migrated167;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_staffing_efficiency_screen.dart' as migrated168;
import 'package:primecare_corporate/features/corporate/presentation/widgets/coo_workflow_performance_screen.dart' as migrated169;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_access_control_screen.dart' as migrated170;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_api_monitoring_screen.dart' as migrated171;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_audit_logs_screen.dart' as migrated172;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_dashboard_screen.dart' as migrated173;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_feature_adoption_screen.dart' as migrated174;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_infrastructure_screen.dart' as migrated175;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_integrations_screen.dart' as migrated176;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_issue_tracking_screen.dart' as migrated177;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_platform_usage_screen.dart' as migrated178;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_release_management_screen.dart' as migrated179;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_reports_screen.dart' as migrated180;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_system_health_screen.dart' as migrated181;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_system_verification_screen.dart' as migrated182;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cto_verification_hub_screen.dart' as migrated183;
import 'package:primecare_corporate/features/corporate/presentation/widgets/cx_director_dashboard_screen.dart' as migrated184;
import 'package:primecare_corporate/features/corporate/presentation/widgets/finance_director_cashflow_screen.dart' as migrated185;
import 'package:primecare_corporate/features/corporate/presentation/widgets/finance_director_dashboard_screen.dart' as migrated186;
import 'package:primecare_corporate/features/corporate/presentation/widgets/head_of_bus_dev_dashboard_screen.dart' as migrated187;
import 'package:primecare_corporate/features/corporate/presentation/widgets/head_of_marketing_dashboard_screen.dart' as migrated188;
import 'package:primecare_corporate/features/corporate/presentation/widgets/hr_director_dashboard_screen.dart' as migrated189;
import 'package:primecare_corporate/features/corporate/presentation/widgets/hr_hiring_dashboard_screen.dart' as migrated190;
import 'package:primecare_corporate/features/corporate/presentation/widgets/hr_manager_dashboard_screen.dart' as migrated191;
import 'package:primecare_corporate/features/corporate/presentation/widgets/it_admin_dashboard_screen.dart' as migrated192;
import 'package:primecare_corporate/features/corporate/presentation/widgets/legal_dashboard_screen.dart' as migrated193;
import 'package:primecare_corporate/features/corporate/presentation/widgets/owner_dashboard_screen.dart' as migrated194;
import 'package:primecare_corporate/features/corporate/presentation/widgets/shareholder_dashboard_screen.dart' as migrated195;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_analytics_screen.dart' as migrated196;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_assessments_screen.dart' as migrated197;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_certificates_screen.dart' as migrated198;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_certifications_screen.dart' as migrated199;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_compliance_training_screen.dart' as migrated200;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_course_architect_screen.dart' as migrated201;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_course_library_screen.dart' as migrated202;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_dashboard_screen.dart' as migrated203;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_hub_screen.dart' as migrated204;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_reports_screen.dart' as migrated205;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_staff_training_matrix_screen.dart' as migrated206;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_trainer_assignments_screen.dart' as migrated207;
import 'package:primecare_corporate/features/corporate/presentation/widgets/training_director_training_programs_screen.dart' as migrated208;
import 'package:primecare_corporate/features/corporate/presentation/widgets/volunteer_coordinator_dashboard_screen.dart' as migrated209;
import 'package:primecare_corporate/features/cto/screens/cto_access_control_screen.dart' as migrated210;
import 'package:primecare_corporate/features/cto/screens/cto_api_monitoring_screen.dart' as migrated211;
import 'package:primecare_corporate/features/cto/screens/cto_audit_logs_screen.dart' as migrated212;
import 'package:primecare_corporate/features/cto/screens/cto_dashboard_screen.dart' as migrated213;
import 'package:primecare_corporate/features/cto/screens/cto_feature_adoption_screen.dart' as migrated214;
import 'package:primecare_corporate/features/cto/screens/cto_infrastructure_screen.dart' as migrated215;
import 'package:primecare_corporate/features/cto/screens/cto_integrations_screen.dart' as migrated216;
import 'package:primecare_corporate/features/cto/screens/cto_issue_tracking_screen.dart' as migrated217;
import 'package:primecare_corporate/features/cto/screens/cto_platform_usage_screen.dart' as migrated218;
import 'package:primecare_corporate/features/cto/screens/cto_release_management_screen.dart' as migrated219;
import 'package:primecare_corporate/features/cto/screens/cto_reports_screen.dart' as migrated220;
import 'package:primecare_corporate/features/cto/screens/cto_system_health_screen.dart' as migrated221;
import 'package:primecare_corporate/features/cto/screens/cto_system_verification_screen.dart' as migrated222;
import 'package:primecare_corporate/features/cto/screens/cto_verification_hub_screen.dart' as migrated223;
import 'package:primecare_corporate/features/cx/screens/cx_director_dashboard_screen.dart' as migrated224;
import 'package:primecare_corporate/features/finance/screens/finance_director_cashflow_screen.dart' as migrated225;
import 'package:primecare_corporate/features/finance/screens/finance_director_dashboard_screen.dart' as migrated226;
import 'package:primecare_corporate/features/generated_screens/ceo_alerts_and_risks/sections/ceo_alerts_and_risks_action_bar_section.dart' as migrated227;
import 'package:primecare_corporate/features/generated_screens/ceo_alerts_and_risks/sections/ceo_alerts_and_risks_content_summary_section.dart' as migrated228;
import 'package:primecare_corporate/features/generated_screens/ceo_alerts_and_risks/sections/ceo_alerts_and_risks_header_section.dart' as migrated229;
import 'package:primecare_corporate/features/generated_screens/ceo_alerts_and_risks/sections/ceo_alerts_and_risks_primary_content_section.dart' as migrated230;
import 'package:primecare_corporate/features/generated_screens/ceo_alerts_and_risks_screen.dart' as migrated231;
import 'package:primecare_corporate/features/generated_screens/ceo_approvals/sections/ceo_approvals_action_bar_section.dart' as migrated232;
import 'package:primecare_corporate/features/generated_screens/ceo_approvals/sections/ceo_approvals_content_summary_section.dart' as migrated233;
import 'package:primecare_corporate/features/generated_screens/ceo_approvals/sections/ceo_approvals_header_section.dart' as migrated234;
import 'package:primecare_corporate/features/generated_screens/ceo_approvals/sections/ceo_approvals_primary_content_section.dart' as migrated235;
import 'package:primecare_corporate/features/generated_screens/ceo_approvals_screen.dart' as migrated236;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard/sections/ceo_dashboard_chart_overview_section.dart' as migrated237;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard/sections/ceo_dashboard_header_section.dart' as migrated238;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard/sections/ceo_dashboard_quick_actions_section.dart' as migrated239;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard/sections/ceo_dashboard_recent_activity_section.dart' as migrated240;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard/sections/ceo_dashboard_summary_cards_section.dart' as migrated241;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard_screen.dart' as migrated242;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview/sections/ceo_enterprise_overview_action_bar_section.dart' as migrated243;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview/sections/ceo_enterprise_overview_data_table_section.dart' as migrated244;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview/sections/ceo_enterprise_overview_filter_bar_section.dart' as migrated245;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview/sections/ceo_enterprise_overview_header_section.dart' as migrated246;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview/sections/ceo_enterprise_overview_pagination_section.dart' as migrated247;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview_screen.dart' as migrated248;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview/sections/ceo_franchise_overview_action_bar_section.dart' as migrated249;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview/sections/ceo_franchise_overview_data_table_section.dart' as migrated250;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview/sections/ceo_franchise_overview_filter_bar_section.dart' as migrated251;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview/sections/ceo_franchise_overview_header_section.dart' as migrated252;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview/sections/ceo_franchise_overview_pagination_section.dart' as migrated253;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview_screen.dart' as migrated254;
import 'package:primecare_corporate/features/generated_screens/ceo_growth_pipeline/sections/ceo_growth_pipeline_action_bar_section.dart' as migrated255;
import 'package:primecare_corporate/features/generated_screens/ceo_growth_pipeline/sections/ceo_growth_pipeline_content_summary_section.dart' as migrated256;
import 'package:primecare_corporate/features/generated_screens/ceo_growth_pipeline/sections/ceo_growth_pipeline_header_section.dart' as migrated257;
import 'package:primecare_corporate/features/generated_screens/ceo_growth_pipeline/sections/ceo_growth_pipeline_primary_content_section.dart' as migrated258;
import 'package:primecare_corporate/features/generated_screens/ceo_growth_pipeline_screen.dart' as migrated259;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports/sections/ceo_leadership_reports_chart_area_section.dart' as migrated260;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports/sections/ceo_leadership_reports_export_actions_section.dart' as migrated261;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports/sections/ceo_leadership_reports_filter_bar_section.dart' as migrated262;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports/sections/ceo_leadership_reports_header_section.dart' as migrated263;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports/sections/ceo_leadership_reports_metrics_summary_section.dart' as migrated264;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports_screen.dart' as migrated265;
import 'package:primecare_corporate/features/generated_screens/ceo_organization_map/sections/ceo_organization_map_action_bar_section.dart' as migrated266;
import 'package:primecare_corporate/features/generated_screens/ceo_organization_map/sections/ceo_organization_map_content_summary_section.dart' as migrated267;
import 'package:primecare_corporate/features/generated_screens/ceo_organization_map/sections/ceo_organization_map_header_section.dart' as migrated268;
import 'package:primecare_corporate/features/generated_screens/ceo_organization_map/sections/ceo_organization_map_primary_content_section.dart' as migrated269;
import 'package:primecare_corporate/features/generated_screens/ceo_organization_map_screen.dart' as migrated270;
import 'package:primecare_corporate/features/generated_screens/ceo_region_performance/sections/ceo_region_performance_action_bar_section.dart' as migrated271;
import 'package:primecare_corporate/features/generated_screens/ceo_region_performance/sections/ceo_region_performance_form_body_section.dart' as migrated272;
import 'package:primecare_corporate/features/generated_screens/ceo_region_performance/sections/ceo_region_performance_header_section.dart' as migrated273;
import 'package:primecare_corporate/features/generated_screens/ceo_region_performance/sections/ceo_region_performance_validation_messages_section.dart' as migrated274;
import 'package:primecare_corporate/features/generated_screens/ceo_region_performance_screen.dart' as migrated275;
import 'package:primecare_corporate/features/generated_screens/ceo_reports/sections/ceo_reports_chart_area_section.dart' as migrated276;
import 'package:primecare_corporate/features/generated_screens/ceo_reports/sections/ceo_reports_export_actions_section.dart' as migrated277;
import 'package:primecare_corporate/features/generated_screens/ceo_reports/sections/ceo_reports_filter_bar_section.dart' as migrated278;
import 'package:primecare_corporate/features/generated_screens/ceo_reports/sections/ceo_reports_header_section.dart' as migrated279;
import 'package:primecare_corporate/features/generated_screens/ceo_reports/sections/ceo_reports_metrics_summary_section.dart' as migrated280;
import 'package:primecare_corporate/features/generated_screens/ceo_reports_screen.dart' as migrated281;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary/sections/ceo_revenue_summary_chart_area_section.dart' as migrated282;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary/sections/ceo_revenue_summary_export_actions_section.dart' as migrated283;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary/sections/ceo_revenue_summary_filter_bar_section.dart' as migrated284;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary/sections/ceo_revenue_summary_header_section.dart' as migrated285;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary/sections/ceo_revenue_summary_metrics_summary_section.dart' as migrated286;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary_screen.dart' as migrated287;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis/sections/ceo_strategic_kpis_chart_area_section.dart' as migrated288;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis/sections/ceo_strategic_kpis_export_actions_section.dart' as migrated289;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis/sections/ceo_strategic_kpis_filter_bar_section.dart' as migrated290;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis/sections/ceo_strategic_kpis_header_section.dart' as migrated291;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis/sections/ceo_strategic_kpis_metrics_summary_section.dart' as migrated292;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis_screen.dart' as migrated293;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable/sections/cfo_accounts_payable_action_bar_section.dart' as migrated294;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable/sections/cfo_accounts_payable_details_form_section.dart' as migrated295;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable/sections/cfo_accounts_payable_header_section.dart' as migrated296;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable/sections/cfo_accounts_payable_identity_summary_section.dart' as migrated297;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable/sections/cfo_accounts_payable_preferences_or_documents_section.dart' as migrated298;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable_screen.dart' as migrated299;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable/sections/cfo_accounts_receivable_action_bar_section.dart' as migrated300;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable/sections/cfo_accounts_receivable_details_form_section.dart' as migrated301;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable/sections/cfo_accounts_receivable_header_section.dart' as migrated302;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable/sections/cfo_accounts_receivable_identity_summary_section.dart' as migrated303;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable/sections/cfo_accounts_receivable_preferences_or_documents_section.dart' as migrated304;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable_screen.dart' as migrated305;
import 'package:primecare_corporate/features/generated_screens/cfo_dashboard_screen.dart' as migrated306;
import 'package:primecare_corporate/features/generated_screens/cfo_expenses_screen.dart' as migrated307;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview/sections/cfo_financial_overview_action_bar_section.dart' as migrated308;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview/sections/cfo_financial_overview_data_table_section.dart' as migrated309;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview/sections/cfo_financial_overview_filter_bar_section.dart' as migrated310;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview/sections/cfo_financial_overview_header_section.dart' as migrated311;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview/sections/cfo_financial_overview_pagination_section.dart' as migrated312;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview_screen.dart' as migrated313;
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials/sections/cfo_franchise_financials_action_bar_section.dart' as migrated314;
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials/sections/cfo_franchise_financials_content_summary_section.dart' as migrated315;
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials/sections/cfo_franchise_financials_header_section.dart' as migrated316;
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials/sections/cfo_franchise_financials_primary_content_section.dart' as migrated317;
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials_screen.dart' as migrated318;
import 'package:primecare_corporate/features/generated_screens/cfo_invoices_screen.dart' as migrated319;
import 'package:primecare_corporate/features/generated_screens/cfo_payroll_screen.dart' as migrated320;
import 'package:primecare_corporate/features/generated_screens/cfo_profitability_screen.dart' as migrated321;
import 'package:primecare_corporate/features/generated_screens/cfo_reports/sections/cfo_reports_chart_area_section.dart' as migrated322;
import 'package:primecare_corporate/features/generated_screens/cfo_reports/sections/cfo_reports_export_actions_section.dart' as migrated323;
import 'package:primecare_corporate/features/generated_screens/cfo_reports/sections/cfo_reports_filter_bar_section.dart' as migrated324;
import 'package:primecare_corporate/features/generated_screens/cfo_reports/sections/cfo_reports_header_section.dart' as migrated325;
import 'package:primecare_corporate/features/generated_screens/cfo_reports/sections/cfo_reports_metrics_summary_section.dart' as migrated326;
import 'package:primecare_corporate/features/generated_screens/cfo_reports_screen.dart' as migrated327;
import 'package:primecare_corporate/features/generated_screens/cfo_revenue_screen.dart' as migrated328;
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance/sections/cfo_tax_and_remittance_action_bar_section.dart' as migrated329;
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance/sections/cfo_tax_and_remittance_content_summary_section.dart' as migrated330;
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance/sections/cfo_tax_and_remittance_header_section.dart' as migrated331;
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance/sections/cfo_tax_and_remittance_primary_content_section.dart' as migrated332;
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance_screen.dart' as migrated333;
import 'package:primecare_corporate/features/generated_screens/ciso_dashboard_screen.dart' as migrated334;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_audits/sections/compliance_manager_audits_action_bar_section.dart' as migrated335;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_audits/sections/compliance_manager_audits_content_summary_section.dart' as migrated336;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_audits/sections/compliance_manager_audits_header_section.dart' as migrated337;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_audits/sections/compliance_manager_audits_primary_content_section.dart' as migrated338;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_audits_screen.dart' as migrated339;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_compliance_cases/sections/compliance_manager_compliance_cases_action_bar_section.dart' as migrated340;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_compliance_cases/sections/compliance_manager_compliance_cases_content_summary_section.dart' as migrated341;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_compliance_cases/sections/compliance_manager_compliance_cases_header_section.dart' as migrated342;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_compliance_cases/sections/compliance_manager_compliance_cases_primary_content_section.dart' as migrated343;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_compliance_cases_screen.dart' as migrated344;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions/sections/compliance_manager_corrective_actions_action_bar_section.dart' as migrated345;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions/sections/compliance_manager_corrective_actions_header_section.dart' as migrated346;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions/sections/compliance_manager_corrective_actions_task_details_section.dart' as migrated347;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions/sections/compliance_manager_corrective_actions_task_filters_section.dart' as migrated348;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions/sections/compliance_manager_corrective_actions_task_list_section.dart' as migrated349;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions_screen.dart' as migrated350;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_credential_tracking/sections/compliance_manager_credential_tracking_action_bar_section.dart' as migrated351;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_credential_tracking/sections/compliance_manager_credential_tracking_content_summary_section.dart' as migrated352;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_credential_tracking/sections/compliance_manager_credential_tracking_header_section.dart' as migrated353;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_credential_tracking/sections/compliance_manager_credential_tracking_primary_content_section.dart' as migrated354;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_credential_tracking_screen.dart' as migrated355;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_dashboard_screen.dart' as migrated356;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_document_expiry/sections/compliance_manager_document_expiry_action_bar_section.dart' as migrated357;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_document_expiry/sections/compliance_manager_document_expiry_content_summary_section.dart' as migrated358;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_document_expiry/sections/compliance_manager_document_expiry_header_section.dart' as migrated359;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_document_expiry/sections/compliance_manager_document_expiry_primary_content_section.dart' as migrated360;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_document_expiry_screen.dart' as migrated361;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review/sections/compliance_manager_incident_review_action_bar_section.dart' as migrated362;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review/sections/compliance_manager_incident_review_data_table_section.dart' as migrated363;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review/sections/compliance_manager_incident_review_filter_bar_section.dart' as migrated364;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review/sections/compliance_manager_incident_review_header_section.dart' as migrated365;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review/sections/compliance_manager_incident_review_pagination_section.dart' as migrated366;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review_screen.dart' as migrated367;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_policies/sections/compliance_manager_policies_action_bar_section.dart' as migrated368;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_policies/sections/compliance_manager_policies_content_summary_section.dart' as migrated369;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_policies/sections/compliance_manager_policies_header_section.dart' as migrated370;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_policies/sections/compliance_manager_policies_primary_content_section.dart' as migrated371;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_policies_screen.dart' as migrated372;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports/sections/compliance_manager_reports_chart_area_section.dart' as migrated373;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports/sections/compliance_manager_reports_export_actions_section.dart' as migrated374;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports/sections/compliance_manager_reports_filter_bar_section.dart' as migrated375;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports/sections/compliance_manager_reports_header_section.dart' as migrated376;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports/sections/compliance_manager_reports_metrics_summary_section.dart' as migrated377;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports_screen.dart' as migrated378;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_risk_register/sections/compliance_manager_risk_register_action_bar_section.dart' as migrated379;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_risk_register/sections/compliance_manager_risk_register_content_summary_section.dart' as migrated380;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_risk_register/sections/compliance_manager_risk_register_header_section.dart' as migrated381;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_risk_register/sections/compliance_manager_risk_register_primary_content_section.dart' as migrated382;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_risk_register_screen.dart' as migrated383;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_training_compliance/sections/compliance_manager_training_compliance_action_bar_section.dart' as migrated384;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_training_compliance/sections/compliance_manager_training_compliance_content_summary_section.dart' as migrated385;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_training_compliance/sections/compliance_manager_training_compliance_header_section.dart' as migrated386;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_training_compliance/sections/compliance_manager_training_compliance_primary_content_section.dart' as migrated387;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_training_compliance_screen.dart' as migrated388;
import 'package:primecare_corporate/features/generated_screens/coo_branch_comparison_screen.dart' as migrated389;
import 'package:primecare_corporate/features/generated_screens/coo_branch_operations/sections/coo_branch_operations_action_bar_section.dart' as migrated390;
import 'package:primecare_corporate/features/generated_screens/coo_branch_operations/sections/coo_branch_operations_content_summary_section.dart' as migrated391;
import 'package:primecare_corporate/features/generated_screens/coo_branch_operations/sections/coo_branch_operations_header_section.dart' as migrated392;
import 'package:primecare_corporate/features/generated_screens/coo_branch_operations/sections/coo_branch_operations_primary_content_section.dart' as migrated393;
import 'package:primecare_corporate/features/generated_screens/coo_branch_operations_screen.dart' as migrated394;
import 'package:primecare_corporate/features/generated_screens/coo_compliance_view_screen.dart' as migrated395;
import 'package:primecare_corporate/features/generated_screens/coo_dashboard_screen.dart' as migrated396;
import 'package:primecare_corporate/features/generated_screens/coo_issue_escalations/sections/coo_issue_escalations_action_bar_section.dart' as migrated397;
import 'package:primecare_corporate/features/generated_screens/coo_issue_escalations/sections/coo_issue_escalations_content_summary_section.dart' as migrated398;
import 'package:primecare_corporate/features/generated_screens/coo_issue_escalations/sections/coo_issue_escalations_header_section.dart' as migrated399;
import 'package:primecare_corporate/features/generated_screens/coo_issue_escalations/sections/coo_issue_escalations_primary_content_section.dart' as migrated400;
import 'package:primecare_corporate/features/generated_screens/coo_issue_escalations_screen.dart' as migrated401;
import 'package:primecare_corporate/features/generated_screens/coo_operations_overview_screen.dart' as migrated402;
import 'package:primecare_corporate/features/generated_screens/coo_reports/sections/coo_reports_chart_area_section.dart' as migrated403;
import 'package:primecare_corporate/features/generated_screens/coo_reports/sections/coo_reports_export_actions_section.dart' as migrated404;
import 'package:primecare_corporate/features/generated_screens/coo_reports/sections/coo_reports_filter_bar_section.dart' as migrated405;
import 'package:primecare_corporate/features/generated_screens/coo_reports/sections/coo_reports_header_section.dart' as migrated406;
import 'package:primecare_corporate/features/generated_screens/coo_reports/sections/coo_reports_metrics_summary_section.dart' as migrated407;
import 'package:primecare_corporate/features/generated_screens/coo_reports_screen.dart' as migrated408;
import 'package:primecare_corporate/features/generated_screens/coo_scheduling_health_screen.dart' as migrated409;
import 'package:primecare_corporate/features/generated_screens/coo_service_delivery/sections/coo_service_delivery_action_bar_section.dart' as migrated410;
import 'package:primecare_corporate/features/generated_screens/coo_service_delivery/sections/coo_service_delivery_content_summary_section.dart' as migrated411;
import 'package:primecare_corporate/features/generated_screens/coo_service_delivery/sections/coo_service_delivery_header_section.dart' as migrated412;
import 'package:primecare_corporate/features/generated_screens/coo_service_delivery/sections/coo_service_delivery_primary_content_section.dart' as migrated413;
import 'package:primecare_corporate/features/generated_screens/coo_service_delivery_screen.dart' as migrated414;
import 'package:primecare_corporate/features/generated_screens/coo_staffing_efficiency/sections/coo_staffing_efficiency_action_bar_section.dart' as migrated415;
import 'package:primecare_corporate/features/generated_screens/coo_staffing_efficiency/sections/coo_staffing_efficiency_content_summary_section.dart' as migrated416;
import 'package:primecare_corporate/features/generated_screens/coo_staffing_efficiency/sections/coo_staffing_efficiency_header_section.dart' as migrated417;
import 'package:primecare_corporate/features/generated_screens/coo_staffing_efficiency/sections/coo_staffing_efficiency_primary_content_section.dart' as migrated418;
import 'package:primecare_corporate/features/generated_screens/coo_staffing_efficiency_screen.dart' as migrated419;
import 'package:primecare_corporate/features/generated_screens/coo_workflow_performance/sections/coo_workflow_performance_action_bar_section.dart' as migrated420;
import 'package:primecare_corporate/features/generated_screens/coo_workflow_performance/sections/coo_workflow_performance_form_body_section.dart' as migrated421;
import 'package:primecare_corporate/features/generated_screens/coo_workflow_performance/sections/coo_workflow_performance_header_section.dart' as migrated422;
import 'package:primecare_corporate/features/generated_screens/coo_workflow_performance/sections/coo_workflow_performance_validation_messages_section.dart' as migrated423;
import 'package:primecare_corporate/features/generated_screens/coo_workflow_performance_screen.dart' as migrated424;
import 'package:primecare_corporate/features/generated_screens/cto_access_control/sections/cto_access_control_action_bar_section.dart' as migrated425;
import 'package:primecare_corporate/features/generated_screens/cto_access_control/sections/cto_access_control_content_summary_section.dart' as migrated426;
import 'package:primecare_corporate/features/generated_screens/cto_access_control/sections/cto_access_control_header_section.dart' as migrated427;
import 'package:primecare_corporate/features/generated_screens/cto_access_control/sections/cto_access_control_primary_content_section.dart' as migrated428;
import 'package:primecare_corporate/features/generated_screens/cto_access_control_screen.dart' as migrated429;
import 'package:primecare_corporate/features/generated_screens/cto_api_monitoring/sections/cto_api_monitoring_action_bar_section.dart' as migrated430;
import 'package:primecare_corporate/features/generated_screens/cto_api_monitoring/sections/cto_api_monitoring_content_summary_section.dart' as migrated431;
import 'package:primecare_corporate/features/generated_screens/cto_api_monitoring/sections/cto_api_monitoring_header_section.dart' as migrated432;
import 'package:primecare_corporate/features/generated_screens/cto_api_monitoring/sections/cto_api_monitoring_primary_content_section.dart' as migrated433;
import 'package:primecare_corporate/features/generated_screens/cto_api_monitoring_screen.dart' as migrated434;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs/sections/cto_audit_logs_action_bar_section.dart' as migrated435;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs/sections/cto_audit_logs_data_table_section.dart' as migrated436;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs/sections/cto_audit_logs_filter_bar_section.dart' as migrated437;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs/sections/cto_audit_logs_header_section.dart' as migrated438;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs/sections/cto_audit_logs_pagination_section.dart' as migrated439;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs_screen.dart' as migrated440;
import 'package:primecare_corporate/features/generated_screens/cto_dashboard_screen.dart' as migrated441;
import 'package:primecare_corporate/features/generated_screens/cto_feature_adoption/sections/cto_feature_adoption_action_bar_section.dart' as migrated442;
import 'package:primecare_corporate/features/generated_screens/cto_feature_adoption/sections/cto_feature_adoption_content_summary_section.dart' as migrated443;
import 'package:primecare_corporate/features/generated_screens/cto_feature_adoption/sections/cto_feature_adoption_header_section.dart' as migrated444;
import 'package:primecare_corporate/features/generated_screens/cto_feature_adoption/sections/cto_feature_adoption_primary_content_section.dart' as migrated445;
import 'package:primecare_corporate/features/generated_screens/cto_feature_adoption_screen.dart' as migrated446;
import 'package:primecare_corporate/features/generated_screens/cto_infrastructure/sections/cto_infrastructure_action_bar_section.dart' as migrated447;
import 'package:primecare_corporate/features/generated_screens/cto_infrastructure/sections/cto_infrastructure_content_summary_section.dart' as migrated448;
import 'package:primecare_corporate/features/generated_screens/cto_infrastructure/sections/cto_infrastructure_header_section.dart' as migrated449;
import 'package:primecare_corporate/features/generated_screens/cto_infrastructure/sections/cto_infrastructure_primary_content_section.dart' as migrated450;
import 'package:primecare_corporate/features/generated_screens/cto_infrastructure_screen.dart' as migrated451;
import 'package:primecare_corporate/features/generated_screens/cto_integrations/sections/cto_integrations_action_bar_section.dart' as migrated452;
import 'package:primecare_corporate/features/generated_screens/cto_integrations/sections/cto_integrations_content_summary_section.dart' as migrated453;
import 'package:primecare_corporate/features/generated_screens/cto_integrations/sections/cto_integrations_header_section.dart' as migrated454;
import 'package:primecare_corporate/features/generated_screens/cto_integrations/sections/cto_integrations_primary_content_section.dart' as migrated455;
import 'package:primecare_corporate/features/generated_screens/cto_integrations_screen.dart' as migrated456;
import 'package:primecare_corporate/features/generated_screens/cto_issue_tracking/sections/cto_issue_tracking_action_bar_section.dart' as migrated457;
import 'package:primecare_corporate/features/generated_screens/cto_issue_tracking/sections/cto_issue_tracking_content_summary_section.dart' as migrated458;
import 'package:primecare_corporate/features/generated_screens/cto_issue_tracking/sections/cto_issue_tracking_header_section.dart' as migrated459;
import 'package:primecare_corporate/features/generated_screens/cto_issue_tracking/sections/cto_issue_tracking_primary_content_section.dart' as migrated460;
import 'package:primecare_corporate/features/generated_screens/cto_issue_tracking_screen.dart' as migrated461;
import 'package:primecare_corporate/features/generated_screens/cto_platform_usage/sections/cto_platform_usage_action_bar_section.dart' as migrated462;
import 'package:primecare_corporate/features/generated_screens/cto_platform_usage/sections/cto_platform_usage_form_body_section.dart' as migrated463;
import 'package:primecare_corporate/features/generated_screens/cto_platform_usage/sections/cto_platform_usage_header_section.dart' as migrated464;
import 'package:primecare_corporate/features/generated_screens/cto_platform_usage/sections/cto_platform_usage_validation_messages_section.dart' as migrated465;
import 'package:primecare_corporate/features/generated_screens/cto_platform_usage_screen.dart' as migrated466;
import 'package:primecare_corporate/features/generated_screens/cto_release_management/sections/cto_release_management_action_bar_section.dart' as migrated467;
import 'package:primecare_corporate/features/generated_screens/cto_release_management/sections/cto_release_management_content_summary_section.dart' as migrated468;
import 'package:primecare_corporate/features/generated_screens/cto_release_management/sections/cto_release_management_header_section.dart' as migrated469;
import 'package:primecare_corporate/features/generated_screens/cto_release_management/sections/cto_release_management_primary_content_section.dart' as migrated470;
import 'package:primecare_corporate/features/generated_screens/cto_release_management_screen.dart' as migrated471;
import 'package:primecare_corporate/features/generated_screens/cto_reports/sections/cto_reports_chart_area_section.dart' as migrated472;
import 'package:primecare_corporate/features/generated_screens/cto_reports/sections/cto_reports_export_actions_section.dart' as migrated473;
import 'package:primecare_corporate/features/generated_screens/cto_reports/sections/cto_reports_filter_bar_section.dart' as migrated474;
import 'package:primecare_corporate/features/generated_screens/cto_reports/sections/cto_reports_header_section.dart' as migrated475;
import 'package:primecare_corporate/features/generated_screens/cto_reports/sections/cto_reports_metrics_summary_section.dart' as migrated476;
import 'package:primecare_corporate/features/generated_screens/cto_reports_screen.dart' as migrated477;
import 'package:primecare_corporate/features/generated_screens/cto_system_health/sections/cto_system_health_action_bar_section.dart' as migrated478;
import 'package:primecare_corporate/features/generated_screens/cto_system_health/sections/cto_system_health_content_summary_section.dart' as migrated479;
import 'package:primecare_corporate/features/generated_screens/cto_system_health/sections/cto_system_health_header_section.dart' as migrated480;
import 'package:primecare_corporate/features/generated_screens/cto_system_health/sections/cto_system_health_primary_content_section.dart' as migrated481;
import 'package:primecare_corporate/features/generated_screens/cto_system_health_screen.dart' as migrated482;
import 'package:primecare_corporate/features/generated_screens/cto_system_verification/sections/cto_system_verification_action_bar_section.dart' as migrated483;
import 'package:primecare_corporate/features/generated_screens/cto_system_verification/sections/cto_system_verification_content_summary_section.dart' as migrated484;
import 'package:primecare_corporate/features/generated_screens/cto_system_verification/sections/cto_system_verification_header_section.dart' as migrated485;
import 'package:primecare_corporate/features/generated_screens/cto_system_verification/sections/cto_system_verification_primary_content_section.dart' as migrated486;
import 'package:primecare_corporate/features/generated_screens/cto_system_verification_screen.dart' as migrated487;
import 'package:primecare_corporate/features/generated_screens/cto_verification_hub/sections/cto_verification_hub_action_bar_section.dart' as migrated488;
import 'package:primecare_corporate/features/generated_screens/cto_verification_hub/sections/cto_verification_hub_content_summary_section.dart' as migrated489;
import 'package:primecare_corporate/features/generated_screens/cto_verification_hub/sections/cto_verification_hub_header_section.dart' as migrated490;
import 'package:primecare_corporate/features/generated_screens/cto_verification_hub/sections/cto_verification_hub_primary_content_section.dart' as migrated491;
import 'package:primecare_corporate/features/generated_screens/cto_verification_hub_screen.dart' as migrated492;
import 'package:primecare_corporate/features/generated_screens/cx_director_dashboard_screen.dart' as migrated493;
import 'package:primecare_corporate/features/generated_screens/finance_director_cashflow/sections/finance_director_cashflow_action_bar_section.dart' as migrated494;
import 'package:primecare_corporate/features/generated_screens/finance_director_cashflow/sections/finance_director_cashflow_content_summary_section.dart' as migrated495;
import 'package:primecare_corporate/features/generated_screens/finance_director_cashflow/sections/finance_director_cashflow_header_section.dart' as migrated496;
import 'package:primecare_corporate/features/generated_screens/finance_director_cashflow/sections/finance_director_cashflow_primary_content_section.dart' as migrated497;
import 'package:primecare_corporate/features/generated_screens/finance_director_cashflow_screen.dart' as migrated498;
import 'package:primecare_corporate/features/generated_screens/finance_director_dashboard_screen.dart' as migrated499;
import 'package:primecare_corporate/features/generated_screens/head_of_bus_dev_dashboard_screen.dart' as migrated500;
import 'package:primecare_corporate/features/generated_screens/head_of_marketing_dashboard_screen.dart' as migrated501;
import 'package:primecare_corporate/features/generated_screens/hr_director_dashboard_screen.dart' as migrated502;
import 'package:primecare_corporate/features/generated_screens/hr_hiring_dashboard_screen.dart' as migrated503;
import 'package:primecare_corporate/features/generated_screens/hr_manager_dashboard_screen.dart' as migrated504;
import 'package:primecare_corporate/features/generated_screens/it_admin_dashboard_screen.dart' as migrated505;
import 'package:primecare_corporate/features/generated_screens/legal_dashboard_screen.dart' as migrated506;
import 'package:primecare_corporate/features/generated_screens/owner_dashboard_screen.dart' as migrated507;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_alerts_and_risks_action_bar_section.dart' as migrated508;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_alerts_and_risks_content_summary_section.dart' as migrated509;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_alerts_and_risks_header_section.dart' as migrated510;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_alerts_and_risks_primary_content_section.dart' as migrated511;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_approvals_action_bar_section.dart' as migrated512;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_approvals_content_summary_section.dart' as migrated513;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_approvals_header_section.dart' as migrated514;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_approvals_primary_content_section.dart' as migrated515;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_dashboard_chart_overview_section.dart' as migrated516;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_dashboard_header_section.dart' as migrated517;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_dashboard_quick_actions_section.dart' as migrated518;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_dashboard_recent_activity_section.dart' as migrated519;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_dashboard_summary_cards_section.dart' as migrated520;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_enterprise_overview_action_bar_section.dart' as migrated521;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_enterprise_overview_data_table_section.dart' as migrated522;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_enterprise_overview_filter_bar_section.dart' as migrated523;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_enterprise_overview_header_section.dart' as migrated524;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_enterprise_overview_pagination_section.dart' as migrated525;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_franchise_overview_action_bar_section.dart' as migrated526;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_franchise_overview_data_table_section.dart' as migrated527;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_franchise_overview_filter_bar_section.dart' as migrated528;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_franchise_overview_header_section.dart' as migrated529;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_franchise_overview_pagination_section.dart' as migrated530;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_growth_pipeline_action_bar_section.dart' as migrated531;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_growth_pipeline_content_summary_section.dart' as migrated532;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_growth_pipeline_header_section.dart' as migrated533;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_growth_pipeline_primary_content_section.dart' as migrated534;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_leadership_reports_chart_area_section.dart' as migrated535;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_leadership_reports_export_actions_section.dart' as migrated536;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_leadership_reports_filter_bar_section.dart' as migrated537;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_leadership_reports_header_section.dart' as migrated538;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_leadership_reports_metrics_summary_section.dart' as migrated539;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_organization_map_action_bar_section.dart' as migrated540;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_organization_map_content_summary_section.dart' as migrated541;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_organization_map_header_section.dart' as migrated542;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_organization_map_primary_content_section.dart' as migrated543;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_region_performance_action_bar_section.dart' as migrated544;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_region_performance_form_body_section.dart' as migrated545;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_region_performance_header_section.dart' as migrated546;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_region_performance_validation_messages_section.dart' as migrated547;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_reports_chart_area_section.dart' as migrated548;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_reports_export_actions_section.dart' as migrated549;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_reports_filter_bar_section.dart' as migrated550;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_reports_header_section.dart' as migrated551;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_reports_metrics_summary_section.dart' as migrated552;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_revenue_summary_chart_area_section.dart' as migrated553;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_revenue_summary_export_actions_section.dart' as migrated554;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_revenue_summary_filter_bar_section.dart' as migrated555;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_revenue_summary_header_section.dart' as migrated556;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_revenue_summary_metrics_summary_section.dart' as migrated557;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_strategic_kpis_chart_area_section.dart' as migrated558;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_strategic_kpis_export_actions_section.dart' as migrated559;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_strategic_kpis_filter_bar_section.dart' as migrated560;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_strategic_kpis_header_section.dart' as migrated561;
import 'package:primecare_corporate/features/generated_screens/sections/ceo_strategic_kpis_metrics_summary_section.dart' as migrated562;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_payable_action_bar_section.dart' as migrated563;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_payable_details_form_section.dart' as migrated564;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_payable_header_section.dart' as migrated565;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_payable_identity_summary_section.dart' as migrated566;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_payable_preferences_or_documents_section.dart' as migrated567;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_receivable_action_bar_section.dart' as migrated568;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_receivable_details_form_section.dart' as migrated569;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_receivable_header_section.dart' as migrated570;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_receivable_identity_summary_section.dart' as migrated571;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_accounts_receivable_preferences_or_documents_section.dart' as migrated572;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_financial_overview_action_bar_section.dart' as migrated573;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_financial_overview_data_table_section.dart' as migrated574;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_financial_overview_filter_bar_section.dart' as migrated575;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_financial_overview_header_section.dart' as migrated576;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_financial_overview_pagination_section.dart' as migrated577;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_franchise_financials_action_bar_section.dart' as migrated578;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_franchise_financials_content_summary_section.dart' as migrated579;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_franchise_financials_header_section.dart' as migrated580;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_franchise_financials_primary_content_section.dart' as migrated581;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_reports_chart_area_section.dart' as migrated582;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_reports_export_actions_section.dart' as migrated583;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_reports_filter_bar_section.dart' as migrated584;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_reports_header_section.dart' as migrated585;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_reports_metrics_summary_section.dart' as migrated586;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_tax_and_remittance_action_bar_section.dart' as migrated587;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_tax_and_remittance_content_summary_section.dart' as migrated588;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_tax_and_remittance_header_section.dart' as migrated589;
import 'package:primecare_corporate/features/generated_screens/sections/cfo_tax_and_remittance_primary_content_section.dart' as migrated590;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_audits_action_bar_section.dart' as migrated591;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_audits_content_summary_section.dart' as migrated592;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_audits_header_section.dart' as migrated593;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_audits_primary_content_section.dart' as migrated594;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_compliance_cases_action_bar_section.dart' as migrated595;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_compliance_cases_content_summary_section.dart' as migrated596;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_compliance_cases_header_section.dart' as migrated597;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_compliance_cases_primary_content_section.dart' as migrated598;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_corrective_actions_action_bar_section.dart' as migrated599;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_corrective_actions_header_section.dart' as migrated600;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_corrective_actions_task_details_section.dart' as migrated601;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_corrective_actions_task_filters_section.dart' as migrated602;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_corrective_actions_task_list_section.dart' as migrated603;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_credential_tracking_action_bar_section.dart' as migrated604;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_credential_tracking_content_summary_section.dart' as migrated605;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_credential_tracking_header_section.dart' as migrated606;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_credential_tracking_primary_content_section.dart' as migrated607;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_document_expiry_action_bar_section.dart' as migrated608;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_document_expiry_content_summary_section.dart' as migrated609;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_document_expiry_header_section.dart' as migrated610;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_document_expiry_primary_content_section.dart' as migrated611;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_incident_review_action_bar_section.dart' as migrated612;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_incident_review_data_table_section.dart' as migrated613;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_incident_review_filter_bar_section.dart' as migrated614;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_incident_review_header_section.dart' as migrated615;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_incident_review_pagination_section.dart' as migrated616;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_policies_action_bar_section.dart' as migrated617;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_policies_content_summary_section.dart' as migrated618;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_policies_header_section.dart' as migrated619;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_policies_primary_content_section.dart' as migrated620;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_reports_chart_area_section.dart' as migrated621;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_reports_export_actions_section.dart' as migrated622;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_reports_filter_bar_section.dart' as migrated623;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_reports_header_section.dart' as migrated624;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_reports_metrics_summary_section.dart' as migrated625;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_risk_register_action_bar_section.dart' as migrated626;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_risk_register_content_summary_section.dart' as migrated627;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_risk_register_header_section.dart' as migrated628;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_risk_register_primary_content_section.dart' as migrated629;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_training_compliance_action_bar_section.dart' as migrated630;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_training_compliance_content_summary_section.dart' as migrated631;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_training_compliance_header_section.dart' as migrated632;
import 'package:primecare_corporate/features/generated_screens/sections/compliance_manager_training_compliance_primary_content_section.dart' as migrated633;
import 'package:primecare_corporate/features/generated_screens/sections/coo_branch_operations_action_bar_section.dart' as migrated634;
import 'package:primecare_corporate/features/generated_screens/sections/coo_branch_operations_content_summary_section.dart' as migrated635;
import 'package:primecare_corporate/features/generated_screens/sections/coo_branch_operations_header_section.dart' as migrated636;
import 'package:primecare_corporate/features/generated_screens/sections/coo_branch_operations_primary_content_section.dart' as migrated637;
import 'package:primecare_corporate/features/generated_screens/sections/coo_issue_escalations_action_bar_section.dart' as migrated638;
import 'package:primecare_corporate/features/generated_screens/sections/coo_issue_escalations_content_summary_section.dart' as migrated639;
import 'package:primecare_corporate/features/generated_screens/sections/coo_issue_escalations_header_section.dart' as migrated640;
import 'package:primecare_corporate/features/generated_screens/sections/coo_issue_escalations_primary_content_section.dart' as migrated641;
import 'package:primecare_corporate/features/generated_screens/sections/coo_reports_chart_area_section.dart' as migrated642;
import 'package:primecare_corporate/features/generated_screens/sections/coo_reports_export_actions_section.dart' as migrated643;
import 'package:primecare_corporate/features/generated_screens/sections/coo_reports_filter_bar_section.dart' as migrated644;
import 'package:primecare_corporate/features/generated_screens/sections/coo_reports_header_section.dart' as migrated645;
import 'package:primecare_corporate/features/generated_screens/sections/coo_reports_metrics_summary_section.dart' as migrated646;
import 'package:primecare_corporate/features/generated_screens/sections/coo_service_delivery_action_bar_section.dart' as migrated647;
import 'package:primecare_corporate/features/generated_screens/sections/coo_service_delivery_content_summary_section.dart' as migrated648;
import 'package:primecare_corporate/features/generated_screens/sections/coo_service_delivery_header_section.dart' as migrated649;
import 'package:primecare_corporate/features/generated_screens/sections/coo_service_delivery_primary_content_section.dart' as migrated650;
import 'package:primecare_corporate/features/generated_screens/sections/coo_staffing_efficiency_action_bar_section.dart' as migrated651;
import 'package:primecare_corporate/features/generated_screens/sections/coo_staffing_efficiency_content_summary_section.dart' as migrated652;
import 'package:primecare_corporate/features/generated_screens/sections/coo_staffing_efficiency_header_section.dart' as migrated653;
import 'package:primecare_corporate/features/generated_screens/sections/coo_staffing_efficiency_primary_content_section.dart' as migrated654;
import 'package:primecare_corporate/features/generated_screens/sections/coo_workflow_performance_action_bar_section.dart' as migrated655;
import 'package:primecare_corporate/features/generated_screens/sections/coo_workflow_performance_form_body_section.dart' as migrated656;
import 'package:primecare_corporate/features/generated_screens/sections/coo_workflow_performance_header_section.dart' as migrated657;
import 'package:primecare_corporate/features/generated_screens/sections/coo_workflow_performance_validation_messages_section.dart' as migrated658;
import 'package:primecare_corporate/features/generated_screens/sections/cto_access_control_action_bar_section.dart' as migrated659;
import 'package:primecare_corporate/features/generated_screens/sections/cto_access_control_content_summary_section.dart' as migrated660;
import 'package:primecare_corporate/features/generated_screens/sections/cto_access_control_header_section.dart' as migrated661;
import 'package:primecare_corporate/features/generated_screens/sections/cto_access_control_primary_content_section.dart' as migrated662;
import 'package:primecare_corporate/features/generated_screens/sections/cto_api_monitoring_action_bar_section.dart' as migrated663;
import 'package:primecare_corporate/features/generated_screens/sections/cto_api_monitoring_content_summary_section.dart' as migrated664;
import 'package:primecare_corporate/features/generated_screens/sections/cto_api_monitoring_header_section.dart' as migrated665;
import 'package:primecare_corporate/features/generated_screens/sections/cto_api_monitoring_primary_content_section.dart' as migrated666;
import 'package:primecare_corporate/features/generated_screens/sections/cto_audit_logs_action_bar_section.dart' as migrated667;
import 'package:primecare_corporate/features/generated_screens/sections/cto_audit_logs_data_table_section.dart' as migrated668;
import 'package:primecare_corporate/features/generated_screens/sections/cto_audit_logs_filter_bar_section.dart' as migrated669;
import 'package:primecare_corporate/features/generated_screens/sections/cto_audit_logs_header_section.dart' as migrated670;
import 'package:primecare_corporate/features/generated_screens/sections/cto_audit_logs_pagination_section.dart' as migrated671;
import 'package:primecare_corporate/features/generated_screens/sections/cto_feature_adoption_action_bar_section.dart' as migrated672;
import 'package:primecare_corporate/features/generated_screens/sections/cto_feature_adoption_content_summary_section.dart' as migrated673;
import 'package:primecare_corporate/features/generated_screens/sections/cto_feature_adoption_header_section.dart' as migrated674;
import 'package:primecare_corporate/features/generated_screens/sections/cto_feature_adoption_primary_content_section.dart' as migrated675;
import 'package:primecare_corporate/features/generated_screens/sections/cto_infrastructure_action_bar_section.dart' as migrated676;
import 'package:primecare_corporate/features/generated_screens/sections/cto_infrastructure_content_summary_section.dart' as migrated677;
import 'package:primecare_corporate/features/generated_screens/sections/cto_infrastructure_header_section.dart' as migrated678;
import 'package:primecare_corporate/features/generated_screens/sections/cto_infrastructure_primary_content_section.dart' as migrated679;
import 'package:primecare_corporate/features/generated_screens/sections/cto_integrations_action_bar_section.dart' as migrated680;
import 'package:primecare_corporate/features/generated_screens/sections/cto_integrations_content_summary_section.dart' as migrated681;
import 'package:primecare_corporate/features/generated_screens/sections/cto_integrations_header_section.dart' as migrated682;
import 'package:primecare_corporate/features/generated_screens/sections/cto_integrations_primary_content_section.dart' as migrated683;
import 'package:primecare_corporate/features/generated_screens/sections/cto_issue_tracking_action_bar_section.dart' as migrated684;
import 'package:primecare_corporate/features/generated_screens/sections/cto_issue_tracking_content_summary_section.dart' as migrated685;
import 'package:primecare_corporate/features/generated_screens/sections/cto_issue_tracking_header_section.dart' as migrated686;
import 'package:primecare_corporate/features/generated_screens/sections/cto_issue_tracking_primary_content_section.dart' as migrated687;
import 'package:primecare_corporate/features/generated_screens/sections/cto_platform_usage_action_bar_section.dart' as migrated688;
import 'package:primecare_corporate/features/generated_screens/sections/cto_platform_usage_form_body_section.dart' as migrated689;
import 'package:primecare_corporate/features/generated_screens/sections/cto_platform_usage_header_section.dart' as migrated690;
import 'package:primecare_corporate/features/generated_screens/sections/cto_platform_usage_validation_messages_section.dart' as migrated691;
import 'package:primecare_corporate/features/generated_screens/sections/cto_release_management_action_bar_section.dart' as migrated692;
import 'package:primecare_corporate/features/generated_screens/sections/cto_release_management_content_summary_section.dart' as migrated693;
import 'package:primecare_corporate/features/generated_screens/sections/cto_release_management_header_section.dart' as migrated694;
import 'package:primecare_corporate/features/generated_screens/sections/cto_release_management_primary_content_section.dart' as migrated695;
import 'package:primecare_corporate/features/generated_screens/sections/cto_reports_chart_area_section.dart' as migrated696;
import 'package:primecare_corporate/features/generated_screens/sections/cto_reports_export_actions_section.dart' as migrated697;
import 'package:primecare_corporate/features/generated_screens/sections/cto_reports_filter_bar_section.dart' as migrated698;
import 'package:primecare_corporate/features/generated_screens/sections/cto_reports_header_section.dart' as migrated699;
import 'package:primecare_corporate/features/generated_screens/sections/cto_reports_metrics_summary_section.dart' as migrated700;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_health_action_bar_section.dart' as migrated701;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_health_content_summary_section.dart' as migrated702;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_health_header_section.dart' as migrated703;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_health_primary_content_section.dart' as migrated704;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_verification_action_bar_section.dart' as migrated705;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_verification_content_summary_section.dart' as migrated706;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_verification_header_section.dart' as migrated707;
import 'package:primecare_corporate/features/generated_screens/sections/cto_system_verification_primary_content_section.dart' as migrated708;
import 'package:primecare_corporate/features/generated_screens/sections/cto_verification_hub_action_bar_section.dart' as migrated709;
import 'package:primecare_corporate/features/generated_screens/sections/cto_verification_hub_content_summary_section.dart' as migrated710;
import 'package:primecare_corporate/features/generated_screens/sections/cto_verification_hub_header_section.dart' as migrated711;
import 'package:primecare_corporate/features/generated_screens/sections/cto_verification_hub_primary_content_section.dart' as migrated712;
import 'package:primecare_corporate/features/generated_screens/sections/finance_director_cashflow_action_bar_section.dart' as migrated713;
import 'package:primecare_corporate/features/generated_screens/sections/finance_director_cashflow_content_summary_section.dart' as migrated714;
import 'package:primecare_corporate/features/generated_screens/sections/finance_director_cashflow_header_section.dart' as migrated715;
import 'package:primecare_corporate/features/generated_screens/sections/finance_director_cashflow_primary_content_section.dart' as migrated716;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_assessments_action_bar_section.dart' as migrated717;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_assessments_content_summary_section.dart' as migrated718;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_assessments_header_section.dart' as migrated719;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_assessments_primary_content_section.dart' as migrated720;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certificates_action_bar_section.dart' as migrated721;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certificates_content_summary_section.dart' as migrated722;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certificates_header_section.dart' as migrated723;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certificates_primary_content_section.dart' as migrated724;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certifications_action_bar_section.dart' as migrated725;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certifications_content_summary_section.dart' as migrated726;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certifications_header_section.dart' as migrated727;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_certifications_primary_content_section.dart' as migrated728;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_compliance_training_action_bar_section.dart' as migrated729;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_compliance_training_content_summary_section.dart' as migrated730;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_compliance_training_header_section.dart' as migrated731;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_compliance_training_primary_content_section.dart' as migrated732;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_architect_action_bar_section.dart' as migrated733;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_architect_content_summary_section.dart' as migrated734;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_architect_header_section.dart' as migrated735;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_architect_primary_content_section.dart' as migrated736;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_library_action_bar_section.dart' as migrated737;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_library_content_summary_section.dart' as migrated738;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_library_header_section.dart' as migrated739;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_course_library_primary_content_section.dart' as migrated740;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_hub_action_bar_section.dart' as migrated741;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_hub_content_summary_section.dart' as migrated742;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_hub_header_section.dart' as migrated743;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_hub_primary_content_section.dart' as migrated744;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_reports_chart_area_section.dart' as migrated745;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_reports_export_actions_section.dart' as migrated746;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_reports_filter_bar_section.dart' as migrated747;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_reports_header_section.dart' as migrated748;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_reports_metrics_summary_section.dart' as migrated749;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_staff_training_matrix_action_bar_section.dart' as migrated750;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_staff_training_matrix_content_summary_section.dart' as migrated751;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_staff_training_matrix_header_section.dart' as migrated752;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_staff_training_matrix_primary_content_section.dart' as migrated753;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_trainer_assignments_action_bar_section.dart' as migrated754;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_trainer_assignments_content_summary_section.dart' as migrated755;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_trainer_assignments_header_section.dart' as migrated756;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_trainer_assignments_primary_content_section.dart' as migrated757;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_training_programs_action_bar_section.dart' as migrated758;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_training_programs_content_summary_section.dart' as migrated759;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_training_programs_header_section.dart' as migrated760;
import 'package:primecare_corporate/features/generated_screens/sections/training_director_training_programs_primary_content_section.dart' as migrated761;
import 'package:primecare_corporate/features/generated_screens/shareholder_dashboard_screen.dart' as migrated762;
import 'package:primecare_corporate/features/generated_screens/training_director_analytics_screen.dart' as migrated763;
import 'package:primecare_corporate/features/generated_screens/training_director_assessments/sections/training_director_assessments_action_bar_section.dart' as migrated764;
import 'package:primecare_corporate/features/generated_screens/training_director_assessments/sections/training_director_assessments_content_summary_section.dart' as migrated765;
import 'package:primecare_corporate/features/generated_screens/training_director_assessments/sections/training_director_assessments_header_section.dart' as migrated766;
import 'package:primecare_corporate/features/generated_screens/training_director_assessments/sections/training_director_assessments_primary_content_section.dart' as migrated767;
import 'package:primecare_corporate/features/generated_screens/training_director_assessments_screen.dart' as migrated768;
import 'package:primecare_corporate/features/generated_screens/training_director_certificates/sections/training_director_certificates_action_bar_section.dart' as migrated769;
import 'package:primecare_corporate/features/generated_screens/training_director_certificates/sections/training_director_certificates_content_summary_section.dart' as migrated770;
import 'package:primecare_corporate/features/generated_screens/training_director_certificates/sections/training_director_certificates_header_section.dart' as migrated771;
import 'package:primecare_corporate/features/generated_screens/training_director_certificates/sections/training_director_certificates_primary_content_section.dart' as migrated772;
import 'package:primecare_corporate/features/generated_screens/training_director_certificates_screen.dart' as migrated773;
import 'package:primecare_corporate/features/generated_screens/training_director_certifications/sections/training_director_certifications_action_bar_section.dart' as migrated774;
import 'package:primecare_corporate/features/generated_screens/training_director_certifications/sections/training_director_certifications_content_summary_section.dart' as migrated775;
import 'package:primecare_corporate/features/generated_screens/training_director_certifications/sections/training_director_certifications_header_section.dart' as migrated776;
import 'package:primecare_corporate/features/generated_screens/training_director_certifications/sections/training_director_certifications_primary_content_section.dart' as migrated777;
import 'package:primecare_corporate/features/generated_screens/training_director_certifications_screen.dart' as migrated778;
import 'package:primecare_corporate/features/generated_screens/training_director_compliance_training/sections/training_director_compliance_training_action_bar_section.dart' as migrated779;
import 'package:primecare_corporate/features/generated_screens/training_director_compliance_training/sections/training_director_compliance_training_content_summary_section.dart' as migrated780;
import 'package:primecare_corporate/features/generated_screens/training_director_compliance_training/sections/training_director_compliance_training_header_section.dart' as migrated781;
import 'package:primecare_corporate/features/generated_screens/training_director_compliance_training/sections/training_director_compliance_training_primary_content_section.dart' as migrated782;
import 'package:primecare_corporate/features/generated_screens/training_director_compliance_training_screen.dart' as migrated783;
import 'package:primecare_corporate/features/generated_screens/training_director_course_architect/sections/training_director_course_architect_action_bar_section.dart' as migrated784;
import 'package:primecare_corporate/features/generated_screens/training_director_course_architect/sections/training_director_course_architect_content_summary_section.dart' as migrated785;
import 'package:primecare_corporate/features/generated_screens/training_director_course_architect/sections/training_director_course_architect_header_section.dart' as migrated786;
import 'package:primecare_corporate/features/generated_screens/training_director_course_architect/sections/training_director_course_architect_primary_content_section.dart' as migrated787;
import 'package:primecare_corporate/features/generated_screens/training_director_course_architect_screen.dart' as migrated788;
import 'package:primecare_corporate/features/generated_screens/training_director_course_library/sections/training_director_course_library_action_bar_section.dart' as migrated789;
import 'package:primecare_corporate/features/generated_screens/training_director_course_library/sections/training_director_course_library_content_summary_section.dart' as migrated790;
import 'package:primecare_corporate/features/generated_screens/training_director_course_library/sections/training_director_course_library_header_section.dart' as migrated791;
import 'package:primecare_corporate/features/generated_screens/training_director_course_library/sections/training_director_course_library_primary_content_section.dart' as migrated792;
import 'package:primecare_corporate/features/generated_screens/training_director_course_library_screen.dart' as migrated793;
import 'package:primecare_corporate/features/generated_screens/training_director_dashboard_screen.dart' as migrated794;
import 'package:primecare_corporate/features/generated_screens/training_director_hub/sections/training_director_hub_action_bar_section.dart' as migrated795;
import 'package:primecare_corporate/features/generated_screens/training_director_hub/sections/training_director_hub_content_summary_section.dart' as migrated796;
import 'package:primecare_corporate/features/generated_screens/training_director_hub/sections/training_director_hub_header_section.dart' as migrated797;
import 'package:primecare_corporate/features/generated_screens/training_director_hub/sections/training_director_hub_primary_content_section.dart' as migrated798;
import 'package:primecare_corporate/features/generated_screens/training_director_hub_screen.dart' as migrated799;
import 'package:primecare_corporate/features/generated_screens/training_director_reports/sections/training_director_reports_chart_area_section.dart' as migrated800;
import 'package:primecare_corporate/features/generated_screens/training_director_reports/sections/training_director_reports_export_actions_section.dart' as migrated801;
import 'package:primecare_corporate/features/generated_screens/training_director_reports/sections/training_director_reports_filter_bar_section.dart' as migrated802;
import 'package:primecare_corporate/features/generated_screens/training_director_reports/sections/training_director_reports_header_section.dart' as migrated803;
import 'package:primecare_corporate/features/generated_screens/training_director_reports/sections/training_director_reports_metrics_summary_section.dart' as migrated804;
import 'package:primecare_corporate/features/generated_screens/training_director_reports_screen.dart' as migrated805;
import 'package:primecare_corporate/features/generated_screens/training_director_staff_training_matrix/sections/training_director_staff_training_matrix_action_bar_section.dart' as migrated806;
import 'package:primecare_corporate/features/generated_screens/training_director_staff_training_matrix/sections/training_director_staff_training_matrix_content_summary_section.dart' as migrated807;
import 'package:primecare_corporate/features/generated_screens/training_director_staff_training_matrix/sections/training_director_staff_training_matrix_header_section.dart' as migrated808;
import 'package:primecare_corporate/features/generated_screens/training_director_staff_training_matrix/sections/training_director_staff_training_matrix_primary_content_section.dart' as migrated809;
import 'package:primecare_corporate/features/generated_screens/training_director_staff_training_matrix_screen.dart' as migrated810;
import 'package:primecare_corporate/features/generated_screens/training_director_trainer_assignments/sections/training_director_trainer_assignments_action_bar_section.dart' as migrated811;
import 'package:primecare_corporate/features/generated_screens/training_director_trainer_assignments/sections/training_director_trainer_assignments_content_summary_section.dart' as migrated812;
import 'package:primecare_corporate/features/generated_screens/training_director_trainer_assignments/sections/training_director_trainer_assignments_header_section.dart' as migrated813;
import 'package:primecare_corporate/features/generated_screens/training_director_trainer_assignments/sections/training_director_trainer_assignments_primary_content_section.dart' as migrated814;
import 'package:primecare_corporate/features/generated_screens/training_director_trainer_assignments_screen.dart' as migrated815;
import 'package:primecare_corporate/features/generated_screens/training_director_training_programs/sections/training_director_training_programs_action_bar_section.dart' as migrated816;
import 'package:primecare_corporate/features/generated_screens/training_director_training_programs/sections/training_director_training_programs_content_summary_section.dart' as migrated817;
import 'package:primecare_corporate/features/generated_screens/training_director_training_programs/sections/training_director_training_programs_header_section.dart' as migrated818;
import 'package:primecare_corporate/features/generated_screens/training_director_training_programs/sections/training_director_training_programs_primary_content_section.dart' as migrated819;
import 'package:primecare_corporate/features/generated_screens/training_director_training_programs_screen.dart' as migrated820;
import 'package:primecare_corporate/features/generated_screens/volunteer_coordinator_dashboard_screen.dart' as migrated821;
import 'package:primecare_corporate/features/hr/screens/hr_director_dashboard_screen.dart' as migrated822;
import 'package:primecare_corporate/features/hr/screens/hr_hiring_dashboard_screen.dart' as migrated823;
import 'package:primecare_corporate/features/hr/screens/hr_manager_dashboard_screen.dart' as migrated824;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard/sections/it_admin_dashboard_chart_overview_section.dart' as migrated825;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard/sections/it_admin_dashboard_header_section.dart' as migrated826;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard/sections/it_admin_dashboard_quick_actions_section.dart' as migrated827;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard/sections/it_admin_dashboard_recent_activity_section.dart' as migrated828;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard/sections/it_admin_dashboard_summary_cards_section.dart' as migrated829;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard_screen.dart' as migrated830;
import 'package:primecare_corporate/features/itadmin/screens/sections/it_admin_dashboard_chart_overview_section.dart' as migrated831;
import 'package:primecare_corporate/features/itadmin/screens/sections/it_admin_dashboard_header_section.dart' as migrated832;
import 'package:primecare_corporate/features/itadmin/screens/sections/it_admin_dashboard_quick_actions_section.dart' as migrated833;
import 'package:primecare_corporate/features/itadmin/screens/sections/it_admin_dashboard_recent_activity_section.dart' as migrated834;
import 'package:primecare_corporate/features/itadmin/screens/sections/it_admin_dashboard_summary_cards_section.dart' as migrated835;
import 'package:primecare_corporate/features/legal/screens/legal_dashboard_screen.dart' as migrated836;
import 'package:primecare_corporate/features/marketing/screens/head_of_marketing_dashboard_screen.dart' as migrated837;
import 'package:primecare_corporate/features/owner/screens/owner_dashboard_screen.dart' as migrated838;
import 'package:primecare_corporate/features/shareholder/screens/shareholder_dashboard_screen.dart' as migrated839;
import 'package:primecare_corporate/features/training/screens/assessments/sections/assessments_action_bar_section.dart' as migrated840;
import 'package:primecare_corporate/features/training/screens/assessments/sections/assessments_content_summary_section.dart' as migrated841;
import 'package:primecare_corporate/features/training/screens/assessments/sections/assessments_header_section.dart' as migrated842;
import 'package:primecare_corporate/features/training/screens/assessments/sections/assessments_primary_content_section.dart' as migrated843;
import 'package:primecare_corporate/features/training/screens/assessments_screen.dart' as migrated844;
import 'package:primecare_corporate/features/training/screens/certificates/sections/certificates_action_bar_section.dart' as migrated845;
import 'package:primecare_corporate/features/training/screens/certificates/sections/certificates_content_summary_section.dart' as migrated846;
import 'package:primecare_corporate/features/training/screens/certificates/sections/certificates_header_section.dart' as migrated847;
import 'package:primecare_corporate/features/training/screens/certificates/sections/certificates_primary_content_section.dart' as migrated848;
import 'package:primecare_corporate/features/training/screens/certificates_screen.dart' as migrated849;
import 'package:primecare_corporate/features/training/screens/certifications/sections/certifications_action_bar_section.dart' as migrated850;
import 'package:primecare_corporate/features/training/screens/certifications/sections/certifications_content_summary_section.dart' as migrated851;
import 'package:primecare_corporate/features/training/screens/certifications/sections/certifications_header_section.dart' as migrated852;
import 'package:primecare_corporate/features/training/screens/certifications/sections/certifications_primary_content_section.dart' as migrated853;
import 'package:primecare_corporate/features/training/screens/certifications_screen.dart' as migrated854;
import 'package:primecare_corporate/features/training/screens/compliance_training/sections/compliance_training_action_bar_section.dart' as migrated855;
import 'package:primecare_corporate/features/training/screens/compliance_training/sections/compliance_training_content_summary_section.dart' as migrated856;
import 'package:primecare_corporate/features/training/screens/compliance_training/sections/compliance_training_header_section.dart' as migrated857;
import 'package:primecare_corporate/features/training/screens/compliance_training/sections/compliance_training_primary_content_section.dart' as migrated858;
import 'package:primecare_corporate/features/training/screens/compliance_training_screen.dart' as migrated859;
import 'package:primecare_corporate/features/training/screens/course_architect/sections/course_architect_action_bar_section.dart' as migrated860;
import 'package:primecare_corporate/features/training/screens/course_architect/sections/course_architect_content_summary_section.dart' as migrated861;
import 'package:primecare_corporate/features/training/screens/course_architect/sections/course_architect_header_section.dart' as migrated862;
import 'package:primecare_corporate/features/training/screens/course_architect/sections/course_architect_primary_content_section.dart' as migrated863;
import 'package:primecare_corporate/features/training/screens/course_architect_screen.dart' as migrated864;
import 'package:primecare_corporate/features/training/screens/course_library/sections/course_library_action_bar_section.dart' as migrated865;
import 'package:primecare_corporate/features/training/screens/course_library/sections/course_library_content_summary_section.dart' as migrated866;
import 'package:primecare_corporate/features/training/screens/course_library/sections/course_library_header_section.dart' as migrated867;
import 'package:primecare_corporate/features/training/screens/course_library/sections/course_library_primary_content_section.dart' as migrated868;
import 'package:primecare_corporate/features/training/screens/course_library_screen.dart' as migrated869;
import 'package:primecare_corporate/features/training/screens/sections/assessments_action_bar_section.dart' as migrated870;
import 'package:primecare_corporate/features/training/screens/sections/assessments_content_summary_section.dart' as migrated871;
import 'package:primecare_corporate/features/training/screens/sections/assessments_header_section.dart' as migrated872;
import 'package:primecare_corporate/features/training/screens/sections/assessments_primary_content_section.dart' as migrated873;
import 'package:primecare_corporate/features/training/screens/sections/certificates_action_bar_section.dart' as migrated874;
import 'package:primecare_corporate/features/training/screens/sections/certificates_content_summary_section.dart' as migrated875;
import 'package:primecare_corporate/features/training/screens/sections/certificates_header_section.dart' as migrated876;
import 'package:primecare_corporate/features/training/screens/sections/certificates_primary_content_section.dart' as migrated877;
import 'package:primecare_corporate/features/training/screens/sections/certifications_action_bar_section.dart' as migrated878;
import 'package:primecare_corporate/features/training/screens/sections/certifications_content_summary_section.dart' as migrated879;
import 'package:primecare_corporate/features/training/screens/sections/certifications_header_section.dart' as migrated880;
import 'package:primecare_corporate/features/training/screens/sections/certifications_primary_content_section.dart' as migrated881;
import 'package:primecare_corporate/features/training/screens/sections/compliance_training_action_bar_section.dart' as migrated882;
import 'package:primecare_corporate/features/training/screens/sections/compliance_training_content_summary_section.dart' as migrated883;
import 'package:primecare_corporate/features/training/screens/sections/compliance_training_header_section.dart' as migrated884;
import 'package:primecare_corporate/features/training/screens/sections/compliance_training_primary_content_section.dart' as migrated885;
import 'package:primecare_corporate/features/training/screens/sections/course_architect_action_bar_section.dart' as migrated886;
import 'package:primecare_corporate/features/training/screens/sections/course_architect_content_summary_section.dart' as migrated887;
import 'package:primecare_corporate/features/training/screens/sections/course_architect_header_section.dart' as migrated888;
import 'package:primecare_corporate/features/training/screens/sections/course_architect_primary_content_section.dart' as migrated889;
import 'package:primecare_corporate/features/training/screens/sections/course_library_action_bar_section.dart' as migrated890;
import 'package:primecare_corporate/features/training/screens/sections/course_library_content_summary_section.dart' as migrated891;
import 'package:primecare_corporate/features/training/screens/sections/course_library_header_section.dart' as migrated892;
import 'package:primecare_corporate/features/training/screens/sections/course_library_primary_content_section.dart' as migrated893;
import 'package:primecare_corporate/features/training/screens/sections/staff_training_matrix_action_bar_section.dart' as migrated894;
import 'package:primecare_corporate/features/training/screens/sections/staff_training_matrix_content_summary_section.dart' as migrated895;
import 'package:primecare_corporate/features/training/screens/sections/staff_training_matrix_header_section.dart' as migrated896;
import 'package:primecare_corporate/features/training/screens/sections/staff_training_matrix_primary_content_section.dart' as migrated897;
import 'package:primecare_corporate/features/training/screens/sections/trainer_assignments_action_bar_section.dart' as migrated898;
import 'package:primecare_corporate/features/training/screens/sections/trainer_assignments_content_summary_section.dart' as migrated899;
import 'package:primecare_corporate/features/training/screens/sections/trainer_assignments_header_section.dart' as migrated900;
import 'package:primecare_corporate/features/training/screens/sections/trainer_assignments_primary_content_section.dart' as migrated901;
import 'package:primecare_corporate/features/training/screens/sections/training_analytics_chart_area_section.dart' as migrated902;
import 'package:primecare_corporate/features/training/screens/sections/training_analytics_export_actions_section.dart' as migrated903;
import 'package:primecare_corporate/features/training/screens/sections/training_analytics_filter_bar_section.dart' as migrated904;
import 'package:primecare_corporate/features/training/screens/sections/training_analytics_header_section.dart' as migrated905;
import 'package:primecare_corporate/features/training/screens/sections/training_analytics_metrics_summary_section.dart' as migrated906;
import 'package:primecare_corporate/features/training/screens/sections/training_hub_action_bar_section.dart' as migrated907;
import 'package:primecare_corporate/features/training/screens/sections/training_hub_content_summary_section.dart' as migrated908;
import 'package:primecare_corporate/features/training/screens/sections/training_hub_header_section.dart' as migrated909;
import 'package:primecare_corporate/features/training/screens/sections/training_hub_primary_content_section.dart' as migrated910;
import 'package:primecare_corporate/features/training/screens/sections/training_programs_action_bar_section.dart' as migrated911;
import 'package:primecare_corporate/features/training/screens/sections/training_programs_content_summary_section.dart' as migrated912;
import 'package:primecare_corporate/features/training/screens/sections/training_programs_header_section.dart' as migrated913;
import 'package:primecare_corporate/features/training/screens/sections/training_programs_primary_content_section.dart' as migrated914;
import 'package:primecare_corporate/features/training/screens/sections/training_reports_chart_area_section.dart' as migrated915;
import 'package:primecare_corporate/features/training/screens/sections/training_reports_export_actions_section.dart' as migrated916;
import 'package:primecare_corporate/features/training/screens/sections/training_reports_filter_bar_section.dart' as migrated917;
import 'package:primecare_corporate/features/training/screens/sections/training_reports_header_section.dart' as migrated918;
import 'package:primecare_corporate/features/training/screens/sections/training_reports_metrics_summary_section.dart' as migrated919;
import 'package:primecare_corporate/features/training/screens/staff_training_matrix/sections/staff_training_matrix_action_bar_section.dart' as migrated920;
import 'package:primecare_corporate/features/training/screens/staff_training_matrix/sections/staff_training_matrix_content_summary_section.dart' as migrated921;
import 'package:primecare_corporate/features/training/screens/staff_training_matrix/sections/staff_training_matrix_header_section.dart' as migrated922;
import 'package:primecare_corporate/features/training/screens/staff_training_matrix/sections/staff_training_matrix_primary_content_section.dart' as migrated923;
import 'package:primecare_corporate/features/training/screens/staff_training_matrix_screen.dart' as migrated924;
import 'package:primecare_corporate/features/training/screens/trainer_assignments/sections/trainer_assignments_action_bar_section.dart' as migrated925;
import 'package:primecare_corporate/features/training/screens/trainer_assignments/sections/trainer_assignments_content_summary_section.dart' as migrated926;
import 'package:primecare_corporate/features/training/screens/trainer_assignments/sections/trainer_assignments_header_section.dart' as migrated927;
import 'package:primecare_corporate/features/training/screens/trainer_assignments/sections/trainer_assignments_primary_content_section.dart' as migrated928;
import 'package:primecare_corporate/features/training/screens/trainer_assignments_screen.dart' as migrated929;
import 'package:primecare_corporate/features/training/screens/training_analytics/sections/training_analytics_chart_area_section.dart' as migrated930;
import 'package:primecare_corporate/features/training/screens/training_analytics/sections/training_analytics_export_actions_section.dart' as migrated931;
import 'package:primecare_corporate/features/training/screens/training_analytics/sections/training_analytics_filter_bar_section.dart' as migrated932;
import 'package:primecare_corporate/features/training/screens/training_analytics/sections/training_analytics_header_section.dart' as migrated933;
import 'package:primecare_corporate/features/training/screens/training_analytics/sections/training_analytics_metrics_summary_section.dart' as migrated934;
import 'package:primecare_corporate/features/training/screens/training_analytics_screen.dart' as migrated935;
import 'package:primecare_corporate/features/training/screens/training_director_dashboard_screen.dart' as migrated936;
import 'package:primecare_corporate/features/training/screens/training_hub/sections/training_hub_action_bar_section.dart' as migrated937;
import 'package:primecare_corporate/features/training/screens/training_hub/sections/training_hub_content_summary_section.dart' as migrated938;
import 'package:primecare_corporate/features/training/screens/training_hub/sections/training_hub_header_section.dart' as migrated939;
import 'package:primecare_corporate/features/training/screens/training_hub/sections/training_hub_primary_content_section.dart' as migrated940;
import 'package:primecare_corporate/features/training/screens/training_hub_screen.dart' as migrated941;
import 'package:primecare_corporate/features/training/screens/training_programs/sections/training_programs_action_bar_section.dart' as migrated942;
import 'package:primecare_corporate/features/training/screens/training_programs/sections/training_programs_content_summary_section.dart' as migrated943;
import 'package:primecare_corporate/features/training/screens/training_programs/sections/training_programs_header_section.dart' as migrated944;
import 'package:primecare_corporate/features/training/screens/training_programs/sections/training_programs_primary_content_section.dart' as migrated945;
import 'package:primecare_corporate/features/training/screens/training_programs_screen.dart' as migrated946;
import 'package:primecare_corporate/features/training/screens/training_reports/sections/training_reports_chart_area_section.dart' as migrated947;
import 'package:primecare_corporate/features/training/screens/training_reports/sections/training_reports_export_actions_section.dart' as migrated948;
import 'package:primecare_corporate/features/training/screens/training_reports/sections/training_reports_filter_bar_section.dart' as migrated949;
import 'package:primecare_corporate/features/training/screens/training_reports/sections/training_reports_header_section.dart' as migrated950;
import 'package:primecare_corporate/features/training/screens/training_reports/sections/training_reports_metrics_summary_section.dart' as migrated951;
import 'package:primecare_corporate/features/training/screens/training_reports_screen.dart' as migrated952;
import 'package:primecare_corporate/features/volunteer/screens/volunteer_coordinator_dashboard_screen.dart' as migrated953;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
      migrated0.HeadOfBusDevDashboardScreen,
      migrated1.CeoAlertsAndRisksScreen,
      migrated2.CeoApprovalsScreen,
      migrated3.CeoDashboardScreen,
      migrated4.CeoEnterpriseOverviewScreen,
      migrated5.CeoFranchiseOverviewScreen,
      migrated6.CeoGrowthPipelineScreen,
      migrated7.CeoLeadershipReportsScreen,
      migrated8.CeoOrganizationMapScreen,
      migrated9.CeoRegionPerformanceScreen,
      migrated10.CeoReportsScreen,
      migrated11.CeoRevenueSummaryScreen,
      migrated12.CeoStrategicKpisScreen,
      migrated13.CfoAccountsPayableScreen,
      migrated14.CfoAccountsReceivableScreen,
      migrated15.CfoDashboardScreen,
      migrated16.CfoExpensesScreen,
      migrated17.CfoFinancialOverviewScreen,
      migrated18.CfoFranchiseFinancialsScreen,
      migrated19.CfoInvoicesScreen,
      migrated20.CfoPayrollScreen,
      migrated21.CfoProfitabilityScreen,
      migrated22.CfoReportsScreen,
      migrated23.CfoRevenueScreen,
      migrated24.CfoTaxAndRemittanceScreen,
      migrated25.CisoDashboardScreen,
      migrated26.AuditsActionBarSection,
      migrated27.AuditsContentSummarySection,
      migrated28.AuditsHeaderSection,
      migrated29.AuditsPrimaryContentSection,
      migrated30.AuditsScreenState,
      migrated31.ComplianceCasesActionBarSection,
      migrated32.ComplianceCasesContentSummarySection,
      migrated33.ComplianceCasesHeaderSection,
      migrated34.ComplianceCasesPrimaryContentSection,
      migrated35.ComplianceCasesScreenState,
      migrated36.ComplianceManagerDashboardScreen,
      migrated37.ComplianceReportsChartAreaSection,
      migrated38.ComplianceReportsExportActionsSection,
      migrated39.ComplianceReportsFilterBarSection,
      migrated40.ComplianceReportsHeaderSection,
      migrated41.ComplianceReportsMetricsSummarySection,
      migrated42.ComplianceReportsScreenState,
      migrated43.CorrectiveActionsActionBarSection,
      migrated44.CorrectiveActionsHeaderSection,
      migrated45.CorrectiveActionsTaskDetailsSection,
      migrated46.CorrectiveActionsTaskFiltersSection,
      migrated47.CorrectiveActionsTaskListSection,
      migrated48.CorrectiveActionsScreenState,
      migrated49.CredentialTrackingActionBarSection,
      migrated50.CredentialTrackingContentSummarySection,
      migrated51.CredentialTrackingHeaderSection,
      migrated52.CredentialTrackingPrimaryContentSection,
      migrated53.CredentialTrackingScreenState,
      migrated54.DocumentExpiryActionBarSection,
      migrated55.DocumentExpiryContentSummarySection,
      migrated56.DocumentExpiryHeaderSection,
      migrated57.DocumentExpiryPrimaryContentSection,
      migrated58.DocumentExpiryScreenState,
      migrated59.IncidentReviewScreen,
      migrated60.PoliciesActionBarSection,
      migrated61.PoliciesContentSummarySection,
      migrated62.PoliciesHeaderSection,
      migrated63.PoliciesPrimaryContentSection,
      migrated64.PoliciesScreenState,
      migrated65.RiskRegisterActionBarSection,
      migrated66.RiskRegisterContentSummarySection,
      migrated67.RiskRegisterHeaderSection,
      migrated68.RiskRegisterPrimaryContentSection,
      migrated69.RiskRegisterScreenState,
      migrated70.AuditsActionBarSection,
      migrated71.AuditsContentSummarySection,
      migrated72.AuditsHeaderSection,
      migrated73.AuditsPrimaryContentSection,
      migrated74.ComplianceCasesActionBarSection,
      migrated75.ComplianceCasesContentSummarySection,
      migrated76.ComplianceCasesHeaderSection,
      migrated77.ComplianceCasesPrimaryContentSection,
      migrated78.ComplianceReportsChartAreaSection,
      migrated79.ComplianceReportsExportActionsSection,
      migrated80.ComplianceReportsFilterBarSection,
      migrated81.ComplianceReportsHeaderSection,
      migrated82.ComplianceReportsMetricsSummarySection,
      migrated83.CorrectiveActionsActionBarSection,
      migrated84.CorrectiveActionsHeaderSection,
      migrated85.CorrectiveActionsTaskDetailsSection,
      migrated86.CorrectiveActionsTaskFiltersSection,
      migrated87.CorrectiveActionsTaskListSection,
      migrated88.CredentialTrackingActionBarSection,
      migrated89.CredentialTrackingContentSummarySection,
      migrated90.CredentialTrackingHeaderSection,
      migrated91.CredentialTrackingPrimaryContentSection,
      migrated92.DocumentExpiryActionBarSection,
      migrated93.DocumentExpiryContentSummarySection,
      migrated94.DocumentExpiryHeaderSection,
      migrated95.DocumentExpiryPrimaryContentSection,
      migrated96.PoliciesActionBarSection,
      migrated97.PoliciesContentSummarySection,
      migrated98.PoliciesHeaderSection,
      migrated99.PoliciesPrimaryContentSection,
      migrated100.RiskRegisterActionBarSection,
      migrated101.RiskRegisterContentSummarySection,
      migrated102.RiskRegisterHeaderSection,
      migrated103.RiskRegisterPrimaryContentSection,
      migrated104.TrainingComplianceActionBarSection,
      migrated105.TrainingComplianceContentSummarySection,
      migrated106.TrainingComplianceHeaderSection,
      migrated107.TrainingCompliancePrimaryContentSection,
      migrated108.TrainingComplianceActionBarSection,
      migrated109.TrainingComplianceContentSummarySection,
      migrated110.TrainingComplianceHeaderSection,
      migrated111.TrainingCompliancePrimaryContentSection,
      migrated112.TrainingComplianceScreenState,
      migrated113.CooBranchComparisonScreen,
      migrated114.CooBranchOperationsScreen,
      migrated115.CooComplianceViewScreen,
      migrated116.CooDashboardScreen,
      migrated117.CooIssueEscalationsScreen,
      migrated118.CooOperationsOverviewScreen,
      migrated119.CooReportsScreen,
      migrated120.CooSchedulingHealthScreen,
      migrated121.CooServiceDeliveryScreen,
      migrated122.CooStaffingEfficiencyScreen,
      migrated123.CooWorkflowPerformanceScreen,
      migrated124.CeoAlertsAndRisksScreen,
      migrated125.CeoApprovalsScreen,
      migrated126.CeoEnterpriseOverviewScreen,
      migrated127.CeoFranchiseOverviewScreen,
      migrated128.CeoGrowthPipelineScreen,
      migrated129.CeoLeadershipReportsScreen,
      migrated130.CeoOrganizationMapScreen,
      migrated131.CeoRegionPerformanceScreen,
      migrated132.CeoReportsScreen,
      migrated133.CeoRevenueSummaryScreen,
      migrated134.CeoStrategicKpisScreen,
      migrated135.CfoAccountsPayableScreen,
      migrated136.CfoAccountsReceivableScreen,
      migrated137.CfoDashboardScreen,
      migrated138.CfoExpensesScreen,
      migrated139.CfoFinancialOverviewScreen,
      migrated140.CfoFranchiseFinancialsScreen,
      migrated141.CfoInvoicesScreen,
      migrated142.CfoPayrollScreen,
      migrated143.CfoProfitabilityScreen,
      migrated144.CfoReportsScreen,
      migrated145.CfoRevenueScreen,
      migrated146.CfoTaxAndRemittanceScreen,
      migrated147.CisoDashboardScreen,
      migrated148.ComplianceManagerAuditsScreen,
      migrated149.ComplianceManagerComplianceCasesScreen,
      migrated150.ComplianceManagerCorrectiveActionsScreen,
      migrated151.ComplianceManagerCredentialTrackingScreen,
      migrated152.ComplianceManagerDashboardScreen,
      migrated153.ComplianceManagerDocumentExpiryScreen,
      migrated154.ComplianceManagerIncidentReviewScreen,
      migrated155.ComplianceManagerPoliciesScreen,
      migrated156.ComplianceManagerReportsScreen,
      migrated157.ComplianceManagerRiskRegisterScreen,
      migrated158.ComplianceManagerTrainingComplianceScreen,
      migrated159.CooBranchComparisonScreen,
      migrated160.CooBranchOperationsScreen,
      migrated161.CooComplianceViewScreen,
      migrated162.CooDashboardScreen,
      migrated163.CooIssueEscalationsScreen,
      migrated164.CooOperationsOverviewScreen,
      migrated165.CooReportsScreen,
      migrated166.CooSchedulingHealthScreen,
      migrated167.CooServiceDeliveryScreen,
      migrated168.CooStaffingEfficiencyScreen,
      migrated169.CooWorkflowPerformanceScreen,
      migrated170.CtoAccessControlScreen,
      migrated171.CtoApiMonitoringScreen,
      migrated172.CtoAuditLogsScreen,
      migrated173.CtoDashboardScreen,
      migrated174.CtoFeatureAdoptionScreen,
      migrated175.CtoInfrastructureScreen,
      migrated176.CtoIntegrationsScreen,
      migrated177.CtoIssueTrackingScreen,
      migrated178.CtoPlatformUsageScreen,
      migrated179.CtoReleaseManagementScreen,
      migrated180.CtoReportsScreen,
      migrated181.CtoSystemHealthScreen,
      migrated182.CtoSystemVerificationScreen,
      migrated183.CtoVerificationHubScreen,
      migrated184.CxDirectorDashboardScreen,
      migrated185.FinanceDirectorCashflowScreen,
      migrated186.FinanceDirectorDashboardScreen,
      migrated187.HeadOfBusDevDashboardScreen,
      migrated188.HeadOfMarketingDashboardScreen,
      migrated189.HrDirectorDashboardScreen,
      migrated190.HrHiringDashboardScreen,
      migrated191.HrManagerDashboardScreen,
      migrated192.ItAdminDashboardScreen,
      migrated193.LegalDashboardScreen,
      migrated194.OwnerDashboardScreen,
      migrated195.ShareholderDashboardScreen,
      migrated196.TrainingDirectorAnalyticsScreen,
      migrated197.TrainingDirectorAssessmentsScreen,
      migrated198.TrainingDirectorCertificatesScreen,
      migrated199.TrainingDirectorCertificationsScreen,
      migrated200.TrainingDirectorComplianceTrainingScreen,
      migrated201.TrainingDirectorCourseArchitectScreen,
      migrated202.TrainingDirectorCourseLibraryScreen,
      migrated203.TrainingDirectorDashboardScreen,
      migrated204.TrainingDirectorHubScreen,
      migrated205.TrainingDirectorReportsScreen,
      migrated206.TrainingDirectorStaffTrainingMatrixScreen,
      migrated207.TrainingDirectorTrainerAssignmentsScreen,
      migrated208.TrainingDirectorTrainingProgramsScreen,
      migrated209.VolunteerCoordinatorDashboardScreen,
      migrated210.CtoAccessControlScreen,
      migrated211.CtoApiMonitoringScreen,
      migrated212.CtoAuditLogsScreen,
      migrated213.CtoDashboardScreen,
      migrated214.CtoFeatureAdoptionScreen,
      migrated215.CtoInfrastructureScreen,
      migrated216.CtoIntegrationsScreen,
      migrated217.CtoIssueTrackingScreen,
      migrated218.CtoPlatformUsageScreen,
      migrated219.CtoReleaseManagementScreen,
      migrated220.CtoReportsScreen,
      migrated221.CtoSystemHealthScreen,
      migrated222.CtoSystemVerificationScreen,
      migrated223.CtoVerificationHubScreen,
      migrated224.CxDirectorDashboardScreen,
      migrated225.FinanceDirectorCashflowScreen,
      migrated226.FinanceDirectorDashboardScreen,
      migrated227.CeoAlertsAndRisksActionBarSection,
      migrated228.CeoAlertsAndRisksContentSummarySection,
      migrated229.CeoAlertsAndRisksHeaderSection,
      migrated230.CeoAlertsAndRisksPrimaryContentSection,
      migrated231.CeoAlertsAndRisksScreenState,
      migrated232.CeoApprovalsActionBarSection,
      migrated233.CeoApprovalsContentSummarySection,
      migrated234.CeoApprovalsHeaderSection,
      migrated235.CeoApprovalsPrimaryContentSection,
      migrated236.CeoApprovalsScreenState,
      migrated237.CeoDashboardChartOverviewSection,
      migrated238.CeoDashboardHeaderSection,
      migrated239.CeoDashboardQuickActionsSection,
      migrated240.CeoDashboardRecentActivitySection,
      migrated241.CeoDashboardSummaryCardsSection,
      migrated242.CeoDashboardScreenState,
      migrated243.CeoEnterpriseOverviewActionBarSection,
      migrated244.CeoEnterpriseOverviewDataTableSection,
      migrated245.CeoEnterpriseOverviewFilterBarSection,
      migrated246.CeoEnterpriseOverviewHeaderSection,
      migrated247.CeoEnterpriseOverviewPaginationSection,
      migrated248.CeoEnterpriseOverviewScreenState,
      migrated249.CeoFranchiseOverviewActionBarSection,
      migrated250.CeoFranchiseOverviewDataTableSection,
      migrated251.CeoFranchiseOverviewFilterBarSection,
      migrated252.CeoFranchiseOverviewHeaderSection,
      migrated253.CeoFranchiseOverviewPaginationSection,
      migrated254.CeoFranchiseOverviewScreenState,
      migrated255.CeoGrowthPipelineActionBarSection,
      migrated256.CeoGrowthPipelineContentSummarySection,
      migrated257.CeoGrowthPipelineHeaderSection,
      migrated258.CeoGrowthPipelinePrimaryContentSection,
      migrated259.CeoGrowthPipelineScreenState,
      migrated260.CeoLeadershipReportsChartAreaSection,
      migrated261.CeoLeadershipReportsExportActionsSection,
      migrated262.CeoLeadershipReportsFilterBarSection,
      migrated263.CeoLeadershipReportsHeaderSection,
      migrated264.CeoLeadershipReportsMetricsSummarySection,
      migrated265.CeoLeadershipReportsScreenState,
      migrated266.CeoOrganizationMapActionBarSection,
      migrated267.CeoOrganizationMapContentSummarySection,
      migrated268.CeoOrganizationMapHeaderSection,
      migrated269.CeoOrganizationMapPrimaryContentSection,
      migrated270.CeoOrganizationMapScreenState,
      migrated271.CeoRegionPerformanceActionBarSection,
      migrated272.CeoRegionPerformanceFormBodySection,
      migrated273.CeoRegionPerformanceHeaderSection,
      migrated274.CeoRegionPerformanceValidationMessagesSection,
      migrated275.CeoRegionPerformanceScreenState,
      migrated276.CeoReportsChartAreaSection,
      migrated277.CeoReportsExportActionsSection,
      migrated278.CeoReportsFilterBarSection,
      migrated279.CeoReportsHeaderSection,
      migrated280.CeoReportsMetricsSummarySection,
      migrated281.CeoReportsScreenState,
      migrated282.CeoRevenueSummaryChartAreaSection,
      migrated283.CeoRevenueSummaryExportActionsSection,
      migrated284.CeoRevenueSummaryFilterBarSection,
      migrated285.CeoRevenueSummaryHeaderSection,
      migrated286.CeoRevenueSummaryMetricsSummarySection,
      migrated287.CeoRevenueSummaryScreenState,
      migrated288.CeoStrategicKpisChartAreaSection,
      migrated289.CeoStrategicKpisExportActionsSection,
      migrated290.CeoStrategicKpisFilterBarSection,
      migrated291.CeoStrategicKpisHeaderSection,
      migrated292.CeoStrategicKpisMetricsSummarySection,
      migrated293.CeoStrategicKpisScreenState,
      migrated294.CfoAccountsPayableActionBarSection,
      migrated295.CfoAccountsPayableDetailsFormSection,
      migrated296.CfoAccountsPayableHeaderSection,
      migrated297.CfoAccountsPayableIdentitySummarySection,
      migrated298.CfoAccountsPayablePreferencesOrDocumentsSection,
      migrated299.CfoAccountsPayableScreenState,
      migrated300.CfoAccountsReceivableActionBarSection,
      migrated301.CfoAccountsReceivableDetailsFormSection,
      migrated302.CfoAccountsReceivableHeaderSection,
      migrated303.CfoAccountsReceivableIdentitySummarySection,
      migrated304.CfoAccountsReceivablePreferencesOrDocumentsSection,
      migrated305.CfoAccountsReceivableScreenState,
      migrated306.CfoDashboardScreen,
      migrated307.CfoExpensesScreen,
      migrated308.CfoFinancialOverviewActionBarSection,
      migrated309.CfoFinancialOverviewDataTableSection,
      migrated310.CfoFinancialOverviewFilterBarSection,
      migrated311.CfoFinancialOverviewHeaderSection,
      migrated312.CfoFinancialOverviewPaginationSection,
      migrated313.CfoFinancialOverviewScreenState,
      migrated314.CfoFranchiseFinancialsActionBarSection,
      migrated315.CfoFranchiseFinancialsContentSummarySection,
      migrated316.CfoFranchiseFinancialsHeaderSection,
      migrated317.CfoFranchiseFinancialsPrimaryContentSection,
      migrated318.CfoFranchiseFinancialsScreenState,
      migrated319.CfoInvoicesScreen,
      migrated320.CfoPayrollScreen,
      migrated321.CfoProfitabilityScreen,
      migrated322.CfoReportsChartAreaSection,
      migrated323.CfoReportsExportActionsSection,
      migrated324.CfoReportsFilterBarSection,
      migrated325.CfoReportsHeaderSection,
      migrated326.CfoReportsMetricsSummarySection,
      migrated327.CfoReportsScreenState,
      migrated328.CfoRevenueScreen,
      migrated329.CfoTaxAndRemittanceActionBarSection,
      migrated330.CfoTaxAndRemittanceContentSummarySection,
      migrated331.CfoTaxAndRemittanceHeaderSection,
      migrated332.CfoTaxAndRemittancePrimaryContentSection,
      migrated333.CfoTaxAndRemittanceScreenState,
      migrated334.CisoDashboardScreen,
      migrated335.ComplianceManagerAuditsActionBarSection,
      migrated336.ComplianceManagerAuditsContentSummarySection,
      migrated337.ComplianceManagerAuditsHeaderSection,
      migrated338.ComplianceManagerAuditsPrimaryContentSection,
      migrated339.ComplianceManagerAuditsScreenState,
      migrated340.ComplianceManagerComplianceCasesActionBarSection,
      migrated341.ComplianceManagerComplianceCasesContentSummarySection,
      migrated342.ComplianceManagerComplianceCasesHeaderSection,
      migrated343.ComplianceManagerComplianceCasesPrimaryContentSection,
      migrated344.ComplianceManagerComplianceCasesScreenState,
      migrated345.ComplianceManagerCorrectiveActionsActionBarSection,
      migrated346.ComplianceManagerCorrectiveActionsHeaderSection,
      migrated347.ComplianceManagerCorrectiveActionsTaskDetailsSection,
      migrated348.ComplianceManagerCorrectiveActionsTaskFiltersSection,
      migrated349.ComplianceManagerCorrectiveActionsTaskListSection,
      migrated350.ComplianceManagerCorrectiveActionsScreenState,
      migrated351.ComplianceManagerCredentialTrackingActionBarSection,
      migrated352.ComplianceManagerCredentialTrackingContentSummarySection,
      migrated353.ComplianceManagerCredentialTrackingHeaderSection,
      migrated354.ComplianceManagerCredentialTrackingPrimaryContentSection,
      migrated355.ComplianceManagerCredentialTrackingScreenState,
      migrated356.ComplianceManagerDashboardScreen,
      migrated357.ComplianceManagerDocumentExpiryActionBarSection,
      migrated358.ComplianceManagerDocumentExpiryContentSummarySection,
      migrated359.ComplianceManagerDocumentExpiryHeaderSection,
      migrated360.ComplianceManagerDocumentExpiryPrimaryContentSection,
      migrated361.ComplianceManagerDocumentExpiryScreenState,
      migrated362.ComplianceManagerIncidentReviewActionBarSection,
      migrated363.ComplianceManagerIncidentReviewDataTableSection,
      migrated364.ComplianceManagerIncidentReviewFilterBarSection,
      migrated365.ComplianceManagerIncidentReviewHeaderSection,
      migrated366.ComplianceManagerIncidentReviewPaginationSection,
      migrated367.ComplianceManagerIncidentReviewScreenState,
      migrated368.ComplianceManagerPoliciesActionBarSection,
      migrated369.ComplianceManagerPoliciesContentSummarySection,
      migrated370.ComplianceManagerPoliciesHeaderSection,
      migrated371.ComplianceManagerPoliciesPrimaryContentSection,
      migrated372.ComplianceManagerPoliciesScreenState,
      migrated373.ComplianceManagerReportsChartAreaSection,
      migrated374.ComplianceManagerReportsExportActionsSection,
      migrated375.ComplianceManagerReportsFilterBarSection,
      migrated376.ComplianceManagerReportsHeaderSection,
      migrated377.ComplianceManagerReportsMetricsSummarySection,
      migrated378.ComplianceManagerReportsScreenState,
      migrated379.ComplianceManagerRiskRegisterActionBarSection,
      migrated380.ComplianceManagerRiskRegisterContentSummarySection,
      migrated381.ComplianceManagerRiskRegisterHeaderSection,
      migrated382.ComplianceManagerRiskRegisterPrimaryContentSection,
      migrated383.ComplianceManagerRiskRegisterScreenState,
      migrated384.ComplianceManagerTrainingComplianceActionBarSection,
      migrated385.ComplianceManagerTrainingComplianceContentSummarySection,
      migrated386.ComplianceManagerTrainingComplianceHeaderSection,
      migrated387.ComplianceManagerTrainingCompliancePrimaryContentSection,
      migrated388.ComplianceManagerTrainingComplianceScreenState,
      migrated389.CooBranchComparisonScreen,
      migrated390.CooBranchOperationsActionBarSection,
      migrated391.CooBranchOperationsContentSummarySection,
      migrated392.CooBranchOperationsHeaderSection,
      migrated393.CooBranchOperationsPrimaryContentSection,
      migrated394.CooBranchOperationsScreenState,
      migrated395.CooComplianceViewScreen,
      migrated396.CooDashboardScreen,
      migrated397.CooIssueEscalationsActionBarSection,
      migrated398.CooIssueEscalationsContentSummarySection,
      migrated399.CooIssueEscalationsHeaderSection,
      migrated400.CooIssueEscalationsPrimaryContentSection,
      migrated401.CooIssueEscalationsScreenState,
      migrated402.CooOperationsOverviewScreen,
      migrated403.CooReportsChartAreaSection,
      migrated404.CooReportsExportActionsSection,
      migrated405.CooReportsFilterBarSection,
      migrated406.CooReportsHeaderSection,
      migrated407.CooReportsMetricsSummarySection,
      migrated408.CooReportsScreenState,
      migrated409.CooSchedulingHealthScreen,
      migrated410.CooServiceDeliveryActionBarSection,
      migrated411.CooServiceDeliveryContentSummarySection,
      migrated412.CooServiceDeliveryHeaderSection,
      migrated413.CooServiceDeliveryPrimaryContentSection,
      migrated414.CooServiceDeliveryScreenState,
      migrated415.CooStaffingEfficiencyActionBarSection,
      migrated416.CooStaffingEfficiencyContentSummarySection,
      migrated417.CooStaffingEfficiencyHeaderSection,
      migrated418.CooStaffingEfficiencyPrimaryContentSection,
      migrated419.CooStaffingEfficiencyScreenState,
      migrated420.CooWorkflowPerformanceActionBarSection,
      migrated421.CooWorkflowPerformanceFormBodySection,
      migrated422.CooWorkflowPerformanceHeaderSection,
      migrated423.CooWorkflowPerformanceValidationMessagesSection,
      migrated424.CooWorkflowPerformanceScreenState,
      migrated425.CtoAccessControlActionBarSection,
      migrated426.CtoAccessControlContentSummarySection,
      migrated427.CtoAccessControlHeaderSection,
      migrated428.CtoAccessControlPrimaryContentSection,
      migrated429.CtoAccessControlScreenState,
      migrated430.CtoApiMonitoringActionBarSection,
      migrated431.CtoApiMonitoringContentSummarySection,
      migrated432.CtoApiMonitoringHeaderSection,
      migrated433.CtoApiMonitoringPrimaryContentSection,
      migrated434.CtoApiMonitoringScreenState,
      migrated435.CtoAuditLogsActionBarSection,
      migrated436.CtoAuditLogsDataTableSection,
      migrated437.CtoAuditLogsFilterBarSection,
      migrated438.CtoAuditLogsHeaderSection,
      migrated439.CtoAuditLogsPaginationSection,
      migrated440.CtoAuditLogsScreenState,
      migrated441.CtoDashboardScreen,
      migrated442.CtoFeatureAdoptionActionBarSection,
      migrated443.CtoFeatureAdoptionContentSummarySection,
      migrated444.CtoFeatureAdoptionHeaderSection,
      migrated445.CtoFeatureAdoptionPrimaryContentSection,
      migrated446.CtoFeatureAdoptionScreenState,
      migrated447.CtoInfrastructureActionBarSection,
      migrated448.CtoInfrastructureContentSummarySection,
      migrated449.CtoInfrastructureHeaderSection,
      migrated450.CtoInfrastructurePrimaryContentSection,
      migrated451.CtoInfrastructureScreenState,
      migrated452.CtoIntegrationsActionBarSection,
      migrated453.CtoIntegrationsContentSummarySection,
      migrated454.CtoIntegrationsHeaderSection,
      migrated455.CtoIntegrationsPrimaryContentSection,
      migrated456.CtoIntegrationsScreenState,
      migrated457.CtoIssueTrackingActionBarSection,
      migrated458.CtoIssueTrackingContentSummarySection,
      migrated459.CtoIssueTrackingHeaderSection,
      migrated460.CtoIssueTrackingPrimaryContentSection,
      migrated461.CtoIssueTrackingScreenState,
      migrated462.CtoPlatformUsageActionBarSection,
      migrated463.CtoPlatformUsageFormBodySection,
      migrated464.CtoPlatformUsageHeaderSection,
      migrated465.CtoPlatformUsageValidationMessagesSection,
      migrated466.CtoPlatformUsageScreenState,
      migrated467.CtoReleaseManagementActionBarSection,
      migrated468.CtoReleaseManagementContentSummarySection,
      migrated469.CtoReleaseManagementHeaderSection,
      migrated470.CtoReleaseManagementPrimaryContentSection,
      migrated471.CtoReleaseManagementScreenState,
      migrated472.CtoReportsChartAreaSection,
      migrated473.CtoReportsExportActionsSection,
      migrated474.CtoReportsFilterBarSection,
      migrated475.CtoReportsHeaderSection,
      migrated476.CtoReportsMetricsSummarySection,
      migrated477.CtoReportsScreenState,
      migrated478.CtoSystemHealthActionBarSection,
      migrated479.CtoSystemHealthContentSummarySection,
      migrated480.CtoSystemHealthHeaderSection,
      migrated481.CtoSystemHealthPrimaryContentSection,
      migrated482.CtoSystemHealthScreenState,
      migrated483.CtoSystemVerificationActionBarSection,
      migrated484.CtoSystemVerificationContentSummarySection,
      migrated485.CtoSystemVerificationHeaderSection,
      migrated486.CtoSystemVerificationPrimaryContentSection,
      migrated487.CtoSystemVerificationScreenState,
      migrated488.CtoVerificationHubActionBarSection,
      migrated489.CtoVerificationHubContentSummarySection,
      migrated490.CtoVerificationHubHeaderSection,
      migrated491.CtoVerificationHubPrimaryContentSection,
      migrated492.CtoVerificationHubScreenState,
      migrated493.CxDirectorDashboardScreen,
      migrated494.FinanceDirectorCashflowActionBarSection,
      migrated495.FinanceDirectorCashflowContentSummarySection,
      migrated496.FinanceDirectorCashflowHeaderSection,
      migrated497.FinanceDirectorCashflowPrimaryContentSection,
      migrated498.FinanceDirectorCashflowScreenState,
      migrated499.FinanceDirectorDashboardScreen,
      migrated500.HeadOfBusDevDashboardScreen,
      migrated501.HeadOfMarketingDashboardScreen,
      migrated502.HrDirectorDashboardScreen,
      migrated503.HrHiringDashboardScreen,
      migrated504.HrManagerDashboardScreen,
      migrated505.ItAdminDashboardScreen,
      migrated506.LegalDashboardScreen,
      migrated507.OwnerDashboardScreen,
      migrated508.CeoAlertsAndRisksActionBarSection,
      migrated509.CeoAlertsAndRisksContentSummarySection,
      migrated510.CeoAlertsAndRisksHeaderSection,
      migrated511.CeoAlertsAndRisksPrimaryContentSection,
      migrated512.CeoApprovalsActionBarSection,
      migrated513.CeoApprovalsContentSummarySection,
      migrated514.CeoApprovalsHeaderSection,
      migrated515.CeoApprovalsPrimaryContentSection,
      migrated516.CeoDashboardChartOverviewSection,
      migrated517.CeoDashboardHeaderSection,
      migrated518.CeoDashboardQuickActionsSection,
      migrated519.CeoDashboardRecentActivitySection,
      migrated520.CeoDashboardSummaryCardsSection,
      migrated521.CeoEnterpriseOverviewActionBarSection,
      migrated522.CeoEnterpriseOverviewDataTableSection,
      migrated523.CeoEnterpriseOverviewFilterBarSection,
      migrated524.CeoEnterpriseOverviewHeaderSection,
      migrated525.CeoEnterpriseOverviewPaginationSection,
      migrated526.CeoFranchiseOverviewActionBarSection,
      migrated527.CeoFranchiseOverviewDataTableSection,
      migrated528.CeoFranchiseOverviewFilterBarSection,
      migrated529.CeoFranchiseOverviewHeaderSection,
      migrated530.CeoFranchiseOverviewPaginationSection,
      migrated531.CeoGrowthPipelineActionBarSection,
      migrated532.CeoGrowthPipelineContentSummarySection,
      migrated533.CeoGrowthPipelineHeaderSection,
      migrated534.CeoGrowthPipelinePrimaryContentSection,
      migrated535.CeoLeadershipReportsChartAreaSection,
      migrated536.CeoLeadershipReportsExportActionsSection,
      migrated537.CeoLeadershipReportsFilterBarSection,
      migrated538.CeoLeadershipReportsHeaderSection,
      migrated539.CeoLeadershipReportsMetricsSummarySection,
      migrated540.CeoOrganizationMapActionBarSection,
      migrated541.CeoOrganizationMapContentSummarySection,
      migrated542.CeoOrganizationMapHeaderSection,
      migrated543.CeoOrganizationMapPrimaryContentSection,
      migrated544.CeoRegionPerformanceActionBarSection,
      migrated545.CeoRegionPerformanceFormBodySection,
      migrated546.CeoRegionPerformanceHeaderSection,
      migrated547.CeoRegionPerformanceValidationMessagesSection,
      migrated548.CeoReportsChartAreaSection,
      migrated549.CeoReportsExportActionsSection,
      migrated550.CeoReportsFilterBarSection,
      migrated551.CeoReportsHeaderSection,
      migrated552.CeoReportsMetricsSummarySection,
      migrated553.CeoRevenueSummaryChartAreaSection,
      migrated554.CeoRevenueSummaryExportActionsSection,
      migrated555.CeoRevenueSummaryFilterBarSection,
      migrated556.CeoRevenueSummaryHeaderSection,
      migrated557.CeoRevenueSummaryMetricsSummarySection,
      migrated558.CeoStrategicKpisChartAreaSection,
      migrated559.CeoStrategicKpisExportActionsSection,
      migrated560.CeoStrategicKpisFilterBarSection,
      migrated561.CeoStrategicKpisHeaderSection,
      migrated562.CeoStrategicKpisMetricsSummarySection,
      migrated563.CfoAccountsPayableActionBarSection,
      migrated564.CfoAccountsPayableDetailsFormSection,
      migrated565.CfoAccountsPayableHeaderSection,
      migrated566.CfoAccountsPayableIdentitySummarySection,
      migrated567.CfoAccountsPayablePreferencesOrDocumentsSection,
      migrated568.CfoAccountsReceivableActionBarSection,
      migrated569.CfoAccountsReceivableDetailsFormSection,
      migrated570.CfoAccountsReceivableHeaderSection,
      migrated571.CfoAccountsReceivableIdentitySummarySection,
      migrated572.CfoAccountsReceivablePreferencesOrDocumentsSection,
      migrated573.CfoFinancialOverviewActionBarSection,
      migrated574.CfoFinancialOverviewDataTableSection,
      migrated575.CfoFinancialOverviewFilterBarSection,
      migrated576.CfoFinancialOverviewHeaderSection,
      migrated577.CfoFinancialOverviewPaginationSection,
      migrated578.CfoFranchiseFinancialsActionBarSection,
      migrated579.CfoFranchiseFinancialsContentSummarySection,
      migrated580.CfoFranchiseFinancialsHeaderSection,
      migrated581.CfoFranchiseFinancialsPrimaryContentSection,
      migrated582.CfoReportsChartAreaSection,
      migrated583.CfoReportsExportActionsSection,
      migrated584.CfoReportsFilterBarSection,
      migrated585.CfoReportsHeaderSection,
      migrated586.CfoReportsMetricsSummarySection,
      migrated587.CfoTaxAndRemittanceActionBarSection,
      migrated588.CfoTaxAndRemittanceContentSummarySection,
      migrated589.CfoTaxAndRemittanceHeaderSection,
      migrated590.CfoTaxAndRemittancePrimaryContentSection,
      migrated591.ComplianceManagerAuditsActionBarSection,
      migrated592.ComplianceManagerAuditsContentSummarySection,
      migrated593.ComplianceManagerAuditsHeaderSection,
      migrated594.ComplianceManagerAuditsPrimaryContentSection,
      migrated595.ComplianceManagerComplianceCasesActionBarSection,
      migrated596.ComplianceManagerComplianceCasesContentSummarySection,
      migrated597.ComplianceManagerComplianceCasesHeaderSection,
      migrated598.ComplianceManagerComplianceCasesPrimaryContentSection,
      migrated599.ComplianceManagerCorrectiveActionsActionBarSection,
      migrated600.ComplianceManagerCorrectiveActionsHeaderSection,
      migrated601.ComplianceManagerCorrectiveActionsTaskDetailsSection,
      migrated602.ComplianceManagerCorrectiveActionsTaskFiltersSection,
      migrated603.ComplianceManagerCorrectiveActionsTaskListSection,
      migrated604.ComplianceManagerCredentialTrackingActionBarSection,
      migrated605.ComplianceManagerCredentialTrackingContentSummarySection,
      migrated606.ComplianceManagerCredentialTrackingHeaderSection,
      migrated607.ComplianceManagerCredentialTrackingPrimaryContentSection,
      migrated608.ComplianceManagerDocumentExpiryActionBarSection,
      migrated609.ComplianceManagerDocumentExpiryContentSummarySection,
      migrated610.ComplianceManagerDocumentExpiryHeaderSection,
      migrated611.ComplianceManagerDocumentExpiryPrimaryContentSection,
      migrated612.ComplianceManagerIncidentReviewActionBarSection,
      migrated613.ComplianceManagerIncidentReviewDataTableSection,
      migrated614.ComplianceManagerIncidentReviewFilterBarSection,
      migrated615.ComplianceManagerIncidentReviewHeaderSection,
      migrated616.ComplianceManagerIncidentReviewPaginationSection,
      migrated617.ComplianceManagerPoliciesActionBarSection,
      migrated618.ComplianceManagerPoliciesContentSummarySection,
      migrated619.ComplianceManagerPoliciesHeaderSection,
      migrated620.ComplianceManagerPoliciesPrimaryContentSection,
      migrated621.ComplianceManagerReportsChartAreaSection,
      migrated622.ComplianceManagerReportsExportActionsSection,
      migrated623.ComplianceManagerReportsFilterBarSection,
      migrated624.ComplianceManagerReportsHeaderSection,
      migrated625.ComplianceManagerReportsMetricsSummarySection,
      migrated626.ComplianceManagerRiskRegisterActionBarSection,
      migrated627.ComplianceManagerRiskRegisterContentSummarySection,
      migrated628.ComplianceManagerRiskRegisterHeaderSection,
      migrated629.ComplianceManagerRiskRegisterPrimaryContentSection,
      migrated630.ComplianceManagerTrainingComplianceActionBarSection,
      migrated631.ComplianceManagerTrainingComplianceContentSummarySection,
      migrated632.ComplianceManagerTrainingComplianceHeaderSection,
      migrated633.ComplianceManagerTrainingCompliancePrimaryContentSection,
      migrated634.CooBranchOperationsActionBarSection,
      migrated635.CooBranchOperationsContentSummarySection,
      migrated636.CooBranchOperationsHeaderSection,
      migrated637.CooBranchOperationsPrimaryContentSection,
      migrated638.CooIssueEscalationsActionBarSection,
      migrated639.CooIssueEscalationsContentSummarySection,
      migrated640.CooIssueEscalationsHeaderSection,
      migrated641.CooIssueEscalationsPrimaryContentSection,
      migrated642.CooReportsChartAreaSection,
      migrated643.CooReportsExportActionsSection,
      migrated644.CooReportsFilterBarSection,
      migrated645.CooReportsHeaderSection,
      migrated646.CooReportsMetricsSummarySection,
      migrated647.CooServiceDeliveryActionBarSection,
      migrated648.CooServiceDeliveryContentSummarySection,
      migrated649.CooServiceDeliveryHeaderSection,
      migrated650.CooServiceDeliveryPrimaryContentSection,
      migrated651.CooStaffingEfficiencyActionBarSection,
      migrated652.CooStaffingEfficiencyContentSummarySection,
      migrated653.CooStaffingEfficiencyHeaderSection,
      migrated654.CooStaffingEfficiencyPrimaryContentSection,
      migrated655.CooWorkflowPerformanceActionBarSection,
      migrated656.CooWorkflowPerformanceFormBodySection,
      migrated657.CooWorkflowPerformanceHeaderSection,
      migrated658.CooWorkflowPerformanceValidationMessagesSection,
      migrated659.CtoAccessControlActionBarSection,
      migrated660.CtoAccessControlContentSummarySection,
      migrated661.CtoAccessControlHeaderSection,
      migrated662.CtoAccessControlPrimaryContentSection,
      migrated663.CtoApiMonitoringActionBarSection,
      migrated664.CtoApiMonitoringContentSummarySection,
      migrated665.CtoApiMonitoringHeaderSection,
      migrated666.CtoApiMonitoringPrimaryContentSection,
      migrated667.CtoAuditLogsActionBarSection,
      migrated668.CtoAuditLogsDataTableSection,
      migrated669.CtoAuditLogsFilterBarSection,
      migrated670.CtoAuditLogsHeaderSection,
      migrated671.CtoAuditLogsPaginationSection,
      migrated672.CtoFeatureAdoptionActionBarSection,
      migrated673.CtoFeatureAdoptionContentSummarySection,
      migrated674.CtoFeatureAdoptionHeaderSection,
      migrated675.CtoFeatureAdoptionPrimaryContentSection,
      migrated676.CtoInfrastructureActionBarSection,
      migrated677.CtoInfrastructureContentSummarySection,
      migrated678.CtoInfrastructureHeaderSection,
      migrated679.CtoInfrastructurePrimaryContentSection,
      migrated680.CtoIntegrationsActionBarSection,
      migrated681.CtoIntegrationsContentSummarySection,
      migrated682.CtoIntegrationsHeaderSection,
      migrated683.CtoIntegrationsPrimaryContentSection,
      migrated684.CtoIssueTrackingActionBarSection,
      migrated685.CtoIssueTrackingContentSummarySection,
      migrated686.CtoIssueTrackingHeaderSection,
      migrated687.CtoIssueTrackingPrimaryContentSection,
      migrated688.CtoPlatformUsageActionBarSection,
      migrated689.CtoPlatformUsageFormBodySection,
      migrated690.CtoPlatformUsageHeaderSection,
      migrated691.CtoPlatformUsageValidationMessagesSection,
      migrated692.CtoReleaseManagementActionBarSection,
      migrated693.CtoReleaseManagementContentSummarySection,
      migrated694.CtoReleaseManagementHeaderSection,
      migrated695.CtoReleaseManagementPrimaryContentSection,
      migrated696.CtoReportsChartAreaSection,
      migrated697.CtoReportsExportActionsSection,
      migrated698.CtoReportsFilterBarSection,
      migrated699.CtoReportsHeaderSection,
      migrated700.CtoReportsMetricsSummarySection,
      migrated701.CtoSystemHealthActionBarSection,
      migrated702.CtoSystemHealthContentSummarySection,
      migrated703.CtoSystemHealthHeaderSection,
      migrated704.CtoSystemHealthPrimaryContentSection,
      migrated705.CtoSystemVerificationActionBarSection,
      migrated706.CtoSystemVerificationContentSummarySection,
      migrated707.CtoSystemVerificationHeaderSection,
      migrated708.CtoSystemVerificationPrimaryContentSection,
      migrated709.CtoVerificationHubActionBarSection,
      migrated710.CtoVerificationHubContentSummarySection,
      migrated711.CtoVerificationHubHeaderSection,
      migrated712.CtoVerificationHubPrimaryContentSection,
      migrated713.FinanceDirectorCashflowActionBarSection,
      migrated714.FinanceDirectorCashflowContentSummarySection,
      migrated715.FinanceDirectorCashflowHeaderSection,
      migrated716.FinanceDirectorCashflowPrimaryContentSection,
      migrated717.TrainingDirectorAssessmentsActionBarSection,
      migrated718.TrainingDirectorAssessmentsContentSummarySection,
      migrated719.TrainingDirectorAssessmentsHeaderSection,
      migrated720.TrainingDirectorAssessmentsPrimaryContentSection,
      migrated721.TrainingDirectorCertificatesActionBarSection,
      migrated722.TrainingDirectorCertificatesContentSummarySection,
      migrated723.TrainingDirectorCertificatesHeaderSection,
      migrated724.TrainingDirectorCertificatesPrimaryContentSection,
      migrated725.TrainingDirectorCertificationsActionBarSection,
      migrated726.TrainingDirectorCertificationsContentSummarySection,
      migrated727.TrainingDirectorCertificationsHeaderSection,
      migrated728.TrainingDirectorCertificationsPrimaryContentSection,
      migrated729.TrainingDirectorComplianceTrainingActionBarSection,
      migrated730.TrainingDirectorComplianceTrainingContentSummarySection,
      migrated731.TrainingDirectorComplianceTrainingHeaderSection,
      migrated732.TrainingDirectorComplianceTrainingPrimaryContentSection,
      migrated733.TrainingDirectorCourseArchitectActionBarSection,
      migrated734.TrainingDirectorCourseArchitectContentSummarySection,
      migrated735.TrainingDirectorCourseArchitectHeaderSection,
      migrated736.TrainingDirectorCourseArchitectPrimaryContentSection,
      migrated737.TrainingDirectorCourseLibraryActionBarSection,
      migrated738.TrainingDirectorCourseLibraryContentSummarySection,
      migrated739.TrainingDirectorCourseLibraryHeaderSection,
      migrated740.TrainingDirectorCourseLibraryPrimaryContentSection,
      migrated741.TrainingDirectorHubActionBarSection,
      migrated742.TrainingDirectorHubContentSummarySection,
      migrated743.TrainingDirectorHubHeaderSection,
      migrated744.TrainingDirectorHubPrimaryContentSection,
      migrated745.TrainingDirectorReportsChartAreaSection,
      migrated746.TrainingDirectorReportsExportActionsSection,
      migrated747.TrainingDirectorReportsFilterBarSection,
      migrated748.TrainingDirectorReportsHeaderSection,
      migrated749.TrainingDirectorReportsMetricsSummarySection,
      migrated750.TrainingDirectorStaffTrainingMatrixActionBarSection,
      migrated751.TrainingDirectorStaffTrainingMatrixContentSummarySection,
      migrated752.TrainingDirectorStaffTrainingMatrixHeaderSection,
      migrated753.TrainingDirectorStaffTrainingMatrixPrimaryContentSection,
      migrated754.TrainingDirectorTrainerAssignmentsActionBarSection,
      migrated755.TrainingDirectorTrainerAssignmentsContentSummarySection,
      migrated756.TrainingDirectorTrainerAssignmentsHeaderSection,
      migrated757.TrainingDirectorTrainerAssignmentsPrimaryContentSection,
      migrated758.TrainingDirectorTrainingProgramsActionBarSection,
      migrated759.TrainingDirectorTrainingProgramsContentSummarySection,
      migrated760.TrainingDirectorTrainingProgramsHeaderSection,
      migrated761.TrainingDirectorTrainingProgramsPrimaryContentSection,
      migrated762.ShareholderDashboardScreen,
      migrated763.TrainingDirectorAnalyticsScreen,
      migrated764.TrainingDirectorAssessmentsActionBarSection,
      migrated765.TrainingDirectorAssessmentsContentSummarySection,
      migrated766.TrainingDirectorAssessmentsHeaderSection,
      migrated767.TrainingDirectorAssessmentsPrimaryContentSection,
      migrated768.TrainingDirectorAssessmentsScreenState,
      migrated769.TrainingDirectorCertificatesActionBarSection,
      migrated770.TrainingDirectorCertificatesContentSummarySection,
      migrated771.TrainingDirectorCertificatesHeaderSection,
      migrated772.TrainingDirectorCertificatesPrimaryContentSection,
      migrated773.TrainingDirectorCertificatesScreenState,
      migrated774.TrainingDirectorCertificationsActionBarSection,
      migrated775.TrainingDirectorCertificationsContentSummarySection,
      migrated776.TrainingDirectorCertificationsHeaderSection,
      migrated777.TrainingDirectorCertificationsPrimaryContentSection,
      migrated778.TrainingDirectorCertificationsScreenState,
      migrated779.TrainingDirectorComplianceTrainingActionBarSection,
      migrated780.TrainingDirectorComplianceTrainingContentSummarySection,
      migrated781.TrainingDirectorComplianceTrainingHeaderSection,
      migrated782.TrainingDirectorComplianceTrainingPrimaryContentSection,
      migrated783.TrainingDirectorComplianceTrainingScreenState,
      migrated784.TrainingDirectorCourseArchitectActionBarSection,
      migrated785.TrainingDirectorCourseArchitectContentSummarySection,
      migrated786.TrainingDirectorCourseArchitectHeaderSection,
      migrated787.TrainingDirectorCourseArchitectPrimaryContentSection,
      migrated788.TrainingDirectorCourseArchitectScreenState,
      migrated789.TrainingDirectorCourseLibraryActionBarSection,
      migrated790.TrainingDirectorCourseLibraryContentSummarySection,
      migrated791.TrainingDirectorCourseLibraryHeaderSection,
      migrated792.TrainingDirectorCourseLibraryPrimaryContentSection,
      migrated793.TrainingDirectorCourseLibraryScreenState,
      migrated794.TrainingDirectorDashboardScreen,
      migrated795.TrainingDirectorHubActionBarSection,
      migrated796.TrainingDirectorHubContentSummarySection,
      migrated797.TrainingDirectorHubHeaderSection,
      migrated798.TrainingDirectorHubPrimaryContentSection,
      migrated799.TrainingDirectorHubScreenState,
      migrated800.TrainingDirectorReportsChartAreaSection,
      migrated801.TrainingDirectorReportsExportActionsSection,
      migrated802.TrainingDirectorReportsFilterBarSection,
      migrated803.TrainingDirectorReportsHeaderSection,
      migrated804.TrainingDirectorReportsMetricsSummarySection,
      migrated805.TrainingDirectorReportsScreenState,
      migrated806.TrainingDirectorStaffTrainingMatrixActionBarSection,
      migrated807.TrainingDirectorStaffTrainingMatrixContentSummarySection,
      migrated808.TrainingDirectorStaffTrainingMatrixHeaderSection,
      migrated809.TrainingDirectorStaffTrainingMatrixPrimaryContentSection,
      migrated810.TrainingDirectorStaffTrainingMatrixScreenState,
      migrated811.TrainingDirectorTrainerAssignmentsActionBarSection,
      migrated812.TrainingDirectorTrainerAssignmentsContentSummarySection,
      migrated813.TrainingDirectorTrainerAssignmentsHeaderSection,
      migrated814.TrainingDirectorTrainerAssignmentsPrimaryContentSection,
      migrated815.TrainingDirectorTrainerAssignmentsScreenState,
      migrated816.TrainingDirectorTrainingProgramsActionBarSection,
      migrated817.TrainingDirectorTrainingProgramsContentSummarySection,
      migrated818.TrainingDirectorTrainingProgramsHeaderSection,
      migrated819.TrainingDirectorTrainingProgramsPrimaryContentSection,
      migrated820.TrainingDirectorTrainingProgramsScreenState,
      migrated821.VolunteerCoordinatorDashboardScreen,
      migrated822.HrDirectorDashboardScreen,
      migrated823.HrHiringDashboardScreen,
      migrated824.HrManagerDashboardScreen,
      migrated825.ItAdminDashboardChartOverviewSection,
      migrated826.ItAdminDashboardHeaderSection,
      migrated827.ItAdminDashboardQuickActionsSection,
      migrated828.ItAdminDashboardRecentActivitySection,
      migrated829.ItAdminDashboardSummaryCardsSection,
      migrated830.ItAdminDashboardScreenState,
      migrated831.ItAdminDashboardChartOverviewSection,
      migrated832.ItAdminDashboardHeaderSection,
      migrated833.ItAdminDashboardQuickActionsSection,
      migrated834.ItAdminDashboardRecentActivitySection,
      migrated835.ItAdminDashboardSummaryCardsSection,
      migrated836.LegalDashboardScreen,
      migrated837.HeadOfMarketingDashboardScreen,
      migrated838.OwnerDashboardScreen,
      migrated839.ShareholderDashboardScreen,
      migrated840.AssessmentsActionBarSection,
      migrated841.AssessmentsContentSummarySection,
      migrated842.AssessmentsHeaderSection,
      migrated843.AssessmentsPrimaryContentSection,
      migrated844.AssessmentsScreenState,
      migrated845.CertificatesActionBarSection,
      migrated846.CertificatesContentSummarySection,
      migrated847.CertificatesHeaderSection,
      migrated848.CertificatesPrimaryContentSection,
      migrated849.CertificatesScreenState,
      migrated850.CertificationsActionBarSection,
      migrated851.CertificationsContentSummarySection,
      migrated852.CertificationsHeaderSection,
      migrated853.CertificationsPrimaryContentSection,
      migrated854.CertificationsScreenState,
      migrated855.ComplianceTrainingActionBarSection,
      migrated856.ComplianceTrainingContentSummarySection,
      migrated857.ComplianceTrainingHeaderSection,
      migrated858.ComplianceTrainingPrimaryContentSection,
      migrated859.ComplianceTrainingScreenState,
      migrated860.CourseArchitectActionBarSection,
      migrated861.CourseArchitectContentSummarySection,
      migrated862.CourseArchitectHeaderSection,
      migrated863.CourseArchitectPrimaryContentSection,
      migrated864.CourseArchitectScreenState,
      migrated865.CourseLibraryActionBarSection,
      migrated866.CourseLibraryContentSummarySection,
      migrated867.CourseLibraryHeaderSection,
      migrated868.CourseLibraryPrimaryContentSection,
      migrated869.CourseLibraryScreenState,
      migrated870.AssessmentsActionBarSection,
      migrated871.AssessmentsContentSummarySection,
      migrated872.AssessmentsHeaderSection,
      migrated873.AssessmentsPrimaryContentSection,
      migrated874.CertificatesActionBarSection,
      migrated875.CertificatesContentSummarySection,
      migrated876.CertificatesHeaderSection,
      migrated877.CertificatesPrimaryContentSection,
      migrated878.CertificationsActionBarSection,
      migrated879.CertificationsContentSummarySection,
      migrated880.CertificationsHeaderSection,
      migrated881.CertificationsPrimaryContentSection,
      migrated882.ComplianceTrainingActionBarSection,
      migrated883.ComplianceTrainingContentSummarySection,
      migrated884.ComplianceTrainingHeaderSection,
      migrated885.ComplianceTrainingPrimaryContentSection,
      migrated886.CourseArchitectActionBarSection,
      migrated887.CourseArchitectContentSummarySection,
      migrated888.CourseArchitectHeaderSection,
      migrated889.CourseArchitectPrimaryContentSection,
      migrated890.CourseLibraryActionBarSection,
      migrated891.CourseLibraryContentSummarySection,
      migrated892.CourseLibraryHeaderSection,
      migrated893.CourseLibraryPrimaryContentSection,
      migrated894.StaffTrainingMatrixActionBarSection,
      migrated895.StaffTrainingMatrixContentSummarySection,
      migrated896.StaffTrainingMatrixHeaderSection,
      migrated897.StaffTrainingMatrixPrimaryContentSection,
      migrated898.TrainerAssignmentsActionBarSection,
      migrated899.TrainerAssignmentsContentSummarySection,
      migrated900.TrainerAssignmentsHeaderSection,
      migrated901.TrainerAssignmentsPrimaryContentSection,
      migrated902.TrainingAnalyticsChartAreaSection,
      migrated903.TrainingAnalyticsExportActionsSection,
      migrated904.TrainingAnalyticsFilterBarSection,
      migrated905.TrainingAnalyticsHeaderSection,
      migrated906.TrainingAnalyticsMetricsSummarySection,
      migrated907.TrainingHubActionBarSection,
      migrated908.TrainingHubContentSummarySection,
      migrated909.TrainingHubHeaderSection,
      migrated910.TrainingHubPrimaryContentSection,
      migrated911.TrainingProgramsActionBarSection,
      migrated912.TrainingProgramsContentSummarySection,
      migrated913.TrainingProgramsHeaderSection,
      migrated914.TrainingProgramsPrimaryContentSection,
      migrated915.TrainingReportsChartAreaSection,
      migrated916.TrainingReportsExportActionsSection,
      migrated917.TrainingReportsFilterBarSection,
      migrated918.TrainingReportsHeaderSection,
      migrated919.TrainingReportsMetricsSummarySection,
      migrated920.StaffTrainingMatrixActionBarSection,
      migrated921.StaffTrainingMatrixContentSummarySection,
      migrated922.StaffTrainingMatrixHeaderSection,
      migrated923.StaffTrainingMatrixPrimaryContentSection,
      migrated924.StaffTrainingMatrixScreenState,
      migrated925.TrainerAssignmentsActionBarSection,
      migrated926.TrainerAssignmentsContentSummarySection,
      migrated927.TrainerAssignmentsHeaderSection,
      migrated928.TrainerAssignmentsPrimaryContentSection,
      migrated929.TrainerAssignmentsScreenState,
      migrated930.TrainingAnalyticsChartAreaSection,
      migrated931.TrainingAnalyticsExportActionsSection,
      migrated932.TrainingAnalyticsFilterBarSection,
      migrated933.TrainingAnalyticsHeaderSection,
      migrated934.TrainingAnalyticsMetricsSummarySection,
      migrated935.TrainingAnalyticsScreenState,
      migrated936.TrainingDirectorDashboardScreen,
      migrated937.TrainingHubActionBarSection,
      migrated938.TrainingHubContentSummarySection,
      migrated939.TrainingHubHeaderSection,
      migrated940.TrainingHubPrimaryContentSection,
      migrated941.TrainingHubScreenState,
      migrated942.TrainingProgramsActionBarSection,
      migrated943.TrainingProgramsContentSummarySection,
      migrated944.TrainingProgramsHeaderSection,
      migrated945.TrainingProgramsPrimaryContentSection,
      migrated946.TrainingProgramsScreenState,
      migrated947.TrainingReportsChartAreaSection,
      migrated948.TrainingReportsExportActionsSection,
      migrated949.TrainingReportsFilterBarSection,
      migrated950.TrainingReportsHeaderSection,
      migrated951.TrainingReportsMetricsSummarySection,
      migrated952.TrainingReportsScreenState,
      migrated953.VolunteerCoordinatorDashboardScreen,
    ];
    expect(migratedTypes, hasLength(954));
  });
}
