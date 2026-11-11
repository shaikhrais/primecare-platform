// Compilation does not establish screen/runtime readiness.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/screens/executive/revenue_analytics/sections/revenue_analytics_header_section.dart' as section0;
import 'package:primecare_ui/src/screens/executive/revenue_analytics/sections/revenue_analytics_metrics_summary_section.dart' as section1;
import 'package:primecare_ui/src/screens/executive/revenue_snapshot/sections/revenue_snapshot_action_bar_section.dart' as section2;
import 'package:primecare_ui/src/screens/executive/revenue_snapshot/sections/revenue_snapshot_content_summary_section.dart' as section3;
import 'package:primecare_ui/src/screens/executive/revenue_snapshot/sections/revenue_snapshot_header_section.dart' as section4;
import 'package:primecare_ui/src/screens/executive/revenue_snapshot/sections/revenue_snapshot_primary_content_section.dart' as section5;
import 'package:primecare_ui/src/screens/executive/risk_management/sections/risk_management_action_bar_section.dart' as section6;
import 'package:primecare_ui/src/screens/executive/risk_management/sections/risk_management_content_summary_section.dart' as section7;
import 'package:primecare_ui/src/screens/executive/risk_management/sections/risk_management_header_section.dart' as section8;
import 'package:primecare_ui/src/screens/executive/risk_management/sections/risk_management_primary_content_section.dart' as section9;
import 'package:primecare_ui/src/screens/executive/security_audit/sections/security_audit_action_bar_section.dart' as section10;
import 'package:primecare_ui/src/screens/executive/security_audit/sections/security_audit_content_summary_section.dart' as section11;
import 'package:primecare_ui/src/screens/executive/security_audit/sections/security_audit_header_section.dart' as section12;
import 'package:primecare_ui/src/screens/executive/security_audit/sections/security_audit_primary_content_section.dart' as section13;
import 'package:primecare_ui/src/screens/executive/service_quality/sections/service_quality_action_bar_section.dart' as section14;
import 'package:primecare_ui/src/screens/executive/service_quality/sections/service_quality_content_summary_section.dart' as section15;
import 'package:primecare_ui/src/screens/executive/service_quality/sections/service_quality_header_section.dart' as section16;
import 'package:primecare_ui/src/screens/executive/service_quality/sections/service_quality_primary_content_section.dart' as section17;
import 'package:primecare_ui/src/screens/executive/shareholder_analytics/sections/shareholder_analytics_chart_area_section.dart' as section18;
import 'package:primecare_ui/src/screens/executive/shareholder_analytics/sections/shareholder_analytics_export_actions_section.dart' as section19;
import 'package:primecare_ui/src/screens/executive/shareholder_analytics/sections/shareholder_analytics_filter_bar_section.dart' as section20;
import 'package:primecare_ui/src/screens/executive/shareholder_analytics/sections/shareholder_analytics_header_section.dart' as section21;
import 'package:primecare_ui/src/screens/executive/shareholder_analytics/sections/shareholder_analytics_metrics_summary_section.dart' as section22;
import 'package:primecare_ui/src/screens/executive/shareholder_compliance/sections/shareholder_compliance_action_bar_section.dart' as section23;
import 'package:primecare_ui/src/screens/executive/shareholder_compliance/sections/shareholder_compliance_content_summary_section.dart' as section24;
import 'package:primecare_ui/src/screens/executive/shareholder_compliance/sections/shareholder_compliance_header_section.dart' as section25;
import 'package:primecare_ui/src/screens/executive/shareholder_compliance/sections/shareholder_compliance_primary_content_section.dart' as section26;
import 'package:primecare_ui/src/screens/executive/shareholder_workflow/sections/shareholder_workflow_action_bar_section.dart' as section27;
import 'package:primecare_ui/src/screens/executive/shareholder_workflow/sections/shareholder_workflow_header_section.dart' as section28;
import 'package:primecare_ui/src/screens/executive/shareholder_workflow/sections/shareholder_workflow_task_details_section.dart' as section29;
import 'package:primecare_ui/src/screens/executive/shareholder_workflow/sections/shareholder_workflow_task_filters_section.dart' as section30;
import 'package:primecare_ui/src/screens/executive/shareholder_workflow/sections/shareholder_workflow_task_list_section.dart' as section31;
import 'package:primecare_ui/src/screens/executive/staff_management/sections/staff_management_action_bar_section.dart' as section32;
import 'package:primecare_ui/src/screens/executive/staff_management/sections/staff_management_content_summary_section.dart' as section33;
import 'package:primecare_ui/src/screens/executive/staff_management/sections/staff_management_header_section.dart' as section34;
import 'package:primecare_ui/src/screens/executive/staff_management/sections/staff_management_primary_content_section.dart' as section35;
import 'package:primecare_ui/src/screens/executive/staffing_overview/sections/staffing_overview_action_bar_section.dart' as section36;
import 'package:primecare_ui/src/screens/executive/staffing_overview/sections/staffing_overview_data_table_section.dart' as section37;
import 'package:primecare_ui/src/screens/executive/staffing_overview/sections/staffing_overview_filter_bar_section.dart' as section38;
import 'package:primecare_ui/src/screens/executive/staffing_overview/sections/staffing_overview_header_section.dart' as section39;
import 'package:primecare_ui/src/screens/executive/staffing_overview/sections/staffing_overview_pagination_section.dart' as section40;
import 'package:primecare_ui/src/screens/executive/system_health/sections/system_health_action_bar_section.dart' as section41;
import 'package:primecare_ui/src/screens/executive/system_health/sections/system_health_content_summary_section.dart' as section42;
import 'package:primecare_ui/src/screens/executive/system_health/sections/system_health_header_section.dart' as section43;
import 'package:primecare_ui/src/screens/executive/system_health/sections/system_health_primary_content_section.dart' as section44;
import 'package:primecare_ui/src/screens/executive/tax_compliance/sections/tax_compliance_action_bar_section.dart' as section45;
import 'package:primecare_ui/src/screens/executive/tax_compliance/sections/tax_compliance_content_summary_section.dart' as section46;
import 'package:primecare_ui/src/screens/executive/tax_compliance/sections/tax_compliance_header_section.dart' as section47;
import 'package:primecare_ui/src/screens/executive/tax_compliance/sections/tax_compliance_primary_content_section.dart' as section48;
import 'package:primecare_ui/src/screens/executive/training_director_analytics/sections/training_director_analytics_chart_area_section.dart' as section49;
import 'package:primecare_ui/src/screens/executive/training_director_analytics/sections/training_director_analytics_export_actions_section.dart' as section50;
import 'package:primecare_ui/src/screens/executive/training_director_analytics/sections/training_director_analytics_filter_bar_section.dart' as section51;
import 'package:primecare_ui/src/screens/executive/training_director_analytics/sections/training_director_analytics_header_section.dart' as section52;
import 'package:primecare_ui/src/screens/executive/training_director_analytics/sections/training_director_analytics_metrics_summary_section.dart' as section53;
import 'package:primecare_ui/src/screens/executive/training_director_compliance/sections/training_director_compliance_action_bar_section.dart' as section54;
import 'package:primecare_ui/src/screens/executive/training_director_compliance/sections/training_director_compliance_content_summary_section.dart' as section55;
import 'package:primecare_ui/src/screens/executive/training_director_compliance/sections/training_director_compliance_header_section.dart' as section56;
import 'package:primecare_ui/src/screens/executive/training_director_compliance/sections/training_director_compliance_primary_content_section.dart' as section57;
import 'package:primecare_ui/src/screens/executive/training_director_dashboard/sections/training_director_dashboard_chart_overview_section.dart' as section58;
import 'package:primecare_ui/src/screens/executive/training_director_dashboard/sections/training_director_dashboard_header_section.dart' as section59;
import 'package:primecare_ui/src/screens/executive/training_director_dashboard/sections/training_director_dashboard_quick_actions_section.dart' as section60;
import 'package:primecare_ui/src/screens/executive/training_director_dashboard/sections/training_director_dashboard_recent_activity_section.dart' as section61;
import 'package:primecare_ui/src/screens/executive/training_director_dashboard/sections/training_director_dashboard_summary_cards_section.dart' as section62;
import 'package:primecare_ui/src/screens/executive/training_director_workflow/sections/training_director_workflow_action_bar_section.dart' as section63;
import 'package:primecare_ui/src/screens/executive/training_director_workflow/sections/training_director_workflow_header_section.dart' as section64;
import 'package:primecare_ui/src/screens/executive/training_director_workflow/sections/training_director_workflow_task_details_section.dart' as section65;
import 'package:primecare_ui/src/screens/executive/training_director_workflow/sections/training_director_workflow_task_filters_section.dart' as section66;
import 'package:primecare_ui/src/screens/executive/training_director_workflow/sections/training_director_workflow_task_list_section.dart' as section67;
import 'package:primecare_ui/src/screens/executive/vip_manager_analytics/sections/vip_manager_analytics_chart_area_section.dart' as section68;
import 'package:primecare_ui/src/screens/executive/vip_manager_analytics/sections/vip_manager_analytics_export_actions_section.dart' as section69;
import 'package:primecare_ui/src/screens/executive/vip_manager_analytics/sections/vip_manager_analytics_filter_bar_section.dart' as section70;
import 'package:primecare_ui/src/screens/executive/vip_manager_analytics/sections/vip_manager_analytics_header_section.dart' as section71;
import 'package:primecare_ui/src/screens/executive/vip_manager_analytics/sections/vip_manager_analytics_metrics_summary_section.dart' as section72;
import 'package:primecare_ui/src/screens/executive/vip_manager_workflow/sections/vip_manager_workflow_action_bar_section.dart' as section73;
import 'package:primecare_ui/src/screens/executive/vip_manager_workflow/sections/vip_manager_workflow_header_section.dart' as section74;
import 'package:primecare_ui/src/screens/executive/vip_manager_workflow/sections/vip_manager_workflow_task_details_section.dart' as section75;
import 'package:primecare_ui/src/screens/executive/vip_manager_workflow/sections/vip_manager_workflow_task_filters_section.dart' as section76;
import 'package:primecare_ui/src/screens/executive/vip_manager_workflow/sections/vip_manager_workflow_task_list_section.dart' as section77;
import 'package:primecare_ui/src/screens/executive/workflow_issue/sections/workflow_issue_action_bar_section.dart' as section78;
import 'package:primecare_ui/src/screens/executive/workflow_issue/sections/workflow_issue_header_section.dart' as section79;
import 'package:primecare_ui/src/screens/executive/workflow_issue/sections/workflow_issue_task_details_section.dart' as section80;
import 'package:primecare_ui/src/screens/executive/workflow_issue/sections/workflow_issue_task_filters_section.dart' as section81;
import 'package:primecare_ui/src/screens/executive/workflow_issue/sections/workflow_issue_task_list_section.dart' as section82;
import 'package:primecare_ui/src/screens/management/attendance/sections/attendance_action_bar_section.dart' as section83;
import 'package:primecare_ui/src/screens/management/attendance/sections/attendance_content_summary_section.dart' as section84;
import 'package:primecare_ui/src/screens/management/attendance/sections/attendance_header_section.dart' as section85;
import 'package:primecare_ui/src/screens/management/attendance/sections/attendance_primary_content_section.dart' as section86;
import 'package:primecare_ui/src/screens/management/audit_review/sections/audit_review_action_bar_section.dart' as section87;
import 'package:primecare_ui/src/screens/management/audit_review/sections/audit_review_data_table_section.dart' as section88;
import 'package:primecare_ui/src/screens/management/audit_review/sections/audit_review_filter_bar_section.dart' as section89;
import 'package:primecare_ui/src/screens/management/audit_review/sections/audit_review_header_section.dart' as section90;
import 'package:primecare_ui/src/screens/management/audit_review/sections/audit_review_pagination_section.dart' as section91;
import 'package:primecare_ui/src/screens/management/brand_management/sections/brand_management_action_bar_section.dart' as section92;
import 'package:primecare_ui/src/screens/management/brand_management/sections/brand_management_content_summary_section.dart' as section93;
import 'package:primecare_ui/src/screens/management/brand_management/sections/brand_management_header_section.dart' as section94;
import 'package:primecare_ui/src/screens/management/brand_management/sections/brand_management_primary_content_section.dart' as section95;
import 'package:primecare_ui/src/screens/management/campaign_dashboard/sections/campaign_dashboard_chart_overview_section.dart' as section96;
import 'package:primecare_ui/src/screens/management/campaign_dashboard/sections/campaign_dashboard_header_section.dart' as section97;
import 'package:primecare_ui/src/screens/management/campaign_dashboard/sections/campaign_dashboard_quick_actions_section.dart' as section98;
import 'package:primecare_ui/src/screens/management/campaign_dashboard/sections/campaign_dashboard_recent_activity_section.dart' as section99;
import 'package:primecare_ui/src/screens/management/campaign_dashboard/sections/campaign_dashboard_summary_cards_section.dart' as section100;
import 'package:primecare_ui/src/screens/management/community_outreach_compliance/sections/community_outreach_compliance_action_bar_section.dart' as section101;
import 'package:primecare_ui/src/screens/management/community_outreach_compliance/sections/community_outreach_compliance_content_summary_section.dart' as section102;
import 'package:primecare_ui/src/screens/management/community_outreach_compliance/sections/community_outreach_compliance_header_section.dart' as section103;
import 'package:primecare_ui/src/screens/management/community_outreach_compliance/sections/community_outreach_compliance_primary_content_section.dart' as section104;
import 'package:primecare_ui/src/screens/management/community_outreach_dashboard/sections/community_outreach_dashboard_chart_overview_section.dart' as section105;
import 'package:primecare_ui/src/screens/management/community_outreach_dashboard/sections/community_outreach_dashboard_header_section.dart' as section106;
import 'package:primecare_ui/src/screens/management/community_outreach_dashboard/sections/community_outreach_dashboard_quick_actions_section.dart' as section107;
import 'package:primecare_ui/src/screens/management/community_outreach_dashboard/sections/community_outreach_dashboard_recent_activity_section.dart' as section108;
import 'package:primecare_ui/src/screens/management/community_outreach_dashboard/sections/community_outreach_dashboard_summary_cards_section.dart' as section109;
import 'package:primecare_ui/src/screens/management/compliance_dashboard/sections/compliance_dashboard_chart_overview_section.dart' as section110;
import 'package:primecare_ui/src/screens/management/compliance_dashboard/sections/compliance_dashboard_header_section.dart' as section111;
import 'package:primecare_ui/src/screens/management/compliance_dashboard/sections/compliance_dashboard_quick_actions_section.dart' as section112;
import 'package:primecare_ui/src/screens/management/compliance_dashboard/sections/compliance_dashboard_recent_activity_section.dart' as section113;
import 'package:primecare_ui/src/screens/management/compliance_dashboard/sections/compliance_dashboard_summary_cards_section.dart' as section114;
import 'package:primecare_ui/src/screens/management/compliance_manager_analytics/sections/compliance_manager_analytics_chart_area_section.dart' as section115;
import 'package:primecare_ui/src/screens/management/compliance_manager_analytics/sections/compliance_manager_analytics_export_actions_section.dart' as section116;
import 'package:primecare_ui/src/screens/management/compliance_manager_analytics/sections/compliance_manager_analytics_filter_bar_section.dart' as section117;
import 'package:primecare_ui/src/screens/management/compliance_manager_analytics/sections/compliance_manager_analytics_header_section.dart' as section118;
import 'package:primecare_ui/src/screens/management/compliance_manager_analytics/sections/compliance_manager_analytics_metrics_summary_section.dart' as section119;
import 'package:primecare_ui/src/screens/management/compliance_manager_compliance/sections/compliance_manager_compliance_action_bar_section.dart' as section120;
import 'package:primecare_ui/src/screens/management/compliance_manager_compliance/sections/compliance_manager_compliance_content_summary_section.dart' as section121;
import 'package:primecare_ui/src/screens/management/compliance_manager_compliance/sections/compliance_manager_compliance_header_section.dart' as section122;
import 'package:primecare_ui/src/screens/management/compliance_manager_compliance/sections/compliance_manager_compliance_primary_content_section.dart' as section123;
import 'package:primecare_ui/src/screens/management/compliance_manager_dashboard/sections/compliance_manager_dashboard_chart_overview_section.dart' as section124;
import 'package:primecare_ui/src/screens/management/compliance_manager_dashboard/sections/compliance_manager_dashboard_header_section.dart' as section125;
import 'package:primecare_ui/src/screens/management/compliance_manager_dashboard/sections/compliance_manager_dashboard_quick_actions_section.dart' as section126;
import 'package:primecare_ui/src/screens/management/compliance_manager_dashboard/sections/compliance_manager_dashboard_recent_activity_section.dart' as section127;
import 'package:primecare_ui/src/screens/management/compliance_manager_dashboard/sections/compliance_manager_dashboard_summary_cards_section.dart' as section128;
import 'package:primecare_ui/src/screens/management/compliance_manager_workflow/sections/compliance_manager_workflow_action_bar_section.dart' as section129;
import 'package:primecare_ui/src/screens/management/compliance_manager_workflow/sections/compliance_manager_workflow_header_section.dart' as section130;
import 'package:primecare_ui/src/screens/management/compliance_manager_workflow/sections/compliance_manager_workflow_task_details_section.dart' as section131;
import 'package:primecare_ui/src/screens/management/compliance_manager_workflow/sections/compliance_manager_workflow_task_filters_section.dart' as section132;
import 'package:primecare_ui/src/screens/management/compliance_manager_workflow/sections/compliance_manager_workflow_task_list_section.dart' as section133;
import 'package:primecare_ui/src/screens/management/corrective_action/sections/corrective_action_action_bar_section.dart' as section134;
import 'package:primecare_ui/src/screens/management/corrective_action/sections/corrective_action_header_section.dart' as section135;
import 'package:primecare_ui/src/screens/management/corrective_action/sections/corrective_action_task_details_section.dart' as section136;
import 'package:primecare_ui/src/screens/management/corrective_action/sections/corrective_action_task_filters_section.dart' as section137;
import 'package:primecare_ui/src/screens/management/corrective_action/sections/corrective_action_task_list_section.dart' as section138;
import 'package:primecare_ui/src/screens/management/credential_expiry/sections/credential_expiry_action_bar_section.dart' as section139;
import 'package:primecare_ui/src/screens/management/credential_expiry/sections/credential_expiry_content_summary_section.dart' as section140;
import 'package:primecare_ui/src/screens/management/credential_expiry/sections/credential_expiry_header_section.dart' as section141;
import 'package:primecare_ui/src/screens/management/credential_expiry/sections/credential_expiry_primary_content_section.dart' as section142;
import 'package:primecare_ui/src/screens/management/daily_operations/sections/daily_operations_action_bar_section.dart' as section143;
import 'package:primecare_ui/src/screens/management/daily_operations/sections/daily_operations_content_summary_section.dart' as section144;
import 'package:primecare_ui/src/screens/management/daily_operations/sections/daily_operations_header_section.dart' as section145;
import 'package:primecare_ui/src/screens/management/daily_operations/sections/daily_operations_primary_content_section.dart' as section146;
import 'package:primecare_ui/src/screens/management/employee_records/sections/employee_records_action_bar_section.dart' as section147;
import 'package:primecare_ui/src/screens/management/employee_records/sections/employee_records_data_table_section.dart' as section148;
import 'package:primecare_ui/src/screens/management/employee_records/sections/employee_records_filter_bar_section.dart' as section149;
import 'package:primecare_ui/src/screens/management/employee_records/sections/employee_records_header_section.dart' as section150;
import 'package:primecare_ui/src/screens/management/employee_records/sections/employee_records_pagination_section.dart' as section151;
import 'package:primecare_ui/src/screens/management/franchise_lead/sections/franchise_lead_action_bar_section.dart' as section152;
import 'package:primecare_ui/src/screens/management/franchise_lead/sections/franchise_lead_content_summary_section.dart' as section153;
import 'package:primecare_ui/src/screens/management/franchise_lead/sections/franchise_lead_header_section.dart' as section154;
import 'package:primecare_ui/src/screens/management/franchise_lead/sections/franchise_lead_primary_content_section.dart' as section155;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_analytics/sections/franchise_sales_manager_analytics_chart_area_section.dart' as section156;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_analytics/sections/franchise_sales_manager_analytics_export_actions_section.dart' as section157;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_analytics/sections/franchise_sales_manager_analytics_filter_bar_section.dart' as section158;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_analytics/sections/franchise_sales_manager_analytics_header_section.dart' as section159;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_analytics/sections/franchise_sales_manager_analytics_metrics_summary_section.dart' as section160;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_compliance/sections/franchise_sales_manager_compliance_action_bar_section.dart' as section161;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_compliance/sections/franchise_sales_manager_compliance_content_summary_section.dart' as section162;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_compliance/sections/franchise_sales_manager_compliance_header_section.dart' as section163;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_compliance/sections/franchise_sales_manager_compliance_primary_content_section.dart' as section164;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_dashboard/sections/franchise_sales_manager_dashboard_chart_overview_section.dart' as section165;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_dashboard/sections/franchise_sales_manager_dashboard_header_section.dart' as section166;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_dashboard/sections/franchise_sales_manager_dashboard_quick_actions_section.dart' as section167;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_dashboard/sections/franchise_sales_manager_dashboard_recent_activity_section.dart' as section168;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_dashboard/sections/franchise_sales_manager_dashboard_summary_cards_section.dart' as section169;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_workflow/sections/franchise_sales_manager_workflow_action_bar_section.dart' as section170;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_workflow/sections/franchise_sales_manager_workflow_header_section.dart' as section171;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_workflow/sections/franchise_sales_manager_workflow_task_details_section.dart' as section172;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_workflow/sections/franchise_sales_manager_workflow_task_filters_section.dart' as section173;
import 'package:primecare_ui/src/screens/management/franchise_sales_manager_workflow/sections/franchise_sales_manager_workflow_task_list_section.dart' as section174;
import 'package:primecare_ui/src/screens/management/general_manager_analytics/sections/general_manager_analytics_chart_area_section.dart' as section175;
import 'package:primecare_ui/src/screens/management/general_manager_analytics/sections/general_manager_analytics_export_actions_section.dart' as section176;
import 'package:primecare_ui/src/screens/management/general_manager_analytics/sections/general_manager_analytics_filter_bar_section.dart' as section177;
import 'package:primecare_ui/src/screens/management/general_manager_analytics/sections/general_manager_analytics_header_section.dart' as section178;
import 'package:primecare_ui/src/screens/management/general_manager_analytics/sections/general_manager_analytics_metrics_summary_section.dart' as section179;
import 'package:primecare_ui/src/screens/management/general_manager_compliance/sections/general_manager_compliance_action_bar_section.dart' as section180;
import 'package:primecare_ui/src/screens/management/general_manager_compliance/sections/general_manager_compliance_content_summary_section.dart' as section181;
import 'package:primecare_ui/src/screens/management/general_manager_compliance/sections/general_manager_compliance_header_section.dart' as section182;
import 'package:primecare_ui/src/screens/management/general_manager_compliance/sections/general_manager_compliance_primary_content_section.dart' as section183;
import 'package:primecare_ui/src/screens/management/general_manager_dashboard/sections/general_manager_dashboard_chart_overview_section.dart' as section184;
import 'package:primecare_ui/src/screens/management/general_manager_dashboard/sections/general_manager_dashboard_header_section.dart' as section185;
import 'package:primecare_ui/src/screens/management/general_manager_dashboard/sections/general_manager_dashboard_quick_actions_section.dart' as section186;
import 'package:primecare_ui/src/screens/management/general_manager_dashboard/sections/general_manager_dashboard_recent_activity_section.dart' as section187;
import 'package:primecare_ui/src/screens/management/general_manager_dashboard/sections/general_manager_dashboard_summary_cards_section.dart' as section188;
import 'package:primecare_ui/src/screens/management/general_manager_workflow/sections/general_manager_workflow_action_bar_section.dart' as section189;
import 'package:primecare_ui/src/screens/management/general_manager_workflow/sections/general_manager_workflow_header_section.dart' as section190;
import 'package:primecare_ui/src/screens/management/general_manager_workflow/sections/general_manager_workflow_task_details_section.dart' as section191;
import 'package:primecare_ui/src/screens/management/general_manager_workflow/sections/general_manager_workflow_task_filters_section.dart' as section192;
import 'package:primecare_ui/src/screens/management/general_manager_workflow/sections/general_manager_workflow_task_list_section.dart' as section193;
import 'package:primecare_ui/src/screens/management/governance_officer_analytics/sections/governance_officer_analytics_chart_area_section.dart' as section194;
import 'package:primecare_ui/src/screens/management/governance_officer_analytics/sections/governance_officer_analytics_export_actions_section.dart' as section195;
import 'package:primecare_ui/src/screens/management/governance_officer_analytics/sections/governance_officer_analytics_filter_bar_section.dart' as section196;
import 'package:primecare_ui/src/screens/management/governance_officer_analytics/sections/governance_officer_analytics_header_section.dart' as section197;
import 'package:primecare_ui/src/screens/management/governance_officer_analytics/sections/governance_officer_analytics_metrics_summary_section.dart' as section198;
import 'package:primecare_ui/src/screens/management/governance_officer_compliance/sections/governance_officer_compliance_action_bar_section.dart' as section199;
import 'package:primecare_ui/src/screens/management/governance_officer_compliance/sections/governance_officer_compliance_content_summary_section.dart' as section200;
import 'package:primecare_ui/src/screens/management/governance_officer_compliance/sections/governance_officer_compliance_header_section.dart' as section201;
import 'package:primecare_ui/src/screens/management/governance_officer_compliance/sections/governance_officer_compliance_primary_content_section.dart' as section202;
import 'package:primecare_ui/src/screens/management/governance_officer_dashboard/sections/governance_officer_dashboard_chart_overview_section.dart' as section203;
import 'package:primecare_ui/src/screens/management/governance_officer_dashboard/sections/governance_officer_dashboard_header_section.dart' as section204;
import 'package:primecare_ui/src/screens/management/governance_officer_dashboard/sections/governance_officer_dashboard_quick_actions_section.dart' as section205;
import 'package:primecare_ui/src/screens/management/governance_officer_dashboard/sections/governance_officer_dashboard_recent_activity_section.dart' as section206;
import 'package:primecare_ui/src/screens/management/governance_officer_dashboard/sections/governance_officer_dashboard_summary_cards_section.dart' as section207;
import 'package:primecare_ui/src/screens/management/governance_officer_workflow/sections/governance_officer_workflow_action_bar_section.dart' as section208;
import 'package:primecare_ui/src/screens/management/governance_officer_workflow/sections/governance_officer_workflow_header_section.dart' as section209;
import 'package:primecare_ui/src/screens/management/governance_officer_workflow/sections/governance_officer_workflow_task_details_section.dart' as section210;
import 'package:primecare_ui/src/screens/management/governance_officer_workflow/sections/governance_officer_workflow_task_filters_section.dart' as section211;
import 'package:primecare_ui/src/screens/management/governance_officer_workflow/sections/governance_officer_workflow_task_list_section.dart' as section212;
import 'package:primecare_ui/src/screens/management/growth_analytics/sections/growth_analytics_chart_area_section.dart' as section213;
import 'package:primecare_ui/src/screens/management/growth_analytics/sections/growth_analytics_export_actions_section.dart' as section214;
import 'package:primecare_ui/src/screens/management/growth_analytics/sections/growth_analytics_filter_bar_section.dart' as section215;
import 'package:primecare_ui/src/screens/management/growth_analytics/sections/growth_analytics_header_section.dart' as section216;
import 'package:primecare_ui/src/screens/management/growth_analytics/sections/growth_analytics_metrics_summary_section.dart' as section217;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_analytics/sections/head_of_bus_dev_analytics_chart_area_section.dart' as section218;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_analytics/sections/head_of_bus_dev_analytics_export_actions_section.dart' as section219;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_analytics/sections/head_of_bus_dev_analytics_filter_bar_section.dart' as section220;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_analytics/sections/head_of_bus_dev_analytics_header_section.dart' as section221;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_analytics/sections/head_of_bus_dev_analytics_metrics_summary_section.dart' as section222;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_compliance/sections/head_of_bus_dev_compliance_action_bar_section.dart' as section223;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_compliance/sections/head_of_bus_dev_compliance_content_summary_section.dart' as section224;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_compliance/sections/head_of_bus_dev_compliance_header_section.dart' as section225;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_compliance/sections/head_of_bus_dev_compliance_primary_content_section.dart' as section226;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_workflow/sections/head_of_bus_dev_workflow_action_bar_section.dart' as section227;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_workflow/sections/head_of_bus_dev_workflow_header_section.dart' as section228;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_workflow/sections/head_of_bus_dev_workflow_task_details_section.dart' as section229;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_workflow/sections/head_of_bus_dev_workflow_task_filters_section.dart' as section230;
import 'package:primecare_ui/src/screens/management/head_of_bus_dev_workflow/sections/head_of_bus_dev_workflow_task_list_section.dart' as section231;
import 'package:primecare_ui/src/screens/management/head_of_marketing_analytics/sections/head_of_marketing_analytics_chart_area_section.dart' as section232;
import 'package:primecare_ui/src/screens/management/head_of_marketing_analytics/sections/head_of_marketing_analytics_export_actions_section.dart' as section233;
import 'package:primecare_ui/src/screens/management/head_of_marketing_analytics/sections/head_of_marketing_analytics_filter_bar_section.dart' as section234;
import 'package:primecare_ui/src/screens/management/head_of_marketing_analytics/sections/head_of_marketing_analytics_header_section.dart' as section235;
import 'package:primecare_ui/src/screens/management/head_of_marketing_analytics/sections/head_of_marketing_analytics_metrics_summary_section.dart' as section236;
import 'package:primecare_ui/src/screens/management/head_of_marketing_compliance/sections/head_of_marketing_compliance_action_bar_section.dart' as section237;
import 'package:primecare_ui/src/screens/management/head_of_marketing_compliance/sections/head_of_marketing_compliance_content_summary_section.dart' as section238;
import 'package:primecare_ui/src/screens/management/head_of_marketing_compliance/sections/head_of_marketing_compliance_header_section.dart' as section239;
import 'package:primecare_ui/src/screens/management/head_of_marketing_compliance/sections/head_of_marketing_compliance_primary_content_section.dart' as section240;
import 'package:primecare_ui/src/screens/management/head_of_marketing_workflow/sections/head_of_marketing_workflow_action_bar_section.dart' as section241;
import 'package:primecare_ui/src/screens/management/head_of_marketing_workflow/sections/head_of_marketing_workflow_header_section.dart' as section242;
import 'package:primecare_ui/src/screens/management/head_of_marketing_workflow/sections/head_of_marketing_workflow_task_details_section.dart' as section243;
import 'package:primecare_ui/src/screens/management/head_of_marketing_workflow/sections/head_of_marketing_workflow_task_filters_section.dart' as section244;
import 'package:primecare_ui/src/screens/management/head_of_marketing_workflow/sections/head_of_marketing_workflow_task_list_section.dart' as section245;
import 'package:primecare_ui/src/screens/management/hiring_pipeline/sections/hiring_pipeline_action_bar_section.dart' as section246;
import 'package:primecare_ui/src/screens/management/hiring_pipeline/sections/hiring_pipeline_content_summary_section.dart' as section247;
import 'package:primecare_ui/src/screens/management/hiring_pipeline/sections/hiring_pipeline_header_section.dart' as section248;
import 'package:primecare_ui/src/screens/management/hiring_pipeline/sections/hiring_pipeline_primary_content_section.dart' as section249;
import 'package:primecare_ui/src/screens/management/incident_management/sections/incident_management_action_bar_section.dart' as section250;
import 'package:primecare_ui/src/screens/management/incident_management/sections/incident_management_content_summary_section.dart' as section251;
import 'package:primecare_ui/src/screens/management/incident_management/sections/incident_management_header_section.dart' as section252;
import 'package:primecare_ui/src/screens/management/incident_management/sections/incident_management_primary_content_section.dart' as section253;
import 'package:primecare_ui/src/screens/management/lead_analytics/sections/lead_analytics_chart_area_section.dart' as section254;
import 'package:primecare_ui/src/screens/management/lead_analytics/sections/lead_analytics_export_actions_section.dart' as section255;
import 'package:primecare_ui/src/screens/management/lead_analytics/sections/lead_analytics_filter_bar_section.dart' as section256;
import 'package:primecare_ui/src/screens/management/lead_analytics/sections/lead_analytics_header_section.dart' as section257;
import 'package:primecare_ui/src/screens/management/lead_analytics/sections/lead_analytics_metrics_summary_section.dart' as section258;
import 'package:primecare_ui/src/screens/management/legal_analytics/sections/legal_analytics_chart_area_section.dart' as section259;
import 'package:primecare_ui/src/screens/management/legal_analytics/sections/legal_analytics_export_actions_section.dart' as section260;
import 'package:primecare_ui/src/screens/management/legal_analytics/sections/legal_analytics_filter_bar_section.dart' as section261;
import 'package:primecare_ui/src/screens/management/legal_analytics/sections/legal_analytics_header_section.dart' as section262;
import 'package:primecare_ui/src/screens/management/legal_analytics/sections/legal_analytics_metrics_summary_section.dart' as section263;
import 'package:primecare_ui/src/screens/management/legal_workflow/sections/legal_workflow_action_bar_section.dart' as section264;
import 'package:primecare_ui/src/screens/management/legal_workflow/sections/legal_workflow_header_section.dart' as section265;
import 'package:primecare_ui/src/screens/management/legal_workflow/sections/legal_workflow_task_details_section.dart' as section266;
import 'package:primecare_ui/src/screens/management/legal_workflow/sections/legal_workflow_task_filters_section.dart' as section267;
import 'package:primecare_ui/src/screens/management/legal_workflow/sections/legal_workflow_task_list_section.dart' as section268;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_analytics/sections/local_marketing_manager_analytics_chart_area_section.dart' as section269;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_analytics/sections/local_marketing_manager_analytics_export_actions_section.dart' as section270;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_analytics/sections/local_marketing_manager_analytics_filter_bar_section.dart' as section271;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_analytics/sections/local_marketing_manager_analytics_header_section.dart' as section272;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_analytics/sections/local_marketing_manager_analytics_metrics_summary_section.dart' as section273;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_compliance/sections/local_marketing_manager_compliance_action_bar_section.dart' as section274;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_compliance/sections/local_marketing_manager_compliance_content_summary_section.dart' as section275;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_compliance/sections/local_marketing_manager_compliance_header_section.dart' as section276;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_compliance/sections/local_marketing_manager_compliance_primary_content_section.dart' as section277;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_dashboard/sections/local_marketing_manager_dashboard_chart_overview_section.dart' as section278;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_dashboard/sections/local_marketing_manager_dashboard_header_section.dart' as section279;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_dashboard/sections/local_marketing_manager_dashboard_quick_actions_section.dart' as section280;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_dashboard/sections/local_marketing_manager_dashboard_recent_activity_section.dart' as section281;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_dashboard/sections/local_marketing_manager_dashboard_summary_cards_section.dart' as section282;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_workflow/sections/local_marketing_manager_workflow_action_bar_section.dart' as section283;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_workflow/sections/local_marketing_manager_workflow_header_section.dart' as section284;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_workflow/sections/local_marketing_manager_workflow_task_details_section.dart' as section285;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_workflow/sections/local_marketing_manager_workflow_task_filters_section.dart' as section286;
import 'package:primecare_ui/src/screens/management/local_marketing_manager_workflow/sections/local_marketing_manager_workflow_task_list_section.dart' as section287;
import 'package:primecare_ui/src/screens/management/onboarding/sections/onboarding_action_bar_section.dart' as section288;
import 'package:primecare_ui/src/screens/management/onboarding/sections/onboarding_content_summary_section.dart' as section289;
import 'package:primecare_ui/src/screens/management/onboarding/sections/onboarding_header_section.dart' as section290;
import 'package:primecare_ui/src/screens/management/onboarding/sections/onboarding_primary_content_section.dart' as section291;
import 'package:primecare_ui/src/screens/management/operations_manager_analytics/sections/operations_manager_analytics_chart_area_section.dart' as section292;
import 'package:primecare_ui/src/screens/management/operations_manager_analytics/sections/operations_manager_analytics_export_actions_section.dart' as section293;
import 'package:primecare_ui/src/screens/management/operations_manager_analytics/sections/operations_manager_analytics_filter_bar_section.dart' as section294;
import 'package:primecare_ui/src/screens/management/operations_manager_analytics/sections/operations_manager_analytics_header_section.dart' as section295;
import 'package:primecare_ui/src/screens/management/operations_manager_analytics/sections/operations_manager_analytics_metrics_summary_section.dart' as section296;
import 'package:primecare_ui/src/screens/management/operations_manager_compliance/sections/operations_manager_compliance_action_bar_section.dart' as section297;
import 'package:primecare_ui/src/screens/management/operations_manager_compliance/sections/operations_manager_compliance_content_summary_section.dart' as section298;
import 'package:primecare_ui/src/screens/management/operations_manager_compliance/sections/operations_manager_compliance_header_section.dart' as section299;
import 'package:primecare_ui/src/screens/management/operations_manager_compliance/sections/operations_manager_compliance_primary_content_section.dart' as section300;
import 'package:primecare_ui/src/screens/management/operations_manager_workflow/sections/operations_manager_workflow_action_bar_section.dart' as section301;
import 'package:primecare_ui/src/screens/management/operations_manager_workflow/sections/operations_manager_workflow_header_section.dart' as section302;
import 'package:primecare_ui/src/screens/management/operations_manager_workflow/sections/operations_manager_workflow_task_details_section.dart' as section303;
import 'package:primecare_ui/src/screens/management/operations_manager_workflow/sections/operations_manager_workflow_task_filters_section.dart' as section304;
import 'package:primecare_ui/src/screens/management/operations_manager_workflow/sections/operations_manager_workflow_task_list_section.dart' as section305;
import 'package:primecare_ui/src/screens/management/outreach_campaign/sections/outreach_campaign_action_bar_section.dart' as section306;
import 'package:primecare_ui/src/screens/management/outreach_campaign/sections/outreach_campaign_content_summary_section.dart' as section307;
import 'package:primecare_ui/src/screens/management/outreach_campaign/sections/outreach_campaign_header_section.dart' as section308;
import 'package:primecare_ui/src/screens/management/outreach_campaign/sections/outreach_campaign_primary_content_section.dart' as section309;
import 'package:primecare_ui/src/screens/management/partnership_management/sections/partnership_management_action_bar_section.dart' as section310;
import 'package:primecare_ui/src/screens/management/partnership_management/sections/partnership_management_content_summary_section.dart' as section311;
import 'package:primecare_ui/src/screens/management/partnership_management/sections/partnership_management_header_section.dart' as section312;
import 'package:primecare_ui/src/screens/management/partnership_management/sections/partnership_management_primary_content_section.dart' as section313;
import 'package:primecare_ui/src/screens/management/partnership_manager_analytics/sections/partnership_manager_analytics_chart_area_section.dart' as section314;
import 'package:primecare_ui/src/screens/management/partnership_manager_analytics/sections/partnership_manager_analytics_export_actions_section.dart' as section315;
import 'package:primecare_ui/src/screens/management/partnership_manager_analytics/sections/partnership_manager_analytics_filter_bar_section.dart' as section316;
import 'package:primecare_ui/src/screens/management/partnership_manager_analytics/sections/partnership_manager_analytics_header_section.dart' as section317;
import 'package:primecare_ui/src/screens/management/partnership_manager_analytics/sections/partnership_manager_analytics_metrics_summary_section.dart' as section318;
import 'package:primecare_ui/src/screens/management/partnership_manager_compliance/sections/partnership_manager_compliance_action_bar_section.dart' as section319;
import 'package:primecare_ui/src/screens/management/partnership_manager_compliance/sections/partnership_manager_compliance_content_summary_section.dart' as section320;
import 'package:primecare_ui/src/screens/management/partnership_manager_compliance/sections/partnership_manager_compliance_header_section.dart' as section321;
import 'package:primecare_ui/src/screens/management/partnership_manager_compliance/sections/partnership_manager_compliance_primary_content_section.dart' as section322;
import 'package:primecare_ui/src/screens/management/partnership_manager_dashboard/sections/partnership_manager_dashboard_chart_overview_section.dart' as section323;
import 'package:primecare_ui/src/screens/management/partnership_manager_dashboard/sections/partnership_manager_dashboard_header_section.dart' as section324;
import 'package:primecare_ui/src/screens/management/partnership_manager_dashboard/sections/partnership_manager_dashboard_quick_actions_section.dart' as section325;
import 'package:primecare_ui/src/screens/management/partnership_manager_dashboard/sections/partnership_manager_dashboard_recent_activity_section.dart' as section326;
import 'package:primecare_ui/src/screens/management/partnership_manager_dashboard/sections/partnership_manager_dashboard_summary_cards_section.dart' as section327;
import 'package:primecare_ui/src/screens/management/partnership_manager_workflow/sections/partnership_manager_workflow_action_bar_section.dart' as section328;
import 'package:primecare_ui/src/screens/management/partnership_manager_workflow/sections/partnership_manager_workflow_header_section.dart' as section329;
import 'package:primecare_ui/src/screens/management/partnership_manager_workflow/sections/partnership_manager_workflow_task_details_section.dart' as section330;
import 'package:primecare_ui/src/screens/management/partnership_manager_workflow/sections/partnership_manager_workflow_task_filters_section.dart' as section331;
import 'package:primecare_ui/src/screens/management/partnership_manager_workflow/sections/partnership_manager_workflow_task_list_section.dart' as section332;
import 'package:primecare_ui/src/screens/management/policy_management/sections/policy_management_action_bar_section.dart' as section333;
import 'package:primecare_ui/src/screens/management/policy_management/sections/policy_management_content_summary_section.dart' as section334;
import 'package:primecare_ui/src/screens/management/policy_management/sections/policy_management_header_section.dart' as section335;
import 'package:primecare_ui/src/screens/management/policy_management/sections/policy_management_primary_content_section.dart' as section336;
import 'package:primecare_ui/src/screens/management/premium_concierge_dashboard/sections/premium_concierge_dashboard_chart_overview_section.dart' as section337;
import 'package:primecare_ui/src/screens/management/premium_concierge_dashboard/sections/premium_concierge_dashboard_header_section.dart' as section338;
import 'package:primecare_ui/src/screens/management/premium_concierge_dashboard/sections/premium_concierge_dashboard_quick_actions_section.dart' as section339;
import 'package:primecare_ui/src/screens/management/premium_concierge_dashboard/sections/premium_concierge_dashboard_recent_activity_section.dart' as section340;
import 'package:primecare_ui/src/screens/management/premium_concierge_dashboard/sections/premium_concierge_dashboard_summary_cards_section.dart' as section341;
import 'package:primecare_ui/src/screens/management/regional_bdm_analytics/sections/regional_bdm_analytics_chart_area_section.dart' as section342;
import 'package:primecare_ui/src/screens/management/regional_bdm_analytics/sections/regional_bdm_analytics_export_actions_section.dart' as section343;
import 'package:primecare_ui/src/screens/management/regional_bdm_analytics/sections/regional_bdm_analytics_filter_bar_section.dart' as section344;
import 'package:primecare_ui/src/screens/management/regional_bdm_analytics/sections/regional_bdm_analytics_header_section.dart' as section345;
import 'package:primecare_ui/src/screens/management/regional_bdm_analytics/sections/regional_bdm_analytics_metrics_summary_section.dart' as section346;
import 'package:primecare_ui/src/screens/management/regional_bdm_compliance/sections/regional_bdm_compliance_action_bar_section.dart' as section347;
import 'package:primecare_ui/src/screens/management/regional_bdm_compliance/sections/regional_bdm_compliance_content_summary_section.dart' as section348;
import 'package:primecare_ui/src/screens/management/regional_bdm_compliance/sections/regional_bdm_compliance_header_section.dart' as section349;
import 'package:primecare_ui/src/screens/management/regional_bdm_compliance/sections/regional_bdm_compliance_primary_content_section.dart' as section350;
import 'package:primecare_ui/src/screens/management/regional_bdm_dashboard/sections/regional_bdm_dashboard_chart_overview_section.dart' as section351;
import 'package:primecare_ui/src/screens/management/regional_bdm_dashboard/sections/regional_bdm_dashboard_header_section.dart' as section352;
import 'package:primecare_ui/src/screens/management/regional_bdm_dashboard/sections/regional_bdm_dashboard_quick_actions_section.dart' as section353;
import 'package:primecare_ui/src/screens/management/regional_bdm_dashboard/sections/regional_bdm_dashboard_recent_activity_section.dart' as section354;
import 'package:primecare_ui/src/screens/management/regional_bdm_dashboard/sections/regional_bdm_dashboard_summary_cards_section.dart' as section355;
import 'package:primecare_ui/src/screens/management/regional_bdm_workflow/sections/regional_bdm_workflow_action_bar_section.dart' as section356;
import 'package:primecare_ui/src/screens/management/regional_bdm_workflow/sections/regional_bdm_workflow_header_section.dart' as section357;
import 'package:primecare_ui/src/screens/management/regional_bdm_workflow/sections/regional_bdm_workflow_task_details_section.dart' as section358;
import 'package:primecare_ui/src/screens/management/regional_bdm_workflow/sections/regional_bdm_workflow_task_filters_section.dart' as section359;
import 'package:primecare_ui/src/screens/management/regional_bdm_workflow/sections/regional_bdm_workflow_task_list_section.dart' as section360;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_analytics/sections/regional_manager_usa_analytics_chart_area_section.dart' as section361;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_analytics/sections/regional_manager_usa_analytics_export_actions_section.dart' as section362;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_analytics/sections/regional_manager_usa_analytics_filter_bar_section.dart' as section363;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_analytics/sections/regional_manager_usa_analytics_header_section.dart' as section364;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_analytics/sections/regional_manager_usa_analytics_metrics_summary_section.dart' as section365;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_compliance/sections/regional_manager_usa_compliance_action_bar_section.dart' as section366;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_compliance/sections/regional_manager_usa_compliance_content_summary_section.dart' as section367;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_compliance/sections/regional_manager_usa_compliance_header_section.dart' as section368;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_compliance/sections/regional_manager_usa_compliance_primary_content_section.dart' as section369;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_dashboard/sections/regional_manager_usa_dashboard_chart_overview_section.dart' as section370;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_dashboard/sections/regional_manager_usa_dashboard_header_section.dart' as section371;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_dashboard/sections/regional_manager_usa_dashboard_quick_actions_section.dart' as section372;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_dashboard/sections/regional_manager_usa_dashboard_recent_activity_section.dart' as section373;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_dashboard/sections/regional_manager_usa_dashboard_summary_cards_section.dart' as section374;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_workflow/sections/regional_manager_usa_workflow_action_bar_section.dart' as section375;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_workflow/sections/regional_manager_usa_workflow_header_section.dart' as section376;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_workflow/sections/regional_manager_usa_workflow_task_details_section.dart' as section377;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_workflow/sections/regional_manager_usa_workflow_task_filters_section.dart' as section378;
import 'package:primecare_ui/src/screens/management/regional_manager_usa_workflow/sections/regional_manager_usa_workflow_task_list_section.dart' as section379;
import 'package:primecare_ui/src/screens/management/scheduling_health/sections/scheduling_health_action_bar_section.dart' as section380;
import 'package:primecare_ui/src/screens/management/scheduling_health/sections/scheduling_health_content_summary_section.dart' as section381;
import 'package:primecare_ui/src/screens/management/scheduling_health/sections/scheduling_health_header_section.dart' as section382;
import 'package:primecare_ui/src/screens/management/scheduling_health/sections/scheduling_health_primary_content_section.dart' as section383;
import 'package:primecare_ui/src/screens/management/scrum_master_compliance/sections/scrum_master_compliance_action_bar_section.dart' as section384;
import 'package:primecare_ui/src/screens/management/scrum_master_compliance/sections/scrum_master_compliance_content_summary_section.dart' as section385;
import 'package:primecare_ui/src/screens/management/scrum_master_compliance/sections/scrum_master_compliance_header_section.dart' as section386;
import 'package:primecare_ui/src/screens/management/scrum_master_compliance/sections/scrum_master_compliance_primary_content_section.dart' as section387;
import 'package:primecare_ui/src/screens/management/service_issue/sections/service_issue_action_bar_section.dart' as section388;
import 'package:primecare_ui/src/screens/management/service_issue/sections/service_issue_content_summary_section.dart' as section389;
import 'package:primecare_ui/src/screens/management/service_issue/sections/service_issue_header_section.dart' as section390;
import 'package:primecare_ui/src/screens/management/service_issue/sections/service_issue_primary_content_section.dart' as section391;
import 'package:primecare_ui/src/screens/management/social_media/sections/social_media_action_bar_section.dart' as section392;
import 'package:primecare_ui/src/screens/management/social_media/sections/social_media_content_summary_section.dart' as section393;
import 'package:primecare_ui/src/screens/management/social_media/sections/social_media_header_section.dart' as section394;
import 'package:primecare_ui/src/screens/management/social_media/sections/social_media_primary_content_section.dart' as section395;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_analytics/sections/territory_expansion_manager_analytics_chart_area_section.dart' as section396;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_analytics/sections/territory_expansion_manager_analytics_export_actions_section.dart' as section397;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_analytics/sections/territory_expansion_manager_analytics_filter_bar_section.dart' as section398;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_analytics/sections/territory_expansion_manager_analytics_header_section.dart' as section399;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_analytics/sections/territory_expansion_manager_analytics_metrics_summary_section.dart' as section400;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_compliance/sections/territory_expansion_manager_compliance_action_bar_section.dart' as section401;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_compliance/sections/territory_expansion_manager_compliance_content_summary_section.dart' as section402;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_compliance/sections/territory_expansion_manager_compliance_header_section.dart' as section403;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_compliance/sections/territory_expansion_manager_compliance_primary_content_section.dart' as section404;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_dashboard/sections/territory_expansion_manager_dashboard_chart_overview_section.dart' as section405;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_dashboard/sections/territory_expansion_manager_dashboard_header_section.dart' as section406;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_dashboard/sections/territory_expansion_manager_dashboard_quick_actions_section.dart' as section407;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_dashboard/sections/territory_expansion_manager_dashboard_recent_activity_section.dart' as section408;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_dashboard/sections/territory_expansion_manager_dashboard_summary_cards_section.dart' as section409;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_workflow/sections/territory_expansion_manager_workflow_action_bar_section.dart' as section410;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_workflow/sections/territory_expansion_manager_workflow_header_section.dart' as section411;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_workflow/sections/territory_expansion_manager_workflow_task_details_section.dart' as section412;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_workflow/sections/territory_expansion_manager_workflow_task_filters_section.dart' as section413;
import 'package:primecare_ui/src/screens/management/territory_expansion_manager_workflow/sections/territory_expansion_manager_workflow_task_list_section.dart' as section414;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_analytics/sections/territory_sales_manager_analytics_chart_area_section.dart' as section415;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_analytics/sections/territory_sales_manager_analytics_export_actions_section.dart' as section416;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_analytics/sections/territory_sales_manager_analytics_filter_bar_section.dart' as section417;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_analytics/sections/territory_sales_manager_analytics_header_section.dart' as section418;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_analytics/sections/territory_sales_manager_analytics_metrics_summary_section.dart' as section419;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_compliance/sections/territory_sales_manager_compliance_action_bar_section.dart' as section420;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_compliance/sections/territory_sales_manager_compliance_content_summary_section.dart' as section421;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_compliance/sections/territory_sales_manager_compliance_header_section.dart' as section422;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_compliance/sections/territory_sales_manager_compliance_primary_content_section.dart' as section423;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_dashboard/sections/territory_sales_manager_dashboard_chart_overview_section.dart' as section424;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_dashboard/sections/territory_sales_manager_dashboard_header_section.dart' as section425;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_dashboard/sections/territory_sales_manager_dashboard_quick_actions_section.dart' as section426;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_dashboard/sections/territory_sales_manager_dashboard_recent_activity_section.dart' as section427;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_dashboard/sections/territory_sales_manager_dashboard_summary_cards_section.dart' as section428;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_workflow/sections/territory_sales_manager_workflow_action_bar_section.dart' as section429;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_workflow/sections/territory_sales_manager_workflow_header_section.dart' as section430;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_workflow/sections/territory_sales_manager_workflow_task_details_section.dart' as section431;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_workflow/sections/territory_sales_manager_workflow_task_filters_section.dart' as section432;
import 'package:primecare_ui/src/screens/management/territory_sales_manager_workflow/sections/territory_sales_manager_workflow_task_list_section.dart' as section433;
import 'package:primecare_ui/src/screens/management/training_management/sections/training_management_action_bar_section.dart' as section434;
import 'package:primecare_ui/src/screens/management/training_management/sections/training_management_content_summary_section.dart' as section435;
import 'package:primecare_ui/src/screens/management/training_management/sections/training_management_header_section.dart' as section436;
import 'package:primecare_ui/src/screens/management/training_management/sections/training_management_primary_content_section.dart' as section437;
import 'package:primecare_ui/src/screens/management/vip_manager_dashboard/sections/vip_manager_dashboard_chart_overview_section.dart' as section438;
import 'package:primecare_ui/src/screens/management/vip_manager_dashboard/sections/vip_manager_dashboard_header_section.dart' as section439;
import 'package:primecare_ui/src/screens/management/vip_manager_dashboard/sections/vip_manager_dashboard_quick_actions_section.dart' as section440;
import 'package:primecare_ui/src/screens/management/vip_manager_dashboard/sections/vip_manager_dashboard_recent_activity_section.dart' as section441;
import 'package:primecare_ui/src/screens/management/vip_manager_dashboard/sections/vip_manager_dashboard_summary_cards_section.dart' as section442;
import 'package:primecare_ui/src/screens/premium/premium_concierge_analytics/sections/premium_concierge_analytics_chart_area_section.dart' as section443;
import 'package:primecare_ui/src/screens/premium/premium_concierge_analytics/sections/premium_concierge_analytics_export_actions_section.dart' as section444;
import 'package:primecare_ui/src/screens/premium/premium_concierge_analytics/sections/premium_concierge_analytics_filter_bar_section.dart' as section445;
import 'package:primecare_ui/src/screens/premium/premium_concierge_analytics/sections/premium_concierge_analytics_header_section.dart' as section446;
import 'package:primecare_ui/src/screens/premium/premium_concierge_analytics/sections/premium_concierge_analytics_metrics_summary_section.dart' as section447;
import 'package:primecare_ui/src/screens/premium/premium_concierge_workflow/sections/premium_concierge_workflow_action_bar_section.dart' as section448;
import 'package:primecare_ui/src/screens/premium/premium_concierge_workflow/sections/premium_concierge_workflow_header_section.dart' as section449;
import 'package:primecare_ui/src/screens/premium/premium_concierge_workflow/sections/premium_concierge_workflow_task_details_section.dart' as section450;
import 'package:primecare_ui/src/screens/premium/premium_concierge_workflow/sections/premium_concierge_workflow_task_filters_section.dart' as section451;
import 'package:primecare_ui/src/screens/premium/premium_concierge_workflow/sections/premium_concierge_workflow_task_list_section.dart' as section452;
import 'package:primecare_ui/src/screens/psw/caregiver_client_profile/sections/caregiver_client_profile_action_bar_section.dart' as section453;
import 'package:primecare_ui/src/screens/psw/caregiver_client_profile/sections/caregiver_client_profile_details_form_section.dart' as section454;
import 'package:primecare_ui/src/screens/psw/caregiver_client_profile/sections/caregiver_client_profile_header_section.dart' as section455;
import 'package:primecare_ui/src/screens/psw/caregiver_client_profile/sections/caregiver_client_profile_identity_summary_section.dart' as section456;
import 'package:primecare_ui/src/screens/psw/caregiver_client_profile/sections/caregiver_client_profile_preferences_or_documents_section.dart' as section457;
import 'package:primecare_ui/src/screens/psw/caregiver_incident_report/sections/caregiver_incident_report_chart_area_section.dart' as section458;
import 'package:primecare_ui/src/screens/psw/caregiver_incident_report/sections/caregiver_incident_report_export_actions_section.dart' as section459;
import 'package:primecare_ui/src/screens/psw/caregiver_incident_report/sections/caregiver_incident_report_filter_bar_section.dart' as section460;
import 'package:primecare_ui/src/screens/psw/caregiver_incident_report/sections/caregiver_incident_report_header_section.dart' as section461;
import 'package:primecare_ui/src/screens/psw/caregiver_incident_report/sections/caregiver_incident_report_metrics_summary_section.dart' as section462;
import 'package:primecare_ui/src/screens/psw/caregiver_schedule/sections/caregiver_schedule_action_bar_section.dart' as section463;
import 'package:primecare_ui/src/screens/psw/caregiver_schedule/sections/caregiver_schedule_appointment_details_section.dart' as section464;
import 'package:primecare_ui/src/screens/psw/caregiver_schedule/sections/caregiver_schedule_calendar_controls_section.dart' as section465;
import 'package:primecare_ui/src/screens/psw/caregiver_schedule/sections/caregiver_schedule_header_section.dart' as section466;
import 'package:primecare_ui/src/screens/psw/caregiver_schedule/sections/caregiver_schedule_schedule_list_section.dart' as section467;
import 'package:primecare_ui/src/screens/psw/caregiver_tasks/sections/caregiver_tasks_action_bar_section.dart' as section468;
import 'package:primecare_ui/src/screens/psw/caregiver_tasks/sections/caregiver_tasks_header_section.dart' as section469;
import 'package:primecare_ui/src/screens/psw/caregiver_tasks/sections/caregiver_tasks_task_details_section.dart' as section470;
import 'package:primecare_ui/src/screens/psw/caregiver_tasks/sections/caregiver_tasks_task_filters_section.dart' as section471;
import 'package:primecare_ui/src/screens/psw/caregiver_tasks/sections/caregiver_tasks_task_list_section.dart' as section472;
import 'package:primecare_ui/src/screens/psw/caregiver_visit_notes/sections/caregiver_visit_notes_action_bar_section.dart' as section473;
import 'package:primecare_ui/src/screens/psw/caregiver_visit_notes/sections/caregiver_visit_notes_client_context_section.dart' as section474;
import 'package:primecare_ui/src/screens/psw/caregiver_visit_notes/sections/caregiver_visit_notes_header_section.dart' as section475;
import 'package:primecare_ui/src/screens/psw/caregiver_visit_notes/sections/caregiver_visit_notes_notes_form_section.dart' as section476;
import 'package:primecare_ui/src/screens/psw/caregiver_visit_notes/sections/caregiver_visit_notes_notes_history_section.dart' as section477;
import 'package:primecare_ui/src/screens/psw/messaging/sections/messaging_action_bar_section.dart' as section478;
import 'package:primecare_ui/src/screens/psw/messaging/sections/messaging_content_summary_section.dart' as section479;
import 'package:primecare_ui/src/screens/psw/messaging/sections/messaging_header_section.dart' as section480;
import 'package:primecare_ui/src/screens/psw/messaging/sections/messaging_primary_content_section.dart' as section481;
import 'package:primecare_ui/src/screens/psw/psw_analytics/sections/psw_analytics_chart_area_section.dart' as section482;
import 'package:primecare_ui/src/screens/psw/psw_analytics/sections/psw_analytics_export_actions_section.dart' as section483;
import 'package:primecare_ui/src/screens/psw/psw_analytics/sections/psw_analytics_filter_bar_section.dart' as section484;
import 'package:primecare_ui/src/screens/psw/psw_analytics/sections/psw_analytics_header_section.dart' as section485;
import 'package:primecare_ui/src/screens/psw/psw_analytics/sections/psw_analytics_metrics_summary_section.dart' as section486;
import 'package:primecare_ui/src/screens/psw/psw_care_plan/sections/psw_care_plan_action_bar_section.dart' as section487;
import 'package:primecare_ui/src/screens/psw/psw_care_plan/sections/psw_care_plan_content_summary_section.dart' as section488;
import 'package:primecare_ui/src/screens/psw/psw_care_plan/sections/psw_care_plan_header_section.dart' as section489;
import 'package:primecare_ui/src/screens/psw/psw_care_plan/sections/psw_care_plan_primary_content_section.dart' as section490;
import 'package:primecare_ui/src/screens/psw/psw_client_profile/sections/psw_client_profile_action_bar_section.dart' as section491;
import 'package:primecare_ui/src/screens/psw/psw_client_profile/sections/psw_client_profile_details_form_section.dart' as section492;
import 'package:primecare_ui/src/screens/psw/psw_client_profile/sections/psw_client_profile_header_section.dart' as section493;
import 'package:primecare_ui/src/screens/psw/psw_client_profile/sections/psw_client_profile_identity_summary_section.dart' as section494;
import 'package:primecare_ui/src/screens/psw/psw_client_profile/sections/psw_client_profile_preferences_or_documents_section.dart' as section495;
import 'package:primecare_ui/src/screens/psw/psw_clients/sections/psw_clients_action_bar_section.dart' as section496;
import 'package:primecare_ui/src/screens/psw/psw_clients/sections/psw_clients_details_form_section.dart' as section497;
import 'package:primecare_ui/src/screens/psw/psw_clients/sections/psw_clients_header_section.dart' as section498;
import 'package:primecare_ui/src/screens/psw/psw_clients/sections/psw_clients_identity_summary_section.dart' as section499;
import 'package:primecare_ui/src/screens/psw/psw_clients/sections/psw_clients_preferences_or_documents_section.dart' as section500;
import 'package:primecare_ui/src/screens/psw/psw_command_center/sections/psw_command_center_action_bar_section.dart' as section501;
import 'package:primecare_ui/src/screens/psw/psw_command_center/sections/psw_command_center_data_table_section.dart' as section502;
import 'package:primecare_ui/src/screens/psw/psw_command_center/sections/psw_command_center_filter_bar_section.dart' as section503;
import 'package:primecare_ui/src/screens/psw/psw_command_center/sections/psw_command_center_header_section.dart' as section504;
import 'package:primecare_ui/src/screens/psw/psw_command_center/sections/psw_command_center_pagination_section.dart' as section505;
import 'package:primecare_ui/src/screens/psw/psw_compliance/sections/psw_compliance_action_bar_section.dart' as section506;
import 'package:primecare_ui/src/screens/psw/psw_compliance/sections/psw_compliance_content_summary_section.dart' as section507;
import 'package:primecare_ui/src/screens/psw/psw_compliance/sections/psw_compliance_header_section.dart' as section508;
import 'package:primecare_ui/src/screens/psw/psw_compliance/sections/psw_compliance_primary_content_section.dart' as section509;
import 'package:primecare_ui/src/screens/psw/psw_documents/sections/psw_documents_action_bar_section.dart' as section510;
import 'package:primecare_ui/src/screens/psw/psw_documents/sections/psw_documents_content_summary_section.dart' as section511;
import 'package:primecare_ui/src/screens/psw/psw_documents/sections/psw_documents_header_section.dart' as section512;
import 'package:primecare_ui/src/screens/psw/psw_documents/sections/psw_documents_primary_content_section.dart' as section513;
import 'package:primecare_ui/src/screens/psw/psw_incident_report/sections/psw_incident_report_chart_area_section.dart' as section514;
import 'package:primecare_ui/src/screens/psw/psw_incident_report/sections/psw_incident_report_export_actions_section.dart' as section515;
import 'package:primecare_ui/src/screens/psw/psw_incident_report/sections/psw_incident_report_filter_bar_section.dart' as section516;
import 'package:primecare_ui/src/screens/psw/psw_incident_report/sections/psw_incident_report_header_section.dart' as section517;
import 'package:primecare_ui/src/screens/psw/psw_incident_report/sections/psw_incident_report_metrics_summary_section.dart' as section518;
import 'package:primecare_ui/src/screens/psw/psw_messages/sections/psw_messages_action_bar_section.dart' as section519;
import 'package:primecare_ui/src/screens/psw/psw_messages/sections/psw_messages_content_summary_section.dart' as section520;
import 'package:primecare_ui/src/screens/psw/psw_messages/sections/psw_messages_header_section.dart' as section521;
import 'package:primecare_ui/src/screens/psw/psw_messages/sections/psw_messages_primary_content_section.dart' as section522;
import 'package:primecare_ui/src/screens/psw/psw_my_shifts/sections/psw_my_shifts_action_bar_section.dart' as section523;
import 'package:primecare_ui/src/screens/psw/psw_my_shifts/sections/psw_my_shifts_content_summary_section.dart' as section524;
import 'package:primecare_ui/src/screens/psw/psw_my_shifts/sections/psw_my_shifts_header_section.dart' as section525;
import 'package:primecare_ui/src/screens/psw/psw_my_shifts/sections/psw_my_shifts_primary_content_section.dart' as section526;
import 'package:primecare_ui/src/screens/psw/psw_shift_tracker/sections/psw_shift_tracker_action_bar_section.dart' as section527;
import 'package:primecare_ui/src/screens/psw/psw_shift_tracker/sections/psw_shift_tracker_appointment_details_section.dart' as section528;
import 'package:primecare_ui/src/screens/psw/psw_shift_tracker/sections/psw_shift_tracker_calendar_controls_section.dart' as section529;
import 'package:primecare_ui/src/screens/psw/psw_shift_tracker/sections/psw_shift_tracker_header_section.dart' as section530;
import 'package:primecare_ui/src/screens/psw/psw_shift_tracker/sections/psw_shift_tracker_schedule_list_section.dart' as section531;
import 'package:primecare_ui/src/screens/psw/psw_tasks/sections/psw_tasks_action_bar_section.dart' as section532;
import 'package:primecare_ui/src/screens/psw/psw_tasks/sections/psw_tasks_appointment_details_section.dart' as section533;
import 'package:primecare_ui/src/screens/psw/psw_tasks/sections/psw_tasks_calendar_controls_section.dart' as section534;
import 'package:primecare_ui/src/screens/psw/psw_tasks/sections/psw_tasks_header_section.dart' as section535;
import 'package:primecare_ui/src/screens/psw/psw_tasks/sections/psw_tasks_schedule_list_section.dart' as section536;
import 'package:primecare_ui/src/screens/psw/psw_visit_notes/sections/psw_visit_notes_action_bar_section.dart' as section537;
import 'package:primecare_ui/src/screens/psw/psw_visit_notes/sections/psw_visit_notes_client_context_section.dart' as section538;
import 'package:primecare_ui/src/screens/psw/psw_visit_notes/sections/psw_visit_notes_header_section.dart' as section539;
import 'package:primecare_ui/src/screens/psw/psw_visit_notes/sections/psw_visit_notes_notes_form_section.dart' as section540;
import 'package:primecare_ui/src/screens/psw/psw_visit_notes/sections/psw_visit_notes_notes_history_section.dart' as section541;
import 'package:primecare_ui/src/screens/psw/psw_vitals_log/sections/psw_vitals_log_action_bar_section.dart' as section542;
import 'package:primecare_ui/src/screens/psw/psw_vitals_log/sections/psw_vitals_log_data_table_section.dart' as section543;
import 'package:primecare_ui/src/screens/psw/psw_vitals_log/sections/psw_vitals_log_filter_bar_section.dart' as section544;
import 'package:primecare_ui/src/screens/psw/psw_vitals_log/sections/psw_vitals_log_header_section.dart' as section545;
import 'package:primecare_ui/src/screens/psw/psw_vitals_log/sections/psw_vitals_log_pagination_section.dart' as section546;
import 'package:primecare_ui/src/screens/psw/psw_workflow/sections/psw_workflow_action_bar_section.dart' as section547;
import 'package:primecare_ui/src/screens/psw/psw_workflow/sections/psw_workflow_header_section.dart' as section548;
import 'package:primecare_ui/src/screens/psw/psw_workflow/sections/psw_workflow_task_details_section.dart' as section549;
import 'package:primecare_ui/src/screens/psw/psw_workflow/sections/psw_workflow_task_filters_section.dart' as section550;
import 'package:primecare_ui/src/screens/psw/psw_workflow/sections/psw_workflow_task_list_section.dart' as section551;
import 'package:primecare_ui/src/screens/psw/schedule/sections/schedule_action_bar_section.dart' as section552;
import 'package:primecare_ui/src/screens/psw/schedule/sections/schedule_appointment_details_section.dart' as section553;
import 'package:primecare_ui/src/screens/psw/schedule/sections/schedule_calendar_controls_section.dart' as section554;
import 'package:primecare_ui/src/screens/psw/schedule/sections/schedule_header_section.dart' as section555;
import 'package:primecare_ui/src/screens/psw/schedule/sections/schedule_schedule_list_section.dart' as section556;
import 'package:primecare_ui/src/screens/psw/shift_tasks/sections/shift_tasks_action_bar_section.dart' as section557;
import 'package:primecare_ui/src/screens/psw/shift_tasks/sections/shift_tasks_header_section.dart' as section558;
import 'package:primecare_ui/src/screens/psw/shift_tasks/sections/shift_tasks_task_details_section.dart' as section559;
import 'package:primecare_ui/src/screens/psw/shift_tasks/sections/shift_tasks_task_filters_section.dart' as section560;
import 'package:primecare_ui/src/screens/psw/shift_tasks/sections/shift_tasks_task_list_section.dart' as section561;
import 'package:primecare_ui/src/screens/psw/vitals_entry/sections/vitals_entry_action_bar_section.dart' as section562;
import 'package:primecare_ui/src/screens/psw/vitals_entry/sections/vitals_entry_content_summary_section.dart' as section563;
import 'package:primecare_ui/src/screens/psw/vitals_entry/sections/vitals_entry_header_section.dart' as section564;
import 'package:primecare_ui/src/screens/psw/vitals_entry/sections/vitals_entry_primary_content_section.dart' as section565;
import 'package:primecare_ui/src/screens/rn/care_plan_review/sections/care_plan_review_action_bar_section.dart' as section566;
import 'package:primecare_ui/src/screens/rn/care_plan_review/sections/care_plan_review_data_table_section.dart' as section567;
import 'package:primecare_ui/src/screens/rn/care_plan_review/sections/care_plan_review_filter_bar_section.dart' as section568;
import 'package:primecare_ui/src/screens/rn/care_plan_review/sections/care_plan_review_header_section.dart' as section569;
import 'package:primecare_ui/src/screens/rn/care_plan_review/sections/care_plan_review_pagination_section.dart' as section570;
import 'package:primecare_ui/src/screens/rn/cns_analytics/sections/cns_analytics_chart_area_section.dart' as section571;
import 'package:primecare_ui/src/screens/rn/cns_analytics/sections/cns_analytics_export_actions_section.dart' as section572;
import 'package:primecare_ui/src/screens/rn/cns_analytics/sections/cns_analytics_filter_bar_section.dart' as section573;
import 'package:primecare_ui/src/screens/rn/cns_analytics/sections/cns_analytics_header_section.dart' as section574;
import 'package:primecare_ui/src/screens/rn/cns_analytics/sections/cns_analytics_metrics_summary_section.dart' as section575;
import 'package:primecare_ui/src/screens/rn/cns_workflow/sections/cns_workflow_action_bar_section.dart' as section576;
import 'package:primecare_ui/src/screens/rn/cns_workflow/sections/cns_workflow_header_section.dart' as section577;
import 'package:primecare_ui/src/screens/rn/cns_workflow/sections/cns_workflow_task_details_section.dart' as section578;
import 'package:primecare_ui/src/screens/rn/cns_workflow/sections/cns_workflow_task_filters_section.dart' as section579;
import 'package:primecare_ui/src/screens/rn/cns_workflow/sections/cns_workflow_task_list_section.dart' as section580;
import 'package:primecare_ui/src/screens/rn/incident_review/sections/incident_review_action_bar_section.dart' as section581;
import 'package:primecare_ui/src/screens/rn/incident_review/sections/incident_review_data_table_section.dart' as section582;
import 'package:primecare_ui/src/screens/rn/incident_review/sections/incident_review_filter_bar_section.dart' as section583;
import 'package:primecare_ui/src/screens/rn/incident_review/sections/incident_review_header_section.dart' as section584;
import 'package:primecare_ui/src/screens/rn/incident_review/sections/incident_review_pagination_section.dart' as section585;
import 'package:primecare_ui/src/screens/rn/medication_administration/sections/medication_administration_action_bar_section.dart' as section586;
import 'package:primecare_ui/src/screens/rn/medication_administration/sections/medication_administration_content_summary_section.dart' as section587;
import 'package:primecare_ui/src/screens/rn/medication_administration/sections/medication_administration_header_section.dart' as section588;
import 'package:primecare_ui/src/screens/rn/medication_administration/sections/medication_administration_primary_content_section.dart' as section589;
import 'package:primecare_ui/src/screens/rn/np_analytics/sections/np_analytics_chart_area_section.dart' as section590;
import 'package:primecare_ui/src/screens/rn/np_analytics/sections/np_analytics_export_actions_section.dart' as section591;
import 'package:primecare_ui/src/screens/rn/np_analytics/sections/np_analytics_filter_bar_section.dart' as section592;
import 'package:primecare_ui/src/screens/rn/np_analytics/sections/np_analytics_header_section.dart' as section593;
import 'package:primecare_ui/src/screens/rn/np_analytics/sections/np_analytics_metrics_summary_section.dart' as section594;
import 'package:primecare_ui/src/screens/rn/np_workflow/sections/np_workflow_action_bar_section.dart' as section595;
import 'package:primecare_ui/src/screens/rn/np_workflow/sections/np_workflow_header_section.dart' as section596;
import 'package:primecare_ui/src/screens/rn/np_workflow/sections/np_workflow_task_details_section.dart' as section597;
import 'package:primecare_ui/src/screens/rn/np_workflow/sections/np_workflow_task_filters_section.dart' as section598;
import 'package:primecare_ui/src/screens/rn/np_workflow/sections/np_workflow_task_list_section.dart' as section599;

