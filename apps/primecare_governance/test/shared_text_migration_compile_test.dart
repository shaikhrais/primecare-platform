// Compile smoke coverage for migrated shared controls.
// Compilation does not establish screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/governance/screen_work_item.dart' as migrated0;
import 'package:primecare_governance/core/governance/screen_work_registry.dart' as migrated1;
import 'package:primecare_governance/core/ui/app_components.dart' as migrated2;
import 'package:primecare_governance/core/ui/audit_sandbox/sections/audit_sandbox_action_bar_section.dart' as migrated3;
import 'package:primecare_governance/core/ui/audit_sandbox/sections/audit_sandbox_content_summary_section.dart' as migrated4;
import 'package:primecare_governance/core/ui/audit_sandbox/sections/audit_sandbox_header_section.dart' as migrated5;
import 'package:primecare_governance/core/ui/audit_sandbox/sections/audit_sandbox_primary_content_section.dart' as migrated6;
import 'package:primecare_governance/core/ui/audit_sandbox_screen.dart' as migrated7;
import 'package:primecare_governance/core/ui/blueprint_sandbox/sections/blueprint_sandbox_action_bar_section.dart' as migrated8;
import 'package:primecare_governance/core/ui/blueprint_sandbox/sections/blueprint_sandbox_content_summary_section.dart' as migrated9;
import 'package:primecare_governance/core/ui/blueprint_sandbox/sections/blueprint_sandbox_header_section.dart' as migrated10;
import 'package:primecare_governance/core/ui/blueprint_sandbox/sections/blueprint_sandbox_primary_content_section.dart' as migrated11;
import 'package:primecare_governance/core/ui/blueprint_sandbox_screen.dart' as migrated12;
import 'package:primecare_governance/core/ui/dev_toolbox.dart' as migrated13;
import 'package:primecare_governance/core/ui/dynamic/sections/dynamic_action_bar_section.dart' as migrated14;
import 'package:primecare_governance/core/ui/dynamic/sections/dynamic_content_summary_section.dart' as migrated15;
import 'package:primecare_governance/core/ui/dynamic/sections/dynamic_header_section.dart' as migrated16;
import 'package:primecare_governance/core/ui/dynamic/sections/dynamic_primary_content_section.dart' as migrated17;
import 'package:primecare_governance/core/ui/dynamic_form_builder.dart' as migrated18;
import 'package:primecare_governance/core/ui/dynamic_screen.dart' as migrated19;
import 'package:primecare_governance/core/ui/dynamic_screen_view.dart' as migrated20;
import 'package:primecare_governance/core/ui/no_access/sections/no_access_action_bar_section.dart' as migrated21;
import 'package:primecare_governance/core/ui/no_access/sections/no_access_content_summary_section.dart' as migrated22;
import 'package:primecare_governance/core/ui/no_access/sections/no_access_header_section.dart' as migrated23;
import 'package:primecare_governance/core/ui/no_access/sections/no_access_primary_content_section.dart' as migrated24;
import 'package:primecare_governance/core/ui/no_access_screen.dart' as migrated25;
import 'package:primecare_governance/core/ui/sections/audit_sandbox_action_bar_section.dart' as migrated26;
import 'package:primecare_governance/core/ui/sections/audit_sandbox_content_summary_section.dart' as migrated27;
import 'package:primecare_governance/core/ui/sections/audit_sandbox_header_section.dart' as migrated28;
import 'package:primecare_governance/core/ui/sections/audit_sandbox_primary_content_section.dart' as migrated29;
import 'package:primecare_governance/core/ui/sections/blueprint_sandbox_action_bar_section.dart' as migrated30;
import 'package:primecare_governance/core/ui/sections/blueprint_sandbox_content_summary_section.dart' as migrated31;
import 'package:primecare_governance/core/ui/sections/blueprint_sandbox_header_section.dart' as migrated32;
import 'package:primecare_governance/core/ui/sections/blueprint_sandbox_primary_content_section.dart' as migrated33;
import 'package:primecare_governance/core/ui/sections/dynamic_action_bar_section.dart' as migrated34;
import 'package:primecare_governance/core/ui/sections/dynamic_content_summary_section.dart' as migrated35;
import 'package:primecare_governance/core/ui/sections/dynamic_header_section.dart' as migrated36;
import 'package:primecare_governance/core/ui/sections/dynamic_primary_content_section.dart' as migrated37;
import 'package:primecare_governance/core/ui/sections/no_access_action_bar_section.dart' as migrated38;
import 'package:primecare_governance/core/ui/sections/no_access_content_summary_section.dart' as migrated39;
import 'package:primecare_governance/core/ui/sections/no_access_header_section.dart' as migrated40;
import 'package:primecare_governance/core/ui/sections/no_access_primary_content_section.dart' as migrated41;
import 'package:primecare_governance/core/ui/state_widgets.dart' as migrated42;
import 'package:primecare_governance/features/audit/screens/audit_log/sections/audit_log_action_bar_section.dart' as migrated43;
import 'package:primecare_governance/features/audit/screens/audit_log/sections/audit_log_data_table_section.dart' as migrated44;
import 'package:primecare_governance/features/audit/screens/audit_log/sections/audit_log_filter_bar_section.dart' as migrated45;
import 'package:primecare_governance/features/audit/screens/audit_log/sections/audit_log_header_section.dart' as migrated46;
import 'package:primecare_governance/features/audit/screens/audit_log/sections/audit_log_pagination_section.dart' as migrated47;
import 'package:primecare_governance/features/audit/screens/audit_log_screen.dart' as migrated48;
import 'package:primecare_governance/features/audit/screens/monitoring/sections/monitoring_action_bar_section.dart' as migrated49;
import 'package:primecare_governance/features/audit/screens/monitoring/sections/monitoring_content_summary_section.dart' as migrated50;
import 'package:primecare_governance/features/audit/screens/monitoring/sections/monitoring_header_section.dart' as migrated51;
import 'package:primecare_governance/features/audit/screens/monitoring/sections/monitoring_primary_content_section.dart' as migrated52;
import 'package:primecare_governance/features/audit/screens/monitoring_screen.dart' as migrated53;
import 'package:primecare_governance/features/audit/screens/screen_status/sections/screen_status_action_bar_section.dart' as migrated54;
import 'package:primecare_governance/features/audit/screens/screen_status/sections/screen_status_content_summary_section.dart' as migrated55;
import 'package:primecare_governance/features/audit/screens/screen_status/sections/screen_status_header_section.dart' as migrated56;
import 'package:primecare_governance/features/audit/screens/screen_status/sections/screen_status_primary_content_section.dart' as migrated57;
import 'package:primecare_governance/features/audit/screens/screen_status_screen.dart' as migrated58;
import 'package:primecare_governance/features/audit/screens/sections/audit_log_action_bar_section.dart' as migrated59;
import 'package:primecare_governance/features/audit/screens/sections/audit_log_data_table_section.dart' as migrated60;
import 'package:primecare_governance/features/audit/screens/sections/audit_log_filter_bar_section.dart' as migrated61;
import 'package:primecare_governance/features/audit/screens/sections/audit_log_header_section.dart' as migrated62;
import 'package:primecare_governance/features/audit/screens/sections/audit_log_pagination_section.dart' as migrated63;
import 'package:primecare_governance/features/audit/screens/sections/monitoring_action_bar_section.dart' as migrated64;
import 'package:primecare_governance/features/audit/screens/sections/monitoring_content_summary_section.dart' as migrated65;
import 'package:primecare_governance/features/audit/screens/sections/monitoring_header_section.dart' as migrated66;
import 'package:primecare_governance/features/audit/screens/sections/monitoring_primary_content_section.dart' as migrated67;
import 'package:primecare_governance/features/audit/screens/sections/screen_status_action_bar_section.dart' as migrated68;
import 'package:primecare_governance/features/audit/screens/sections/screen_status_content_summary_section.dart' as migrated69;
import 'package:primecare_governance/features/audit/screens/sections/screen_status_header_section.dart' as migrated70;
import 'package:primecare_governance/features/audit/screens/sections/screen_status_primary_content_section.dart' as migrated71;
import 'package:primecare_governance/features/audit/screens/sections/ticket_center_action_bar_section.dart' as migrated72;
import 'package:primecare_governance/features/audit/screens/sections/ticket_center_content_summary_section.dart' as migrated73;
import 'package:primecare_governance/features/audit/screens/sections/ticket_center_header_section.dart' as migrated74;
import 'package:primecare_governance/features/audit/screens/sections/ticket_center_primary_content_section.dart' as migrated75;
import 'package:primecare_governance/features/audit/screens/ticket_center/sections/ticket_center_action_bar_section.dart' as migrated76;
import 'package:primecare_governance/features/audit/screens/ticket_center/sections/ticket_center_content_summary_section.dart' as migrated77;
import 'package:primecare_governance/features/audit/screens/ticket_center/sections/ticket_center_header_section.dart' as migrated78;
import 'package:primecare_governance/features/audit/screens/ticket_center/sections/ticket_center_primary_content_section.dart' as migrated79;
import 'package:primecare_governance/features/audit/screens/ticket_center_screen.dart' as migrated80;
import 'package:primecare_governance/features/executive/screens/control_center/sections/control_center_action_bar_section.dart' as migrated81;
import 'package:primecare_governance/features/executive/screens/control_center/sections/control_center_content_summary_section.dart' as migrated82;
import 'package:primecare_governance/features/executive/screens/control_center/sections/control_center_header_section.dart' as migrated83;
import 'package:primecare_governance/features/executive/screens/control_center/sections/control_center_primary_content_section.dart' as migrated84;
import 'package:primecare_governance/features/executive/screens/control_center_screen.dart' as migrated85;
import 'package:primecare_governance/features/executive/screens/governance_hud/sections/governance_hud_action_bar_section.dart' as migrated86;
import 'package:primecare_governance/features/executive/screens/governance_hud/sections/governance_hud_content_summary_section.dart' as migrated87;
import 'package:primecare_governance/features/executive/screens/governance_hud/sections/governance_hud_header_section.dart' as migrated88;
import 'package:primecare_governance/features/executive/screens/governance_hud/sections/governance_hud_primary_content_section.dart' as migrated89;
import 'package:primecare_governance/features/executive/screens/governance_hud_screen.dart' as migrated90;
import 'package:primecare_governance/features/executive/screens/growth_pipeline/sections/growth_pipeline_action_bar_section.dart' as migrated91;
import 'package:primecare_governance/features/executive/screens/growth_pipeline/sections/growth_pipeline_content_summary_section.dart' as migrated92;
import 'package:primecare_governance/features/executive/screens/growth_pipeline/sections/growth_pipeline_header_section.dart' as migrated93;
import 'package:primecare_governance/features/executive/screens/growth_pipeline/sections/growth_pipeline_primary_content_section.dart' as migrated94;
import 'package:primecare_governance/features/executive/screens/growth_pipeline_screen.dart' as migrated95;
import 'package:primecare_governance/features/executive/screens/leadership_reports/sections/leadership_reports_chart_area_section.dart' as migrated96;
import 'package:primecare_governance/features/executive/screens/leadership_reports/sections/leadership_reports_export_actions_section.dart' as migrated97;
import 'package:primecare_governance/features/executive/screens/leadership_reports/sections/leadership_reports_filter_bar_section.dart' as migrated98;
import 'package:primecare_governance/features/executive/screens/leadership_reports/sections/leadership_reports_header_section.dart' as migrated99;
import 'package:primecare_governance/features/executive/screens/leadership_reports/sections/leadership_reports_metrics_summary_section.dart' as migrated100;
import 'package:primecare_governance/features/executive/screens/leadership_reports_screen.dart' as migrated101;
import 'package:primecare_governance/features/executive/screens/proposals/sections/proposals_action_bar_section.dart' as migrated102;
import 'package:primecare_governance/features/executive/screens/proposals/sections/proposals_content_summary_section.dart' as migrated103;
import 'package:primecare_governance/features/executive/screens/proposals/sections/proposals_header_section.dart' as migrated104;
import 'package:primecare_governance/features/executive/screens/proposals/sections/proposals_primary_content_section.dart' as migrated105;
import 'package:primecare_governance/features/executive/screens/proposals_screen.dart' as migrated106;
import 'package:primecare_governance/features/executive/screens/regional_performance/sections/regional_performance_action_bar_section.dart' as migrated107;
import 'package:primecare_governance/features/executive/screens/regional_performance/sections/regional_performance_form_body_section.dart' as migrated108;
import 'package:primecare_governance/features/executive/screens/regional_performance/sections/regional_performance_header_section.dart' as migrated109;
import 'package:primecare_governance/features/executive/screens/regional_performance/sections/regional_performance_validation_messages_section.dart' as migrated110;
import 'package:primecare_governance/features/executive/screens/regional_performance_screen.dart' as migrated111;
import 'package:primecare_governance/features/executive/screens/sections/control_center_action_bar_section.dart' as migrated112;
import 'package:primecare_governance/features/executive/screens/sections/control_center_content_summary_section.dart' as migrated113;
import 'package:primecare_governance/features/executive/screens/sections/control_center_header_section.dart' as migrated114;
import 'package:primecare_governance/features/executive/screens/sections/control_center_primary_content_section.dart' as migrated115;
import 'package:primecare_governance/features/executive/screens/sections/governance_hud_action_bar_section.dart' as migrated116;
import 'package:primecare_governance/features/executive/screens/sections/governance_hud_content_summary_section.dart' as migrated117;
import 'package:primecare_governance/features/executive/screens/sections/governance_hud_header_section.dart' as migrated118;
import 'package:primecare_governance/features/executive/screens/sections/governance_hud_primary_content_section.dart' as migrated119;
import 'package:primecare_governance/features/executive/screens/sections/growth_pipeline_action_bar_section.dart' as migrated120;
import 'package:primecare_governance/features/executive/screens/sections/growth_pipeline_content_summary_section.dart' as migrated121;
import 'package:primecare_governance/features/executive/screens/sections/growth_pipeline_header_section.dart' as migrated122;
import 'package:primecare_governance/features/executive/screens/sections/growth_pipeline_primary_content_section.dart' as migrated123;
import 'package:primecare_governance/features/executive/screens/sections/leadership_reports_chart_area_section.dart' as migrated124;
import 'package:primecare_governance/features/executive/screens/sections/leadership_reports_export_actions_section.dart' as migrated125;
import 'package:primecare_governance/features/executive/screens/sections/leadership_reports_filter_bar_section.dart' as migrated126;
import 'package:primecare_governance/features/executive/screens/sections/leadership_reports_header_section.dart' as migrated127;
import 'package:primecare_governance/features/executive/screens/sections/leadership_reports_metrics_summary_section.dart' as migrated128;
import 'package:primecare_governance/features/executive/screens/sections/proposals_action_bar_section.dart' as migrated129;
import 'package:primecare_governance/features/executive/screens/sections/proposals_content_summary_section.dart' as migrated130;
import 'package:primecare_governance/features/executive/screens/sections/proposals_header_section.dart' as migrated131;
import 'package:primecare_governance/features/executive/screens/sections/proposals_primary_content_section.dart' as migrated132;
import 'package:primecare_governance/features/executive/screens/sections/regional_performance_action_bar_section.dart' as migrated133;
import 'package:primecare_governance/features/executive/screens/sections/regional_performance_form_body_section.dart' as migrated134;
import 'package:primecare_governance/features/executive/screens/sections/regional_performance_header_section.dart' as migrated135;
import 'package:primecare_governance/features/executive/screens/sections/regional_performance_validation_messages_section.dart' as migrated136;
import 'package:primecare_governance/features/generated_screens/unknown_dashboard_screen.dart' as migrated137;
import 'package:primecare_governance/features/qa/screens/audit_dashboard/sections/audit_dashboard_chart_overview_section.dart' as migrated138;
import 'package:primecare_governance/features/qa/screens/audit_dashboard/sections/audit_dashboard_header_section.dart' as migrated139;
import 'package:primecare_governance/features/qa/screens/audit_dashboard/sections/audit_dashboard_quick_actions_section.dart' as migrated140;
import 'package:primecare_governance/features/qa/screens/audit_dashboard/sections/audit_dashboard_recent_activity_section.dart' as migrated141;
import 'package:primecare_governance/features/qa/screens/audit_dashboard/sections/audit_dashboard_summary_cards_section.dart' as migrated142;
import 'package:primecare_governance/features/qa/screens/audit_dashboard_screen.dart' as migrated143;
import 'package:primecare_governance/features/qa/screens/compliance_reviews/sections/compliance_reviews_action_bar_section.dart' as migrated144;
import 'package:primecare_governance/features/qa/screens/compliance_reviews/sections/compliance_reviews_data_table_section.dart' as migrated145;
import 'package:primecare_governance/features/qa/screens/compliance_reviews/sections/compliance_reviews_filter_bar_section.dart' as migrated146;
import 'package:primecare_governance/features/qa/screens/compliance_reviews/sections/compliance_reviews_header_section.dart' as migrated147;
import 'package:primecare_governance/features/qa/screens/compliance_reviews/sections/compliance_reviews_pagination_section.dart' as migrated148;
import 'package:primecare_governance/features/qa/screens/compliance_reviews_screen.dart' as migrated149;
import 'package:primecare_governance/features/qa/screens/incident_reports/sections/incident_reports_chart_area_section.dart' as migrated150;
import 'package:primecare_governance/features/qa/screens/incident_reports/sections/incident_reports_export_actions_section.dart' as migrated151;
import 'package:primecare_governance/features/qa/screens/incident_reports/sections/incident_reports_filter_bar_section.dart' as migrated152;
import 'package:primecare_governance/features/qa/screens/incident_reports/sections/incident_reports_header_section.dart' as migrated153;
import 'package:primecare_governance/features/qa/screens/incident_reports/sections/incident_reports_metrics_summary_section.dart' as migrated154;
import 'package:primecare_governance/features/qa/screens/incident_reports_screen.dart' as migrated155;
import 'package:primecare_governance/features/qa/screens/quality_metrics/sections/quality_metrics_chart_area_section.dart' as migrated156;
import 'package:primecare_governance/features/qa/screens/quality_metrics/sections/quality_metrics_export_actions_section.dart' as migrated157;
import 'package:primecare_governance/features/qa/screens/quality_metrics/sections/quality_metrics_filter_bar_section.dart' as migrated158;
import 'package:primecare_governance/features/qa/screens/quality_metrics/sections/quality_metrics_header_section.dart' as migrated159;
import 'package:primecare_governance/features/qa/screens/quality_metrics/sections/quality_metrics_metrics_summary_section.dart' as migrated160;
import 'package:primecare_governance/features/qa/screens/quality_metrics_screen.dart' as migrated161;
import 'package:primecare_governance/features/qa/screens/sections/audit_dashboard_chart_overview_section.dart' as migrated162;
import 'package:primecare_governance/features/qa/screens/sections/audit_dashboard_header_section.dart' as migrated163;
import 'package:primecare_governance/features/qa/screens/sections/audit_dashboard_quick_actions_section.dart' as migrated164;
import 'package:primecare_governance/features/qa/screens/sections/audit_dashboard_recent_activity_section.dart' as migrated165;
import 'package:primecare_governance/features/qa/screens/sections/audit_dashboard_summary_cards_section.dart' as migrated166;
import 'package:primecare_governance/features/qa/screens/sections/compliance_reviews_action_bar_section.dart' as migrated167;
import 'package:primecare_governance/features/qa/screens/sections/compliance_reviews_data_table_section.dart' as migrated168;
import 'package:primecare_governance/features/qa/screens/sections/compliance_reviews_filter_bar_section.dart' as migrated169;
import 'package:primecare_governance/features/qa/screens/sections/compliance_reviews_header_section.dart' as migrated170;
import 'package:primecare_governance/features/qa/screens/sections/compliance_reviews_pagination_section.dart' as migrated171;
import 'package:primecare_governance/features/qa/screens/sections/incident_reports_chart_area_section.dart' as migrated172;
import 'package:primecare_governance/features/qa/screens/sections/incident_reports_export_actions_section.dart' as migrated173;
import 'package:primecare_governance/features/qa/screens/sections/incident_reports_filter_bar_section.dart' as migrated174;
import 'package:primecare_governance/features/qa/screens/sections/incident_reports_header_section.dart' as migrated175;
import 'package:primecare_governance/features/qa/screens/sections/incident_reports_metrics_summary_section.dart' as migrated176;
import 'package:primecare_governance/features/qa/screens/sections/quality_metrics_chart_area_section.dart' as migrated177;
import 'package:primecare_governance/features/qa/screens/sections/quality_metrics_export_actions_section.dart' as migrated178;
import 'package:primecare_governance/features/qa/screens/sections/quality_metrics_filter_bar_section.dart' as migrated179;
import 'package:primecare_governance/features/qa/screens/sections/quality_metrics_header_section.dart' as migrated180;
import 'package:primecare_governance/features/qa/screens/sections/quality_metrics_metrics_summary_section.dart' as migrated181;
import 'package:primecare_governance/features/reference/screens/clinical_reference/sections/clinical_reference_action_bar_section.dart' as migrated182;
import 'package:primecare_governance/features/reference/screens/clinical_reference/sections/clinical_reference_content_summary_section.dart' as migrated183;
import 'package:primecare_governance/features/reference/screens/clinical_reference/sections/clinical_reference_header_section.dart' as migrated184;
import 'package:primecare_governance/features/reference/screens/clinical_reference/sections/clinical_reference_primary_content_section.dart' as migrated185;
import 'package:primecare_governance/features/reference/screens/clinical_reference_screen.dart' as migrated186;
import 'package:primecare_governance/features/reference/screens/sections/clinical_reference_action_bar_section.dart' as migrated187;
import 'package:primecare_governance/features/reference/screens/sections/clinical_reference_content_summary_section.dart' as migrated188;
import 'package:primecare_governance/features/reference/screens/sections/clinical_reference_header_section.dart' as migrated189;
import 'package:primecare_governance/features/reference/screens/sections/clinical_reference_primary_content_section.dart' as migrated190;
import 'package:primecare_governance/features/security/screens/sections/security_hub_action_bar_section.dart' as migrated191;
import 'package:primecare_governance/features/security/screens/sections/security_hub_content_summary_section.dart' as migrated192;
import 'package:primecare_governance/features/security/screens/sections/security_hub_header_section.dart' as migrated193;
import 'package:primecare_governance/features/security/screens/sections/security_hub_primary_content_section.dart' as migrated194;
import 'package:primecare_governance/features/security/screens/sections/security_sentinel_action_bar_section.dart' as migrated195;
import 'package:primecare_governance/features/security/screens/sections/security_sentinel_content_summary_section.dart' as migrated196;
import 'package:primecare_governance/features/security/screens/sections/security_sentinel_header_section.dart' as migrated197;
import 'package:primecare_governance/features/security/screens/sections/security_sentinel_primary_content_section.dart' as migrated198;
import 'package:primecare_governance/features/security/screens/sections/verification_center_action_bar_section.dart' as migrated199;
import 'package:primecare_governance/features/security/screens/sections/verification_center_content_summary_section.dart' as migrated200;
import 'package:primecare_governance/features/security/screens/sections/verification_center_header_section.dart' as migrated201;
import 'package:primecare_governance/features/security/screens/sections/verification_center_primary_content_section.dart' as migrated202;
import 'package:primecare_governance/features/security/screens/security_hub/sections/security_hub_action_bar_section.dart' as migrated203;
import 'package:primecare_governance/features/security/screens/security_hub/sections/security_hub_content_summary_section.dart' as migrated204;
import 'package:primecare_governance/features/security/screens/security_hub/sections/security_hub_header_section.dart' as migrated205;
import 'package:primecare_governance/features/security/screens/security_hub/sections/security_hub_primary_content_section.dart' as migrated206;
import 'package:primecare_governance/features/security/screens/security_hub_screen.dart' as migrated207;
import 'package:primecare_governance/features/security/screens/security_sentinel/sections/security_sentinel_action_bar_section.dart' as migrated208;
import 'package:primecare_governance/features/security/screens/security_sentinel/sections/security_sentinel_content_summary_section.dart' as migrated209;
import 'package:primecare_governance/features/security/screens/security_sentinel/sections/security_sentinel_header_section.dart' as migrated210;
import 'package:primecare_governance/features/security/screens/security_sentinel/sections/security_sentinel_primary_content_section.dart' as migrated211;
import 'package:primecare_governance/features/security/screens/security_sentinel_screen.dart' as migrated212;
import 'package:primecare_governance/features/security/screens/verification_center/sections/verification_center_action_bar_section.dart' as migrated213;
import 'package:primecare_governance/features/security/screens/verification_center/sections/verification_center_content_summary_section.dart' as migrated214;
import 'package:primecare_governance/features/security/screens/verification_center/sections/verification_center_header_section.dart' as migrated215;
import 'package:primecare_governance/features/security/screens/verification_center/sections/verification_center_primary_content_section.dart' as migrated216;
import 'package:primecare_governance/features/security/screens/verification_center_screen.dart' as migrated217;
import 'package:primecare_governance/governance/widgets/governance_event_feed.dart' as migrated218;
import 'package:primecare_governance/governance/widgets/governance_kpi_grid.dart' as migrated219;
import 'package:primecare_governance/governance/widgets/governance_master_score.dart' as migrated220;
import 'package:primecare_governance/governance/widgets/governance_role_viewer.dart' as migrated221;
import 'package:primecare_governance/governance/widgets/governance_trend_chart.dart' as migrated222;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
      migrated0.ScreenWorkItem,
      migrated1.ScreenWorkRegistry,
      migrated2.AppButton,
      migrated3.AuditSandboxActionBarSection,
      migrated4.AuditSandboxContentSummarySection,
      migrated5.AuditSandboxHeaderSection,
      migrated6.AuditSandboxPrimaryContentSection,
      migrated7.AuditSandboxScreen,
      migrated8.BlueprintSandboxActionBarSection,
      migrated9.BlueprintSandboxContentSummarySection,
      migrated10.BlueprintSandboxHeaderSection,
      migrated11.BlueprintSandboxPrimaryContentSection,
      migrated12.BlueprintSandboxScreen,
      migrated13.DevToolbox,
      migrated14.DynamicActionBarSection,
      migrated15.DynamicContentSummarySection,
      migrated16.DynamicHeaderSection,
      migrated17.DynamicPrimaryContentSection,
      migrated18.FormFieldConfig,
      migrated19.DynamicScreen,
      migrated20.AuditSandboxScreenState,
      migrated21.NoAccessActionBarSection,
      migrated22.NoAccessContentSummarySection,
      migrated23.NoAccessHeaderSection,
      migrated24.NoAccessPrimaryContentSection,
      migrated25.NoAccessScreen,
      migrated26.AuditSandboxActionBarSection,
      migrated27.AuditSandboxContentSummarySection,
      migrated28.AuditSandboxHeaderSection,
      migrated29.AuditSandboxPrimaryContentSection,
      migrated30.BlueprintSandboxActionBarSection,
      migrated31.BlueprintSandboxContentSummarySection,
      migrated32.BlueprintSandboxHeaderSection,
      migrated33.BlueprintSandboxPrimaryContentSection,
      migrated34.DynamicActionBarSection,
      migrated35.DynamicContentSummarySection,
      migrated36.DynamicHeaderSection,
      migrated37.DynamicPrimaryContentSection,
      migrated38.NoAccessActionBarSection,
      migrated39.NoAccessContentSummarySection,
      migrated40.NoAccessHeaderSection,
      migrated41.NoAccessPrimaryContentSection,
      migrated42.NoAccessScreenState,
      migrated43.AuditLogActionBarSection,
      migrated44.AuditLogDataTableSection,
      migrated45.AuditLogFilterBarSection,
      migrated46.AuditLogHeaderSection,
      migrated47.AuditLogPaginationSection,
      migrated48.AuditLogScreenState,
      migrated49.MonitoringActionBarSection,
      migrated50.MonitoringContentSummarySection,
      migrated51.MonitoringHeaderSection,
      migrated52.MonitoringPrimaryContentSection,
      migrated53.MonitoringScreenState,
      migrated54.ScreenStatusActionBarSection,
      migrated55.ScreenStatusContentSummarySection,
      migrated56.ScreenStatusHeaderSection,
      migrated57.ScreenStatusPrimaryContentSection,
      migrated58.ScreenStatusScreenState,
      migrated59.AuditLogActionBarSection,
      migrated60.AuditLogDataTableSection,
      migrated61.AuditLogFilterBarSection,
      migrated62.AuditLogHeaderSection,
      migrated63.AuditLogPaginationSection,
      migrated64.MonitoringActionBarSection,
      migrated65.MonitoringContentSummarySection,
      migrated66.MonitoringHeaderSection,
      migrated67.MonitoringPrimaryContentSection,
      migrated68.ScreenStatusActionBarSection,
      migrated69.ScreenStatusContentSummarySection,
      migrated70.ScreenStatusHeaderSection,
      migrated71.ScreenStatusPrimaryContentSection,
      migrated72.TicketCenterActionBarSection,
      migrated73.TicketCenterContentSummarySection,
      migrated74.TicketCenterHeaderSection,
      migrated75.TicketCenterPrimaryContentSection,
      migrated76.TicketCenterActionBarSection,
      migrated77.TicketCenterContentSummarySection,
      migrated78.TicketCenterHeaderSection,
      migrated79.TicketCenterPrimaryContentSection,
      migrated80.TicketCenterScreenState,
      migrated81.ControlCenterActionBarSection,
      migrated82.ControlCenterContentSummarySection,
      migrated83.ControlCenterHeaderSection,
      migrated84.ControlCenterPrimaryContentSection,
      migrated85.ControlCenterScreenState,
      migrated86.GovernanceHudActionBarSection,
      migrated87.GovernanceHudContentSummarySection,
      migrated88.GovernanceHudHeaderSection,
      migrated89.GovernanceHudPrimaryContentSection,
      migrated90.GovernanceHudScreenState,
      migrated91.GrowthPipelineActionBarSection,
      migrated92.GrowthPipelineContentSummarySection,
      migrated93.GrowthPipelineHeaderSection,
      migrated94.GrowthPipelinePrimaryContentSection,
      migrated95.GrowthPipelineScreenState,
      migrated96.LeadershipReportsChartAreaSection,
      migrated97.LeadershipReportsExportActionsSection,
      migrated98.LeadershipReportsFilterBarSection,
      migrated99.LeadershipReportsHeaderSection,
      migrated100.LeadershipReportsMetricsSummarySection,
      migrated101.LeadershipReportsScreenState,
      migrated102.ProposalsActionBarSection,
      migrated103.ProposalsContentSummarySection,
      migrated104.ProposalsHeaderSection,
      migrated105.ProposalsPrimaryContentSection,
      migrated106.ProposalsScreenState,
      migrated107.RegionalPerformanceActionBarSection,
      migrated108.RegionalPerformanceFormBodySection,
      migrated109.RegionalPerformanceHeaderSection,
      migrated110.RegionalPerformanceValidationMessagesSection,
      migrated111.RegionalPerformanceScreenState,
      migrated112.ControlCenterActionBarSection,
      migrated113.ControlCenterContentSummarySection,
      migrated114.ControlCenterHeaderSection,
      migrated115.ControlCenterPrimaryContentSection,
      migrated116.GovernanceHudActionBarSection,
      migrated117.GovernanceHudContentSummarySection,
      migrated118.GovernanceHudHeaderSection,
      migrated119.GovernanceHudPrimaryContentSection,
      migrated120.GrowthPipelineActionBarSection,
      migrated121.GrowthPipelineContentSummarySection,
      migrated122.GrowthPipelineHeaderSection,
      migrated123.GrowthPipelinePrimaryContentSection,
      migrated124.LeadershipReportsChartAreaSection,
      migrated125.LeadershipReportsExportActionsSection,
      migrated126.LeadershipReportsFilterBarSection,
      migrated127.LeadershipReportsHeaderSection,
      migrated128.LeadershipReportsMetricsSummarySection,
      migrated129.ProposalsActionBarSection,
      migrated130.ProposalsContentSummarySection,
      migrated131.ProposalsHeaderSection,
      migrated132.ProposalsPrimaryContentSection,
      migrated133.RegionalPerformanceActionBarSection,
      migrated134.RegionalPerformanceFormBodySection,
      migrated135.RegionalPerformanceHeaderSection,
      migrated136.RegionalPerformanceValidationMessagesSection,
      migrated137.UnknownDashboardScreen,
      migrated138.AuditDashboardChartOverviewSection,
      migrated139.AuditDashboardHeaderSection,
      migrated140.AuditDashboardQuickActionsSection,
      migrated141.AuditDashboardRecentActivitySection,
      migrated142.AuditDashboardSummaryCardsSection,
      migrated143.AuditDashboardScreenState,
      migrated144.ComplianceReviewsActionBarSection,
      migrated145.ComplianceReviewsDataTableSection,
      migrated146.ComplianceReviewsFilterBarSection,
      migrated147.ComplianceReviewsHeaderSection,
      migrated148.ComplianceReviewsPaginationSection,
      migrated149.ComplianceReviewsScreenState,
      migrated150.IncidentReportsChartAreaSection,
      migrated151.IncidentReportsExportActionsSection,
      migrated152.IncidentReportsFilterBarSection,
      migrated153.IncidentReportsHeaderSection,
      migrated154.IncidentReportsMetricsSummarySection,
      migrated155.IncidentReportsScreenState,
      migrated156.QualityMetricsChartAreaSection,
      migrated157.QualityMetricsExportActionsSection,
      migrated158.QualityMetricsFilterBarSection,
      migrated159.QualityMetricsHeaderSection,
      migrated160.QualityMetricsMetricsSummarySection,
      migrated161.QualityMetricsScreenState,
      migrated162.AuditDashboardChartOverviewSection,
      migrated163.AuditDashboardHeaderSection,
      migrated164.AuditDashboardQuickActionsSection,
      migrated165.AuditDashboardRecentActivitySection,
      migrated166.AuditDashboardSummaryCardsSection,
      migrated167.ComplianceReviewsActionBarSection,
      migrated168.ComplianceReviewsDataTableSection,
      migrated169.ComplianceReviewsFilterBarSection,
      migrated170.ComplianceReviewsHeaderSection,
      migrated171.ComplianceReviewsPaginationSection,
      migrated172.IncidentReportsChartAreaSection,
      migrated173.IncidentReportsExportActionsSection,
      migrated174.IncidentReportsFilterBarSection,
      migrated175.IncidentReportsHeaderSection,
      migrated176.IncidentReportsMetricsSummarySection,
      migrated177.QualityMetricsChartAreaSection,
      migrated178.QualityMetricsExportActionsSection,
      migrated179.QualityMetricsFilterBarSection,
      migrated180.QualityMetricsHeaderSection,
      migrated181.QualityMetricsMetricsSummarySection,
      migrated182.ClinicalReferenceActionBarSection,
      migrated183.ClinicalReferenceContentSummarySection,
      migrated184.ClinicalReferenceHeaderSection,
      migrated185.ClinicalReferencePrimaryContentSection,
      migrated186.ClinicalReferenceScreenState,
      migrated187.ClinicalReferenceActionBarSection,
      migrated188.ClinicalReferenceContentSummarySection,
      migrated189.ClinicalReferenceHeaderSection,
      migrated190.ClinicalReferencePrimaryContentSection,
      migrated191.SecurityHubActionBarSection,
      migrated192.SecurityHubContentSummarySection,
      migrated193.SecurityHubHeaderSection,
      migrated194.SecurityHubPrimaryContentSection,
      migrated195.SecuritySentinelActionBarSection,
      migrated196.SecuritySentinelContentSummarySection,
      migrated197.SecuritySentinelHeaderSection,
      migrated198.SecuritySentinelPrimaryContentSection,
      migrated199.VerificationCenterActionBarSection,
      migrated200.VerificationCenterContentSummarySection,
      migrated201.VerificationCenterHeaderSection,
      migrated202.VerificationCenterPrimaryContentSection,
      migrated203.SecurityHubActionBarSection,
      migrated204.SecurityHubContentSummarySection,
      migrated205.SecurityHubHeaderSection,
      migrated206.SecurityHubPrimaryContentSection,
      migrated207.SecurityHubScreenState,
      migrated208.SecuritySentinelActionBarSection,
      migrated209.SecuritySentinelContentSummarySection,
      migrated210.SecuritySentinelHeaderSection,
      migrated211.SecuritySentinelPrimaryContentSection,
      migrated212.SecuritySentinelScreenState,
      migrated213.VerificationCenterActionBarSection,
      migrated214.VerificationCenterContentSummarySection,
      migrated215.VerificationCenterHeaderSection,
      migrated216.VerificationCenterPrimaryContentSection,
      migrated217.VerificationCenterScreenState,
      migrated218.GovernanceEventFeed,
      migrated219.GovernanceKPIGrid,
      migrated220.GovernanceMasterScore,
      migrated221.GovernanceRoleViewer,
      migrated222.GovernanceTrendChart,
    ];
    expect(migratedTypes, hasLength(223));
  });
}