void main() {
  test('all muted section consumers compile, part 3', () {
    final types = <Type>[
      section0.RevenueAnalyticsHeaderSection,
      section1.RevenueAnalyticsMetricsSummarySection,
      section2.RevenueSnapshotActionBarSection,
      section3.RevenueSnapshotContentSummarySection,
      section4.RevenueSnapshotHeaderSection,
      section5.RevenueSnapshotPrimaryContentSection,
      section6.RiskManagementActionBarSection,
      section7.RiskManagementContentSummarySection,
      section8.RiskManagementHeaderSection,
      section9.RiskManagementPrimaryContentSection,
      section10.SecurityAuditActionBarSection,
      section11.SecurityAuditContentSummarySection,
      section12.SecurityAuditHeaderSection,
      section13.SecurityAuditPrimaryContentSection,
      section14.ServiceQualityActionBarSection,
      section15.ServiceQualityContentSummarySection,
      section16.ServiceQualityHeaderSection,
      section17.ServiceQualityPrimaryContentSection,
      section18.ShareholderAnalyticsChartAreaSection,
      section19.ShareholderAnalyticsExportActionsSection,
      section20.ShareholderAnalyticsFilterBarSection,
      section21.ShareholderAnalyticsHeaderSection,
      section22.ShareholderAnalyticsMetricsSummarySection,
      section23.ShareholderComplianceActionBarSection,
      section24.ShareholderComplianceContentSummarySection,
      section25.ShareholderComplianceHeaderSection,
      section26.ShareholderCompliancePrimaryContentSection,
      section27.ShareholderWorkflowActionBarSection,
      section28.ShareholderWorkflowHeaderSection,
      section29.ShareholderWorkflowTaskDetailsSection,
      section30.ShareholderWorkflowTaskFiltersSection,
      section31.ShareholderWorkflowTaskListSection,
      section32.StaffManagementActionBarSection,
      section33.StaffManagementContentSummarySection,
      section34.StaffManagementHeaderSection,
      section35.StaffManagementPrimaryContentSection,
      section36.StaffingOverviewActionBarSection,
      section37.StaffingOverviewDataTableSection,
      section38.StaffingOverviewFilterBarSection,
      section39.StaffingOverviewHeaderSection,
      section40.StaffingOverviewPaginationSection,
      section41.SystemHealthActionBarSection,
      section42.SystemHealthContentSummarySection,
      section43.SystemHealthHeaderSection,
      section44.SystemHealthPrimaryContentSection,
      section45.TaxComplianceActionBarSection,
      section46.TaxComplianceContentSummarySection,
      section47.TaxComplianceHeaderSection,
      section48.TaxCompliancePrimaryContentSection,
      section49.TrainingDirectorAnalyticsChartAreaSection,
      section50.TrainingDirectorAnalyticsExportActionsSection,
      section51.TrainingDirectorAnalyticsFilterBarSection,
      section52.TrainingDirectorAnalyticsHeaderSection,
      section53.TrainingDirectorAnalyticsMetricsSummarySection,
      section54.TrainingDirectorComplianceActionBarSection,
      section55.TrainingDirectorComplianceContentSummarySection,
      section56.TrainingDirectorComplianceHeaderSection,
      section57.TrainingDirectorCompliancePrimaryContentSection,
      section58.TrainingDirectorDashboardChartOverviewSection,
      section59.TrainingDirectorDashboardHeaderSection,
      section60.TrainingDirectorDashboardQuickActionsSection,
      section61.TrainingDirectorDashboardRecentActivitySection,
      section62.TrainingDirectorDashboardSummaryCardsSection,
      section63.TrainingDirectorWorkflowActionBarSection,
      section64.TrainingDirectorWorkflowHeaderSection,
      section65.TrainingDirectorWorkflowTaskDetailsSection,
      section66.TrainingDirectorWorkflowTaskFiltersSection,
      section67.TrainingDirectorWorkflowTaskListSection,
      section68.VipManagerAnalyticsChartAreaSection,
      section69.VipManagerAnalyticsExportActionsSection,
      section70.VipManagerAnalyticsFilterBarSection,
      section71.VipManagerAnalyticsHeaderSection,
      section72.VipManagerAnalyticsMetricsSummarySection,
      section73.VipManagerWorkflowActionBarSection,
      section74.VipManagerWorkflowHeaderSection,
      section75.VipManagerWorkflowTaskDetailsSection,
      section76.VipManagerWorkflowTaskFiltersSection,
      section77.VipManagerWorkflowTaskListSection,
      section78.WorkflowIssueActionBarSection,
      section79.WorkflowIssueHeaderSection,
      section80.WorkflowIssueTaskDetailsSection,
      section81.WorkflowIssueTaskFiltersSection,
      section82.WorkflowIssueTaskListSection,
      section83.AttendanceActionBarSection,
      section84.AttendanceContentSummarySection,
      section85.AttendanceHeaderSection,
      section86.AttendancePrimaryContentSection,
      section87.AuditReviewActionBarSection,
      section88.AuditReviewDataTableSection,
      section89.AuditReviewFilterBarSection,
      section90.AuditReviewHeaderSection,
      section91.AuditReviewPaginationSection,
      section92.BrandManagementActionBarSection,
      section93.BrandManagementContentSummarySection,
      section94.BrandManagementHeaderSection,
      section95.BrandManagementPrimaryContentSection,
      section96.CampaignDashboardChartOverviewSection,
      section97.CampaignDashboardHeaderSection,
      section98.CampaignDashboardQuickActionsSection,
      section99.CampaignDashboardRecentActivitySection,
      section100.CampaignDashboardSummaryCardsSection,
      section101.CommunityOutreachComplianceActionBarSection,
      section102.CommunityOutreachComplianceContentSummarySection,
      section103.CommunityOutreachComplianceHeaderSection,
      section104.CommunityOutreachCompliancePrimaryContentSection,
      section105.CommunityOutreachDashboardChartOverviewSection,
      section106.CommunityOutreachDashboardHeaderSection,
      section107.CommunityOutreachDashboardQuickActionsSection,
      section108.CommunityOutreachDashboardRecentActivitySection,
      section109.CommunityOutreachDashboardSummaryCardsSection,
      section110.ComplianceDashboardChartOverviewSection,
      section111.ComplianceDashboardHeaderSection,
      section112.ComplianceDashboardQuickActionsSection,
      section113.ComplianceDashboardRecentActivitySection,
      section114.ComplianceDashboardSummaryCardsSection,
      section115.ComplianceManagerAnalyticsChartAreaSection,
      section116.ComplianceManagerAnalyticsExportActionsSection,
      section117.ComplianceManagerAnalyticsFilterBarSection,
      section118.ComplianceManagerAnalyticsHeaderSection,
      section119.ComplianceManagerAnalyticsMetricsSummarySection,
      section120.ComplianceManagerComplianceActionBarSection,
      section121.ComplianceManagerComplianceContentSummarySection,
      section122.ComplianceManagerComplianceHeaderSection,
      section123.ComplianceManagerCompliancePrimaryContentSection,
      section124.ComplianceManagerDashboardChartOverviewSection,
      section125.ComplianceManagerDashboardHeaderSection,
      section126.ComplianceManagerDashboardQuickActionsSection,
      section127.ComplianceManagerDashboardRecentActivitySection,
      section128.ComplianceManagerDashboardSummaryCardsSection,
      section129.ComplianceManagerWorkflowActionBarSection,
      section130.ComplianceManagerWorkflowHeaderSection,
      section131.ComplianceManagerWorkflowTaskDetailsSection,
      section132.ComplianceManagerWorkflowTaskFiltersSection,
      section133.ComplianceManagerWorkflowTaskListSection,
      section134.CorrectiveActionActionBarSection,
      section135.CorrectiveActionHeaderSection,
      section136.CorrectiveActionTaskDetailsSection,
      section137.CorrectiveActionTaskFiltersSection,
      section138.CorrectiveActionTaskListSection,
      section139.CredentialExpiryActionBarSection,
      section140.CredentialExpiryContentSummarySection,
      section141.CredentialExpiryHeaderSection,
      section142.CredentialExpiryPrimaryContentSection,
      section143.DailyOperationsActionBarSection,
      section144.DailyOperationsContentSummarySection,
      section145.DailyOperationsHeaderSection,
      section146.DailyOperationsPrimaryContentSection,
      section147.EmployeeRecordsActionBarSection,
      section148.EmployeeRecordsDataTableSection,
      section149.EmployeeRecordsFilterBarSection,
      section150.EmployeeRecordsHeaderSection,
      section151.EmployeeRecordsPaginationSection,
      section152.FranchiseLeadActionBarSection,
      section153.FranchiseLeadContentSummarySection,
      section154.FranchiseLeadHeaderSection,
      section155.FranchiseLeadPrimaryContentSection,
      section156.FranchiseSalesManagerAnalyticsChartAreaSection,
      section157.FranchiseSalesManagerAnalyticsExportActionsSection,
      section158.FranchiseSalesManagerAnalyticsFilterBarSection,
      section159.FranchiseSalesManagerAnalyticsHeaderSection,
      section160.FranchiseSalesManagerAnalyticsMetricsSummarySection,
      section161.FranchiseSalesManagerComplianceActionBarSection,
      section162.FranchiseSalesManagerComplianceContentSummarySection,
      section163.FranchiseSalesManagerComplianceHeaderSection,
      section164.FranchiseSalesManagerCompliancePrimaryContentSection,
      section165.FranchiseSalesManagerDashboardChartOverviewSection,
      section166.FranchiseSalesManagerDashboardHeaderSection,
      section167.FranchiseSalesManagerDashboardQuickActionsSection,
      section168.FranchiseSalesManagerDashboardRecentActivitySection,
      section169.FranchiseSalesManagerDashboardSummaryCardsSection,
      section170.FranchiseSalesManagerWorkflowActionBarSection,
      section171.FranchiseSalesManagerWorkflowHeaderSection,
      section172.FranchiseSalesManagerWorkflowTaskDetailsSection,
      section173.FranchiseSalesManagerWorkflowTaskFiltersSection,
      section174.FranchiseSalesManagerWorkflowTaskListSection,
      section175.GeneralManagerAnalyticsChartAreaSection,
      section176.GeneralManagerAnalyticsExportActionsSection,
      section177.GeneralManagerAnalyticsFilterBarSection,
      section178.GeneralManagerAnalyticsHeaderSection,
      section179.GeneralManagerAnalyticsMetricsSummarySection,
      section180.GeneralManagerComplianceActionBarSection,
      section181.GeneralManagerComplianceContentSummarySection,
      section182.GeneralManagerComplianceHeaderSection,
      section183.GeneralManagerCompliancePrimaryContentSection,
      section184.GeneralManagerDashboardChartOverviewSection,
      section185.GeneralManagerDashboardHeaderSection,
      section186.GeneralManagerDashboardQuickActionsSection,
      section187.GeneralManagerDashboardRecentActivitySection,
      section188.GeneralManagerDashboardSummaryCardsSection,
      section189.GeneralManagerWorkflowActionBarSection,
      section190.GeneralManagerWorkflowHeaderSection,
      section191.GeneralManagerWorkflowTaskDetailsSection,
      section192.GeneralManagerWorkflowTaskFiltersSection,
      section193.GeneralManagerWorkflowTaskListSection,
      section194.GovernanceOfficerAnalyticsChartAreaSection,
      section195.GovernanceOfficerAnalyticsExportActionsSection,
      section196.GovernanceOfficerAnalyticsFilterBarSection,
      section197.GovernanceOfficerAnalyticsHeaderSection,
      section198.GovernanceOfficerAnalyticsMetricsSummarySection,
      section199.GovernanceOfficerComplianceActionBarSection,
      section200.GovernanceOfficerComplianceContentSummarySection,
      section201.GovernanceOfficerComplianceHeaderSection,
      section202.GovernanceOfficerCompliancePrimaryContentSection,
      section203.GovernanceOfficerDashboardChartOverviewSection,
      section204.GovernanceOfficerDashboardHeaderSection,
      section205.GovernanceOfficerDashboardQuickActionsSection,
      section206.GovernanceOfficerDashboardRecentActivitySection,
      section207.GovernanceOfficerDashboardSummaryCardsSection,
      section208.GovernanceOfficerWorkflowActionBarSection,
      section209.GovernanceOfficerWorkflowHeaderSection,
      section210.GovernanceOfficerWorkflowTaskDetailsSection,
      section211.GovernanceOfficerWorkflowTaskFiltersSection,
      section212.GovernanceOfficerWorkflowTaskListSection,
      section213.GrowthAnalyticsChartAreaSection,
      section214.GrowthAnalyticsExportActionsSection,
      section215.GrowthAnalyticsFilterBarSection,
      section216.GrowthAnalyticsHeaderSection,
      section217.GrowthAnalyticsMetricsSummarySection,
      section218.HeadOfBusDevAnalyticsChartAreaSection,
      section219.HeadOfBusDevAnalyticsExportActionsSection,
      section220.HeadOfBusDevAnalyticsFilterBarSection,
      section221.HeadOfBusDevAnalyticsHeaderSection,
      section222.HeadOfBusDevAnalyticsMetricsSummarySection,
      section223.HeadOfBusDevComplianceActionBarSection,
      section224.HeadOfBusDevComplianceContentSummarySection,
      section225.HeadOfBusDevComplianceHeaderSection,
      section226.HeadOfBusDevCompliancePrimaryContentSection,
      section227.HeadOfBusDevWorkflowActionBarSection,
      section228.HeadOfBusDevWorkflowHeaderSection,
      section229.HeadOfBusDevWorkflowTaskDetailsSection,
      section230.HeadOfBusDevWorkflowTaskFiltersSection,
      section231.HeadOfBusDevWorkflowTaskListSection,
      section232.HeadOfMarketingAnalyticsChartAreaSection,
      section233.HeadOfMarketingAnalyticsExportActionsSection,
      section234.HeadOfMarketingAnalyticsFilterBarSection,
      section235.HeadOfMarketingAnalyticsHeaderSection,
      section236.HeadOfMarketingAnalyticsMetricsSummarySection,
      section237.HeadOfMarketingComplianceActionBarSection,
      section238.HeadOfMarketingComplianceContentSummarySection,
      section239.HeadOfMarketingComplianceHeaderSection,
      section240.HeadOfMarketingCompliancePrimaryContentSection,
      section241.HeadOfMarketingWorkflowActionBarSection,
      section242.HeadOfMarketingWorkflowHeaderSection,
      section243.HeadOfMarketingWorkflowTaskDetailsSection,
      section244.HeadOfMarketingWorkflowTaskFiltersSection,
      section245.HeadOfMarketingWorkflowTaskListSection,
      section246.HiringPipelineActionBarSection,
      section247.HiringPipelineContentSummarySection,
      section248.HiringPipelineHeaderSection,
      section249.HiringPipelinePrimaryContentSection,
      section250.IncidentManagementActionBarSection,
      section251.IncidentManagementContentSummarySection,
      section252.IncidentManagementHeaderSection,
      section253.IncidentManagementPrimaryContentSection,
      section254.LeadAnalyticsChartAreaSection,
      section255.LeadAnalyticsExportActionsSection,
      section256.LeadAnalyticsFilterBarSection,
      section257.LeadAnalyticsHeaderSection,
      section258.LeadAnalyticsMetricsSummarySection,
      section259.LegalAnalyticsChartAreaSection,
      section260.LegalAnalyticsExportActionsSection,
      section261.LegalAnalyticsFilterBarSection,
      section262.LegalAnalyticsHeaderSection,
      section263.LegalAnalyticsMetricsSummarySection,
      section264.LegalWorkflowActionBarSection,
      section265.LegalWorkflowHeaderSection,
      section266.LegalWorkflowTaskDetailsSection,
      section267.LegalWorkflowTaskFiltersSection,
      section268.LegalWorkflowTaskListSection,
      section269.LocalMarketingManagerAnalyticsChartAreaSection,
      section270.LocalMarketingManagerAnalyticsExportActionsSection,
      section271.LocalMarketingManagerAnalyticsFilterBarSection,
      section272.LocalMarketingManagerAnalyticsHeaderSection,
      section273.LocalMarketingManagerAnalyticsMetricsSummarySection,
      section274.LocalMarketingManagerComplianceActionBarSection,
      section275.LocalMarketingManagerComplianceContentSummarySection,
      section276.LocalMarketingManagerComplianceHeaderSection,
      section277.LocalMarketingManagerCompliancePrimaryContentSection,
      section278.LocalMarketingManagerDashboardChartOverviewSection,
      section279.LocalMarketingManagerDashboardHeaderSection,
      section280.LocalMarketingManagerDashboardQuickActionsSection,
      section281.LocalMarketingManagerDashboardRecentActivitySection,
      section282.LocalMarketingManagerDashboardSummaryCardsSection,
      section283.LocalMarketingManagerWorkflowActionBarSection,
      section284.LocalMarketingManagerWorkflowHeaderSection,
      section285.LocalMarketingManagerWorkflowTaskDetailsSection,
      section286.LocalMarketingManagerWorkflowTaskFiltersSection,
      section287.LocalMarketingManagerWorkflowTaskListSection,
      section288.OnboardingActionBarSection,
      section289.OnboardingContentSummarySection,
      section290.OnboardingHeaderSection,
      section291.OnboardingPrimaryContentSection,
      section292.OperationsManagerAnalyticsChartAreaSection,
      section293.OperationsManagerAnalyticsExportActionsSection,
      section294.OperationsManagerAnalyticsFilterBarSection,
      section295.OperationsManagerAnalyticsHeaderSection,
      section296.OperationsManagerAnalyticsMetricsSummarySection,
      section297.OperationsManagerComplianceActionBarSection,
      section298.OperationsManagerComplianceContentSummarySection,
      section299.OperationsManagerComplianceHeaderSection,
      section300.OperationsManagerCompliancePrimaryContentSection,
      section301.OperationsManagerWorkflowActionBarSection,
      section302.OperationsManagerWorkflowHeaderSection,
      section303.OperationsManagerWorkflowTaskDetailsSection,
      section304.OperationsManagerWorkflowTaskFiltersSection,
      section305.OperationsManagerWorkflowTaskListSection,
      section306.OutreachCampaignActionBarSection,
      section307.OutreachCampaignContentSummarySection,
      section308.OutreachCampaignHeaderSection,
      section309.OutreachCampaignPrimaryContentSection,
      section310.PartnershipManagementActionBarSection,
      section311.PartnershipManagementContentSummarySection,
      section312.PartnershipManagementHeaderSection,
      section313.PartnershipManagementPrimaryContentSection,
      section314.PartnershipManagerAnalyticsChartAreaSection,
      section315.PartnershipManagerAnalyticsExportActionsSection,
      section316.PartnershipManagerAnalyticsFilterBarSection,
      section317.PartnershipManagerAnalyticsHeaderSection,
      section318.PartnershipManagerAnalyticsMetricsSummarySection,
      section319.PartnershipManagerComplianceActionBarSection,
      section320.PartnershipManagerComplianceContentSummarySection,
      section321.PartnershipManagerComplianceHeaderSection,
      section322.PartnershipManagerCompliancePrimaryContentSection,
      section323.PartnershipManagerDashboardChartOverviewSection,
      section324.PartnershipManagerDashboardHeaderSection,
      section325.PartnershipManagerDashboardQuickActionsSection,
      section326.PartnershipManagerDashboardRecentActivitySection,
      section327.PartnershipManagerDashboardSummaryCardsSection,
      section328.PartnershipManagerWorkflowActionBarSection,
      section329.PartnershipManagerWorkflowHeaderSection,
      section330.PartnershipManagerWorkflowTaskDetailsSection,
      section331.PartnershipManagerWorkflowTaskFiltersSection,
      section332.PartnershipManagerWorkflowTaskListSection,
      section333.PolicyManagementActionBarSection,
      section334.PolicyManagementContentSummarySection,
      section335.PolicyManagementHeaderSection,
      section336.PolicyManagementPrimaryContentSection,
      section337.PremiumConciergeDashboardChartOverviewSection,
      section338.PremiumConciergeDashboardHeaderSection,
      section339.PremiumConciergeDashboardQuickActionsSection,
      section340.PremiumConciergeDashboardRecentActivitySection,
      section341.PremiumConciergeDashboardSummaryCardsSection,
      section342.RegionalBdmAnalyticsChartAreaSection,
      section343.RegionalBdmAnalyticsExportActionsSection,
      section344.RegionalBdmAnalyticsFilterBarSection,
      section345.RegionalBdmAnalyticsHeaderSection,
      section346.RegionalBdmAnalyticsMetricsSummarySection,
      section347.RegionalBdmComplianceActionBarSection,
      section348.RegionalBdmComplianceContentSummarySection,
      section349.RegionalBdmComplianceHeaderSection,
      section350.RegionalBdmCompliancePrimaryContentSection,
      section351.RegionalBdmDashboardChartOverviewSection,
      section352.RegionalBdmDashboardHeaderSection,
      section353.RegionalBdmDashboardQuickActionsSection,
      section354.RegionalBdmDashboardRecentActivitySection,
      section355.RegionalBdmDashboardSummaryCardsSection,
      section356.RegionalBdmWorkflowActionBarSection,
      section357.RegionalBdmWorkflowHeaderSection,
      section358.RegionalBdmWorkflowTaskDetailsSection,
      section359.RegionalBdmWorkflowTaskFiltersSection,
      section360.RegionalBdmWorkflowTaskListSection,
      section361.RegionalManagerUsaAnalyticsChartAreaSection,
      section362.RegionalManagerUsaAnalyticsExportActionsSection,
      section363.RegionalManagerUsaAnalyticsFilterBarSection,
      section364.RegionalManagerUsaAnalyticsHeaderSection,
      section365.RegionalManagerUsaAnalyticsMetricsSummarySection,
      section366.RegionalManagerUsaComplianceActionBarSection,
      section367.RegionalManagerUsaComplianceContentSummarySection,
      section368.RegionalManagerUsaComplianceHeaderSection,
      section369.RegionalManagerUsaCompliancePrimaryContentSection,
      section370.RegionalManagerUsaDashboardChartOverviewSection,
      section371.RegionalManagerUsaDashboardHeaderSection,
      section372.RegionalManagerUsaDashboardQuickActionsSection,
      section373.RegionalManagerUsaDashboardRecentActivitySection,
      section374.RegionalManagerUsaDashboardSummaryCardsSection,
      section375.RegionalManagerUsaWorkflowActionBarSection,
      section376.RegionalManagerUsaWorkflowHeaderSection,
      section377.RegionalManagerUsaWorkflowTaskDetailsSection,
      section378.RegionalManagerUsaWorkflowTaskFiltersSection,
      section379.RegionalManagerUsaWorkflowTaskListSection,
      section380.SchedulingHealthActionBarSection,
      section381.SchedulingHealthContentSummarySection,
      section382.SchedulingHealthHeaderSection,
      section383.SchedulingHealthPrimaryContentSection,
      section384.ScrumMasterComplianceActionBarSection,
      section385.ScrumMasterComplianceContentSummarySection,
      section386.ScrumMasterComplianceHeaderSection,
      section387.ScrumMasterCompliancePrimaryContentSection,
      section388.ServiceIssueActionBarSection,
      section389.ServiceIssueContentSummarySection,
      section390.ServiceIssueHeaderSection,
      section391.ServiceIssuePrimaryContentSection,
      section392.SocialMediaActionBarSection,
      section393.SocialMediaContentSummarySection,
      section394.SocialMediaHeaderSection,
      section395.SocialMediaPrimaryContentSection,
      section396.TerritoryExpansionManagerAnalyticsChartAreaSection,
      section397.TerritoryExpansionManagerAnalyticsExportActionsSection,
      section398.TerritoryExpansionManagerAnalyticsFilterBarSection,
      section399.TerritoryExpansionManagerAnalyticsHeaderSection,
      section400.TerritoryExpansionManagerAnalyticsMetricsSummarySection,
      section401.TerritoryExpansionManagerComplianceActionBarSection,
      section402.TerritoryExpansionManagerComplianceContentSummarySection,
      section403.TerritoryExpansionManagerComplianceHeaderSection,
      section404.TerritoryExpansionManagerCompliancePrimaryContentSection,
      section405.TerritoryExpansionManagerDashboardChartOverviewSection,
      section406.TerritoryExpansionManagerDashboardHeaderSection,
      section407.TerritoryExpansionManagerDashboardQuickActionsSection,
      section408.TerritoryExpansionManagerDashboardRecentActivitySection,
      section409.TerritoryExpansionManagerDashboardSummaryCardsSection,
      section410.TerritoryExpansionManagerWorkflowActionBarSection,
      section411.TerritoryExpansionManagerWorkflowHeaderSection,
      section412.TerritoryExpansionManagerWorkflowTaskDetailsSection,
      section413.TerritoryExpansionManagerWorkflowTaskFiltersSection,
      section414.TerritoryExpansionManagerWorkflowTaskListSection,
      section415.TerritorySalesManagerAnalyticsChartAreaSection,
      section416.TerritorySalesManagerAnalyticsExportActionsSection,
      section417.TerritorySalesManagerAnalyticsFilterBarSection,
      section418.TerritorySalesManagerAnalyticsHeaderSection,
      section419.TerritorySalesManagerAnalyticsMetricsSummarySection,
      section420.TerritorySalesManagerComplianceActionBarSection,
      section421.TerritorySalesManagerComplianceContentSummarySection,
      section422.TerritorySalesManagerComplianceHeaderSection,
      section423.TerritorySalesManagerCompliancePrimaryContentSection,
      section424.TerritorySalesManagerDashboardChartOverviewSection,
      section425.TerritorySalesManagerDashboardHeaderSection,
      section426.TerritorySalesManagerDashboardQuickActionsSection,
      section427.TerritorySalesManagerDashboardRecentActivitySection,
      section428.TerritorySalesManagerDashboardSummaryCardsSection,
      section429.TerritorySalesManagerWorkflowActionBarSection,
      section430.TerritorySalesManagerWorkflowHeaderSection,
      section431.TerritorySalesManagerWorkflowTaskDetailsSection,
      section432.TerritorySalesManagerWorkflowTaskFiltersSection,
      section433.TerritorySalesManagerWorkflowTaskListSection,
      section434.TrainingManagementActionBarSection,
      section435.TrainingManagementContentSummarySection,
      section436.TrainingManagementHeaderSection,
      section437.TrainingManagementPrimaryContentSection,
      section438.VipManagerDashboardChartOverviewSection,
      section439.VipManagerDashboardHeaderSection,
      section440.VipManagerDashboardQuickActionsSection,
      section441.VipManagerDashboardRecentActivitySection,
      section442.VipManagerDashboardSummaryCardsSection,
      section443.PremiumConciergeAnalyticsChartAreaSection,
      section444.PremiumConciergeAnalyticsExportActionsSection,
      section445.PremiumConciergeAnalyticsFilterBarSection,
      section446.PremiumConciergeAnalyticsHeaderSection,
      section447.PremiumConciergeAnalyticsMetricsSummarySection,
      section448.PremiumConciergeWorkflowActionBarSection,
      section449.PremiumConciergeWorkflowHeaderSection,
      section450.PremiumConciergeWorkflowTaskDetailsSection,
      section451.PremiumConciergeWorkflowTaskFiltersSection,
      section452.PremiumConciergeWorkflowTaskListSection,
      section453.CaregiverClientProfileActionBarSection,
      section454.CaregiverClientProfileDetailsFormSection,
      section455.CaregiverClientProfileHeaderSection,
      section456.CaregiverClientProfileIdentitySummarySection,
      section457.CaregiverClientProfilePreferencesOrDocumentsSection,
      section458.CaregiverIncidentReportChartAreaSection,
      section459.CaregiverIncidentReportExportActionsSection,
      section460.CaregiverIncidentReportFilterBarSection,
      section461.CaregiverIncidentReportHeaderSection,
      section462.CaregiverIncidentReportMetricsSummarySection,
      section463.CaregiverScheduleActionBarSection,
      section464.CaregiverScheduleAppointmentDetailsSection,
      section465.CaregiverScheduleCalendarControlsSection,
      section466.CaregiverScheduleHeaderSection,
      section467.CaregiverScheduleScheduleListSection,
      section468.CaregiverTasksActionBarSection,
      section469.CaregiverTasksHeaderSection,
      section470.CaregiverTasksTaskDetailsSection,
      section471.CaregiverTasksTaskFiltersSection,
      section472.CaregiverTasksTaskListSection,
      section473.CaregiverVisitNotesActionBarSection,
      section474.CaregiverVisitNotesClientContextSection,
      section475.CaregiverVisitNotesHeaderSection,
      section476.CaregiverVisitNotesNotesFormSection,
      section477.CaregiverVisitNotesNotesHistorySection,
      section478.MessagingActionBarSection,
      section479.MessagingContentSummarySection,
      section480.MessagingHeaderSection,
      section481.MessagingPrimaryContentSection,
      section482.PswAnalyticsChartAreaSection,
      section483.PswAnalyticsExportActionsSection,
      section484.PswAnalyticsFilterBarSection,
      section485.PswAnalyticsHeaderSection,
      section486.PswAnalyticsMetricsSummarySection,
      section487.PswCarePlanActionBarSection,
      section488.PswCarePlanContentSummarySection,
      section489.PswCarePlanHeaderSection,
      section490.PswCarePlanPrimaryContentSection,
      section491.PswClientProfileActionBarSection,
      section492.PswClientProfileDetailsFormSection,
      section493.PswClientProfileHeaderSection,
      section494.PswClientProfileIdentitySummarySection,
      section495.PswClientProfilePreferencesOrDocumentsSection,
      section496.PswClientsActionBarSection,
      section497.PswClientsDetailsFormSection,
      section498.PswClientsHeaderSection,
      section499.PswClientsIdentitySummarySection,
      section500.PswClientsPreferencesOrDocumentsSection,
      section501.PswCommandCenterActionBarSection,
      section502.PswCommandCenterDataTableSection,
      section503.PswCommandCenterFilterBarSection,
      section504.PswCommandCenterHeaderSection,
      section505.PswCommandCenterPaginationSection,
      section506.PswComplianceActionBarSection,
      section507.PswComplianceContentSummarySection,
      section508.PswComplianceHeaderSection,
      section509.PswCompliancePrimaryContentSection,
      section510.PswDocumentsActionBarSection,
      section511.PswDocumentsContentSummarySection,
      section512.PswDocumentsHeaderSection,
      section513.PswDocumentsPrimaryContentSection,
      section514.PswIncidentReportChartAreaSection,
      section515.PswIncidentReportExportActionsSection,
      section516.PswIncidentReportFilterBarSection,
      section517.PswIncidentReportHeaderSection,
      section518.PswIncidentReportMetricsSummarySection,
      section519.PswMessagesActionBarSection,
      section520.PswMessagesContentSummarySection,
      section521.PswMessagesHeaderSection,
      section522.PswMessagesPrimaryContentSection,
      section523.PswMyShiftsActionBarSection,
      section524.PswMyShiftsContentSummarySection,
      section525.PswMyShiftsHeaderSection,
      section526.PswMyShiftsPrimaryContentSection,
      section527.PswShiftTrackerActionBarSection,
      section528.PswShiftTrackerAppointmentDetailsSection,
      section529.PswShiftTrackerCalendarControlsSection,
      section530.PswShiftTrackerHeaderSection,
      section531.PswShiftTrackerScheduleListSection,
      section532.PswTasksActionBarSection,
      section533.PswTasksAppointmentDetailsSection,
      section534.PswTasksCalendarControlsSection,
      section535.PswTasksHeaderSection,
      section536.PswTasksScheduleListSection,
      section537.PswVisitNotesActionBarSection,
      section538.PswVisitNotesClientContextSection,
      section539.PswVisitNotesHeaderSection,
      section540.PswVisitNotesNotesFormSection,
      section541.PswVisitNotesNotesHistorySection,
      section542.PswVitalsLogActionBarSection,
      section543.PswVitalsLogDataTableSection,
      section544.PswVitalsLogFilterBarSection,
      section545.PswVitalsLogHeaderSection,
      section546.PswVitalsLogPaginationSection,
      section547.PswWorkflowActionBarSection,
      section548.PswWorkflowHeaderSection,
      section549.PswWorkflowTaskDetailsSection,
      section550.PswWorkflowTaskFiltersSection,
      section551.PswWorkflowTaskListSection,
      section552.ScheduleActionBarSection,
      section553.ScheduleAppointmentDetailsSection,
      section554.ScheduleCalendarControlsSection,
      section555.ScheduleHeaderSection,
      section556.ScheduleScheduleListSection,
      section557.ShiftTasksActionBarSection,
      section558.ShiftTasksHeaderSection,
      section559.ShiftTasksTaskDetailsSection,
      section560.ShiftTasksTaskFiltersSection,
      section561.ShiftTasksTaskListSection,
      section562.VitalsEntryActionBarSection,
      section563.VitalsEntryContentSummarySection,
      section564.VitalsEntryHeaderSection,
      section565.VitalsEntryPrimaryContentSection,
      section566.CarePlanReviewActionBarSection,
      section567.CarePlanReviewDataTableSection,
      section568.CarePlanReviewFilterBarSection,
      section569.CarePlanReviewHeaderSection,
      section570.CarePlanReviewPaginationSection,
      section571.CnsAnalyticsChartAreaSection,
      section572.CnsAnalyticsExportActionsSection,
      section573.CnsAnalyticsFilterBarSection,
      section574.CnsAnalyticsHeaderSection,
      section575.CnsAnalyticsMetricsSummarySection,
      section576.CnsWorkflowActionBarSection,
      section577.CnsWorkflowHeaderSection,
      section578.CnsWorkflowTaskDetailsSection,
      section579.CnsWorkflowTaskFiltersSection,
      section580.CnsWorkflowTaskListSection,
      section581.IncidentReviewActionBarSection,
      section582.IncidentReviewDataTableSection,
      section583.IncidentReviewFilterBarSection,
      section584.IncidentReviewHeaderSection,
      section585.IncidentReviewPaginationSection,
      section586.MedicationAdministrationActionBarSection,
      section587.MedicationAdministrationContentSummarySection,
      section588.MedicationAdministrationHeaderSection,
      section589.MedicationAdministrationPrimaryContentSection,
      section590.NpAnalyticsChartAreaSection,
      section591.NpAnalyticsExportActionsSection,
      section592.NpAnalyticsFilterBarSection,
      section593.NpAnalyticsHeaderSection,
      section594.NpAnalyticsMetricsSummarySection,
      section595.NpWorkflowActionBarSection,
      section596.NpWorkflowHeaderSection,
      section597.NpWorkflowTaskDetailsSection,
      section598.NpWorkflowTaskFiltersSection,
      section599.NpWorkflowTaskListSection,
    ];
    expect(types, hasLength(600));
  });
}
