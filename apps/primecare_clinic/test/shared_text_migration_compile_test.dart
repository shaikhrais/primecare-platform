// Compile smoke coverage for migrated shared controls.
// Compilation does not establish screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_clinic/features/generated_screens/chiropractor_dashboard_screen.dart' as migrated0;
import 'package:primecare_clinic/features/generated_screens/clinical_director_dashboard_screen.dart' as migrated1;
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics/sections/clinical_director_quality_metrics_chart_area_section.dart' as migrated2;
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics/sections/clinical_director_quality_metrics_export_actions_section.dart' as migrated3;
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics/sections/clinical_director_quality_metrics_filter_bar_section.dart' as migrated4;
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics/sections/clinical_director_quality_metrics_header_section.dart' as migrated5;
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics/sections/clinical_director_quality_metrics_metrics_summary_section.dart' as migrated6;
import 'package:primecare_clinic/features/generated_screens/clinical_director_quality_metrics_screen.dart' as migrated7;
import 'package:primecare_clinic/features/generated_screens/clinical_director_staffing/sections/clinical_director_staffing_action_bar_section.dart' as migrated8;
import 'package:primecare_clinic/features/generated_screens/clinical_director_staffing/sections/clinical_director_staffing_content_summary_section.dart' as migrated9;
import 'package:primecare_clinic/features/generated_screens/clinical_director_staffing/sections/clinical_director_staffing_header_section.dart' as migrated10;
import 'package:primecare_clinic/features/generated_screens/clinical_director_staffing/sections/clinical_director_staffing_primary_content_section.dart' as migrated11;
import 'package:primecare_clinic/features/generated_screens/clinical_director_staffing_screen.dart' as migrated12;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard/sections/infection_control_dashboard_chart_overview_section.dart' as migrated13;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard/sections/infection_control_dashboard_header_section.dart' as migrated14;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard/sections/infection_control_dashboard_quick_actions_section.dart' as migrated15;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard/sections/infection_control_dashboard_recent_activity_section.dart' as migrated16;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard/sections/infection_control_dashboard_summary_cards_section.dart' as migrated17;
import 'package:primecare_clinic/features/generated_screens/infection_control_dashboard_screen.dart' as migrated18;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_assessments/sections/intake_coordinator_assessments_action_bar_section.dart' as migrated19;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_assessments/sections/intake_coordinator_assessments_content_summary_section.dart' as migrated20;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_assessments/sections/intake_coordinator_assessments_header_section.dart' as migrated21;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_assessments/sections/intake_coordinator_assessments_primary_content_section.dart' as migrated22;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_assessments_screen.dart' as migrated23;
import 'package:primecare_clinic/features/generated_screens/intake_coordinator_dashboard_screen.dart' as migrated24;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard/sections/nurse_dashboard_chart_overview_section.dart' as migrated25;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard/sections/nurse_dashboard_header_section.dart' as migrated26;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard/sections/nurse_dashboard_quick_actions_section.dart' as migrated27;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard/sections/nurse_dashboard_recent_activity_section.dart' as migrated28;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard/sections/nurse_dashboard_summary_cards_section.dart' as migrated29;
import 'package:primecare_clinic/features/generated_screens/nurse_dashboard_screen.dart' as migrated30;
import 'package:primecare_clinic/features/generated_screens/physician_dashboard_screen.dart' as migrated31;
import 'package:primecare_clinic/features/generated_screens/physiotherapist_dashboard_screen.dart' as migrated32;
import 'package:primecare_clinic/features/generated_screens/psw_check_in_screen.dart' as migrated33;
import 'package:primecare_clinic/features/generated_screens/psw_dashboard_screen.dart' as migrated34;
import 'package:primecare_clinic/features/generated_screens/psw_documents_screen.dart' as migrated35;
import 'package:primecare_clinic/features/generated_screens/psw_help_support_screen.dart' as migrated36;
import 'package:primecare_clinic/features/generated_screens/psw_messages_screen.dart' as migrated37;
import 'package:primecare_clinic/features/generated_screens/psw_notifications_screen.dart' as migrated38;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log/sections/psw_observation_vitals_log_action_bar_section.dart' as migrated39;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log/sections/psw_observation_vitals_log_data_table_section.dart' as migrated40;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log/sections/psw_observation_vitals_log_filter_bar_section.dart' as migrated41;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log/sections/psw_observation_vitals_log_header_section.dart' as migrated42;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log/sections/psw_observation_vitals_log_pagination_section.dart' as migrated43;
import 'package:primecare_clinic/features/generated_screens/psw_observation_vitals_log_screen.dart' as migrated44;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile/sections/psw_patient_profile_action_bar_section.dart' as migrated45;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile/sections/psw_patient_profile_details_form_section.dart' as migrated46;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile/sections/psw_patient_profile_header_section.dart' as migrated47;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile/sections/psw_patient_profile_identity_summary_section.dart' as migrated48;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile/sections/psw_patient_profile_preferences_or_documents_section.dart' as migrated49;
import 'package:primecare_clinic/features/generated_screens/psw_patient_profile_screen.dart' as migrated50;
import 'package:primecare_clinic/features/generated_screens/psw_profile_screen.dart' as migrated51;
import 'package:primecare_clinic/features/generated_screens/psw_reports_screen.dart' as migrated52;
import 'package:primecare_clinic/features/generated_screens/psw_schedule/sections/psw_schedule_action_bar_section.dart' as migrated53;
import 'package:primecare_clinic/features/generated_screens/psw_schedule/sections/psw_schedule_appointment_details_section.dart' as migrated54;
import 'package:primecare_clinic/features/generated_screens/psw_schedule/sections/psw_schedule_calendar_controls_section.dart' as migrated55;
import 'package:primecare_clinic/features/generated_screens/psw_schedule/sections/psw_schedule_header_section.dart' as migrated56;
import 'package:primecare_clinic/features/generated_screens/psw_schedule/sections/psw_schedule_schedule_list_section.dart' as migrated57;
import 'package:primecare_clinic/features/generated_screens/psw_schedule_screen.dart' as migrated58;
import 'package:primecare_clinic/features/generated_screens/psw_system_logs_screen.dart' as migrated59;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist/sections/psw_visit_checklist_action_bar_section.dart' as migrated60;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist/sections/psw_visit_checklist_appointment_details_section.dart' as migrated61;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist/sections/psw_visit_checklist_calendar_controls_section.dart' as migrated62;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist/sections/psw_visit_checklist_header_section.dart' as migrated63;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist/sections/psw_visit_checklist_schedule_list_section.dart' as migrated64;
import 'package:primecare_clinic/features/generated_screens/psw_visit_checklist_screen.dart' as migrated65;
import 'package:primecare_clinic/features/generated_screens/psw_visit_notes_screen.dart' as migrated66;
import 'package:primecare_clinic/features/generated_screens/rmt_dashboard_screen.dart' as migrated67;
import 'package:primecare_clinic/features/generated_screens/rn_dashboard_screen.dart' as migrated68;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_quality_metrics_chart_area_section.dart' as migrated69;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_quality_metrics_export_actions_section.dart' as migrated70;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_quality_metrics_filter_bar_section.dart' as migrated71;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_quality_metrics_header_section.dart' as migrated72;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_quality_metrics_metrics_summary_section.dart' as migrated73;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_staffing_action_bar_section.dart' as migrated74;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_staffing_content_summary_section.dart' as migrated75;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_staffing_header_section.dart' as migrated76;
import 'package:primecare_clinic/features/generated_screens/sections/clinical_director_staffing_primary_content_section.dart' as migrated77;
import 'package:primecare_clinic/features/generated_screens/sections/infection_control_dashboard_chart_overview_section.dart' as migrated78;
import 'package:primecare_clinic/features/generated_screens/sections/infection_control_dashboard_header_section.dart' as migrated79;
import 'package:primecare_clinic/features/generated_screens/sections/infection_control_dashboard_quick_actions_section.dart' as migrated80;
import 'package:primecare_clinic/features/generated_screens/sections/infection_control_dashboard_recent_activity_section.dart' as migrated81;
import 'package:primecare_clinic/features/generated_screens/sections/infection_control_dashboard_summary_cards_section.dart' as migrated82;
import 'package:primecare_clinic/features/generated_screens/sections/intake_coordinator_assessments_action_bar_section.dart' as migrated83;
import 'package:primecare_clinic/features/generated_screens/sections/intake_coordinator_assessments_content_summary_section.dart' as migrated84;
import 'package:primecare_clinic/features/generated_screens/sections/intake_coordinator_assessments_header_section.dart' as migrated85;
import 'package:primecare_clinic/features/generated_screens/sections/intake_coordinator_assessments_primary_content_section.dart' as migrated86;
import 'package:primecare_clinic/features/generated_screens/sections/nurse_dashboard_chart_overview_section.dart' as migrated87;
import 'package:primecare_clinic/features/generated_screens/sections/nurse_dashboard_header_section.dart' as migrated88;
import 'package:primecare_clinic/features/generated_screens/sections/nurse_dashboard_quick_actions_section.dart' as migrated89;
import 'package:primecare_clinic/features/generated_screens/sections/nurse_dashboard_recent_activity_section.dart' as migrated90;
import 'package:primecare_clinic/features/generated_screens/sections/nurse_dashboard_summary_cards_section.dart' as migrated91;
import 'package:primecare_clinic/features/generated_screens/sections/psw_observation_vitals_log_action_bar_section.dart' as migrated92;
import 'package:primecare_clinic/features/generated_screens/sections/psw_observation_vitals_log_data_table_section.dart' as migrated93;
import 'package:primecare_clinic/features/generated_screens/sections/psw_observation_vitals_log_filter_bar_section.dart' as migrated94;
import 'package:primecare_clinic/features/generated_screens/sections/psw_observation_vitals_log_header_section.dart' as migrated95;
import 'package:primecare_clinic/features/generated_screens/sections/psw_observation_vitals_log_pagination_section.dart' as migrated96;
import 'package:primecare_clinic/features/generated_screens/sections/psw_patient_profile_action_bar_section.dart' as migrated97;
import 'package:primecare_clinic/features/generated_screens/sections/psw_patient_profile_details_form_section.dart' as migrated98;
import 'package:primecare_clinic/features/generated_screens/sections/psw_patient_profile_header_section.dart' as migrated99;
import 'package:primecare_clinic/features/generated_screens/sections/psw_patient_profile_identity_summary_section.dart' as migrated100;
import 'package:primecare_clinic/features/generated_screens/sections/psw_patient_profile_preferences_or_documents_section.dart' as migrated101;
import 'package:primecare_clinic/features/generated_screens/sections/psw_schedule_action_bar_section.dart' as migrated102;
import 'package:primecare_clinic/features/generated_screens/sections/psw_schedule_appointment_details_section.dart' as migrated103;
import 'package:primecare_clinic/features/generated_screens/sections/psw_schedule_calendar_controls_section.dart' as migrated104;
import 'package:primecare_clinic/features/generated_screens/sections/psw_schedule_header_section.dart' as migrated105;
import 'package:primecare_clinic/features/generated_screens/sections/psw_schedule_schedule_list_section.dart' as migrated106;
import 'package:primecare_clinic/features/generated_screens/sections/psw_visit_checklist_action_bar_section.dart' as migrated107;
import 'package:primecare_clinic/features/generated_screens/sections/psw_visit_checklist_appointment_details_section.dart' as migrated108;
import 'package:primecare_clinic/features/generated_screens/sections/psw_visit_checklist_calendar_controls_section.dart' as migrated109;
import 'package:primecare_clinic/features/generated_screens/sections/psw_visit_checklist_header_section.dart' as migrated110;
import 'package:primecare_clinic/features/generated_screens/sections/psw_visit_checklist_schedule_list_section.dart' as migrated111;
import 'package:primecare_clinic/features/generated_screens/social_worker_dashboard_screen.dart' as migrated112;
import 'package:primecare_clinic/features/generated_screens/therapist_dashboard_screen.dart' as migrated113;
import 'package:primecare_clinic/features/generated_screens/unknown_dashboard_screen.dart' as migrated114;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard/sections/psw_care_dashboard_chart_overview_section.dart' as migrated115;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard/sections/psw_care_dashboard_header_section.dart' as migrated116;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard/sections/psw_care_dashboard_quick_actions_section.dart' as migrated117;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard/sections/psw_care_dashboard_recent_activity_section.dart' as migrated118;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard/sections/psw_care_dashboard_summary_cards_section.dart' as migrated119;
import 'package:primecare_clinic/features/psw/screens/psw_care_dashboard_screen.dart' as migrated120;
import 'package:primecare_clinic/features/psw/screens/psw_check_in/sections/psw_check_in_action_bar_section.dart' as migrated121;
import 'package:primecare_clinic/features/psw/screens/psw_check_in/sections/psw_check_in_content_summary_section.dart' as migrated122;
import 'package:primecare_clinic/features/psw/screens/psw_check_in/sections/psw_check_in_header_section.dart' as migrated123;
import 'package:primecare_clinic/features/psw/screens/psw_check_in/sections/psw_check_in_primary_content_section.dart' as migrated124;
import 'package:primecare_clinic/features/psw/screens/psw_check_in_screen.dart' as migrated125;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes/sections/psw_daily_notes_action_bar_section.dart' as migrated126;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes/sections/psw_daily_notes_client_context_section.dart' as migrated127;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes/sections/psw_daily_notes_header_section.dart' as migrated128;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes/sections/psw_daily_notes_notes_form_section.dart' as migrated129;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes/sections/psw_daily_notes_notes_history_section.dart' as migrated130;
import 'package:primecare_clinic/features/psw/screens/psw_daily_notes_screen.dart' as migrated131;
import 'package:primecare_clinic/features/psw/screens/psw_help_support/sections/psw_help_support_action_bar_section.dart' as migrated132;
import 'package:primecare_clinic/features/psw/screens/psw_help_support/sections/psw_help_support_content_summary_section.dart' as migrated133;
import 'package:primecare_clinic/features/psw/screens/psw_help_support/sections/psw_help_support_header_section.dart' as migrated134;
import 'package:primecare_clinic/features/psw/screens/psw_help_support/sections/psw_help_support_primary_content_section.dart' as migrated135;
import 'package:primecare_clinic/features/psw/screens/psw_help_support_screen.dart' as migrated136;
import 'package:primecare_clinic/features/psw/screens/psw_messaging/sections/psw_messaging_action_bar_section.dart' as migrated137;
import 'package:primecare_clinic/features/psw/screens/psw_messaging/sections/psw_messaging_content_summary_section.dart' as migrated138;
import 'package:primecare_clinic/features/psw/screens/psw_messaging/sections/psw_messaging_header_section.dart' as migrated139;
import 'package:primecare_clinic/features/psw/screens/psw_messaging/sections/psw_messaging_primary_content_section.dart' as migrated140;
import 'package:primecare_clinic/features/psw/screens/psw_messaging_screen.dart' as migrated141;
import 'package:primecare_clinic/features/psw/screens/psw_my_clients/sections/psw_my_clients_action_bar_section.dart' as migrated142;
import 'package:primecare_clinic/features/psw/screens/psw_my_clients/sections/psw_my_clients_content_summary_section.dart' as migrated143;
import 'package:primecare_clinic/features/psw/screens/psw_my_clients/sections/psw_my_clients_header_section.dart' as migrated144;
import 'package:primecare_clinic/features/psw/screens/psw_my_clients/sections/psw_my_clients_primary_content_section.dart' as migrated145;
import 'package:primecare_clinic/features/psw/screens/psw_my_clients_screen.dart' as migrated146;
import 'package:primecare_clinic/features/psw/screens/psw_notifications/sections/psw_notifications_action_bar_section.dart' as migrated147;
import 'package:primecare_clinic/features/psw/screens/psw_notifications/sections/psw_notifications_content_summary_section.dart' as migrated148;
import 'package:primecare_clinic/features/psw/screens/psw_notifications/sections/psw_notifications_header_section.dart' as migrated149;
import 'package:primecare_clinic/features/psw/screens/psw_notifications/sections/psw_notifications_primary_content_section.dart' as migrated150;
import 'package:primecare_clinic/features/psw/screens/psw_notifications_screen.dart' as migrated151;
import 'package:primecare_clinic/features/psw/screens/psw_profile/sections/psw_profile_action_bar_section.dart' as migrated152;
import 'package:primecare_clinic/features/psw/screens/psw_profile/sections/psw_profile_details_form_section.dart' as migrated153;
import 'package:primecare_clinic/features/psw/screens/psw_profile/sections/psw_profile_header_section.dart' as migrated154;
import 'package:primecare_clinic/features/psw/screens/psw_profile/sections/psw_profile_identity_summary_section.dart' as migrated155;
import 'package:primecare_clinic/features/psw/screens/psw_profile/sections/psw_profile_preferences_or_documents_section.dart' as migrated156;
import 'package:primecare_clinic/features/psw/screens/psw_profile_screen.dart' as migrated157;
import 'package:primecare_clinic/features/psw/screens/psw_reports/sections/psw_reports_chart_area_section.dart' as migrated158;
import 'package:primecare_clinic/features/psw/screens/psw_reports/sections/psw_reports_export_actions_section.dart' as migrated159;
import 'package:primecare_clinic/features/psw/screens/psw_reports/sections/psw_reports_filter_bar_section.dart' as migrated160;
import 'package:primecare_clinic/features/psw/screens/psw_reports/sections/psw_reports_header_section.dart' as migrated161;
import 'package:primecare_clinic/features/psw/screens/psw_reports/sections/psw_reports_metrics_summary_section.dart' as migrated162;
import 'package:primecare_clinic/features/psw/screens/psw_reports_screen.dart' as migrated163;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs/sections/psw_system_logs_action_bar_section.dart' as migrated164;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs/sections/psw_system_logs_data_table_section.dart' as migrated165;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs/sections/psw_system_logs_filter_bar_section.dart' as migrated166;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs/sections/psw_system_logs_header_section.dart' as migrated167;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs/sections/psw_system_logs_pagination_section.dart' as migrated168;
import 'package:primecare_clinic/features/psw/screens/psw_system_logs_screen.dart' as migrated169;
import 'package:primecare_clinic/features/psw/screens/psw_task_list/sections/psw_task_list_action_bar_section.dart' as migrated170;
import 'package:primecare_clinic/features/psw/screens/psw_task_list/sections/psw_task_list_header_section.dart' as migrated171;
import 'package:primecare_clinic/features/psw/screens/psw_task_list/sections/psw_task_list_task_details_section.dart' as migrated172;
import 'package:primecare_clinic/features/psw/screens/psw_task_list/sections/psw_task_list_task_filters_section.dart' as migrated173;
import 'package:primecare_clinic/features/psw/screens/psw_task_list/sections/psw_task_list_task_list_section.dart' as migrated174;
import 'package:primecare_clinic/features/psw/screens/psw_task_list_screen.dart' as migrated175;
import 'package:primecare_clinic/features/psw/screens/sections/psw_care_dashboard_chart_overview_section.dart' as migrated176;
import 'package:primecare_clinic/features/psw/screens/sections/psw_care_dashboard_header_section.dart' as migrated177;
import 'package:primecare_clinic/features/psw/screens/sections/psw_care_dashboard_quick_actions_section.dart' as migrated178;
import 'package:primecare_clinic/features/psw/screens/sections/psw_care_dashboard_recent_activity_section.dart' as migrated179;
import 'package:primecare_clinic/features/psw/screens/sections/psw_care_dashboard_summary_cards_section.dart' as migrated180;
import 'package:primecare_clinic/features/psw/screens/sections/psw_check_in_action_bar_section.dart' as migrated181;
import 'package:primecare_clinic/features/psw/screens/sections/psw_check_in_content_summary_section.dart' as migrated182;
import 'package:primecare_clinic/features/psw/screens/sections/psw_check_in_header_section.dart' as migrated183;
import 'package:primecare_clinic/features/psw/screens/sections/psw_check_in_primary_content_section.dart' as migrated184;
import 'package:primecare_clinic/features/psw/screens/sections/psw_daily_notes_action_bar_section.dart' as migrated185;
import 'package:primecare_clinic/features/psw/screens/sections/psw_daily_notes_client_context_section.dart' as migrated186;
import 'package:primecare_clinic/features/psw/screens/sections/psw_daily_notes_header_section.dart' as migrated187;
import 'package:primecare_clinic/features/psw/screens/sections/psw_daily_notes_notes_form_section.dart' as migrated188;
import 'package:primecare_clinic/features/psw/screens/sections/psw_daily_notes_notes_history_section.dart' as migrated189;
import 'package:primecare_clinic/features/psw/screens/sections/psw_help_support_action_bar_section.dart' as migrated190;
import 'package:primecare_clinic/features/psw/screens/sections/psw_help_support_content_summary_section.dart' as migrated191;
import 'package:primecare_clinic/features/psw/screens/sections/psw_help_support_header_section.dart' as migrated192;
import 'package:primecare_clinic/features/psw/screens/sections/psw_help_support_primary_content_section.dart' as migrated193;
import 'package:primecare_clinic/features/psw/screens/sections/psw_messaging_action_bar_section.dart' as migrated194;
import 'package:primecare_clinic/features/psw/screens/sections/psw_messaging_content_summary_section.dart' as migrated195;
import 'package:primecare_clinic/features/psw/screens/sections/psw_messaging_header_section.dart' as migrated196;
import 'package:primecare_clinic/features/psw/screens/sections/psw_messaging_primary_content_section.dart' as migrated197;
import 'package:primecare_clinic/features/psw/screens/sections/psw_my_clients_action_bar_section.dart' as migrated198;
import 'package:primecare_clinic/features/psw/screens/sections/psw_my_clients_content_summary_section.dart' as migrated199;
import 'package:primecare_clinic/features/psw/screens/sections/psw_my_clients_header_section.dart' as migrated200;
import 'package:primecare_clinic/features/psw/screens/sections/psw_my_clients_primary_content_section.dart' as migrated201;
import 'package:primecare_clinic/features/psw/screens/sections/psw_notifications_action_bar_section.dart' as migrated202;
import 'package:primecare_clinic/features/psw/screens/sections/psw_notifications_content_summary_section.dart' as migrated203;
import 'package:primecare_clinic/features/psw/screens/sections/psw_notifications_header_section.dart' as migrated204;
import 'package:primecare_clinic/features/psw/screens/sections/psw_notifications_primary_content_section.dart' as migrated205;
import 'package:primecare_clinic/features/psw/screens/sections/psw_profile_action_bar_section.dart' as migrated206;
import 'package:primecare_clinic/features/psw/screens/sections/psw_profile_details_form_section.dart' as migrated207;
import 'package:primecare_clinic/features/psw/screens/sections/psw_profile_header_section.dart' as migrated208;
import 'package:primecare_clinic/features/psw/screens/sections/psw_profile_identity_summary_section.dart' as migrated209;
import 'package:primecare_clinic/features/psw/screens/sections/psw_profile_preferences_or_documents_section.dart' as migrated210;
import 'package:primecare_clinic/features/psw/screens/sections/psw_reports_chart_area_section.dart' as migrated211;
import 'package:primecare_clinic/features/psw/screens/sections/psw_reports_export_actions_section.dart' as migrated212;
import 'package:primecare_clinic/features/psw/screens/sections/psw_reports_filter_bar_section.dart' as migrated213;
import 'package:primecare_clinic/features/psw/screens/sections/psw_reports_header_section.dart' as migrated214;
import 'package:primecare_clinic/features/psw/screens/sections/psw_reports_metrics_summary_section.dart' as migrated215;
import 'package:primecare_clinic/features/psw/screens/sections/psw_system_logs_action_bar_section.dart' as migrated216;
import 'package:primecare_clinic/features/psw/screens/sections/psw_system_logs_data_table_section.dart' as migrated217;
import 'package:primecare_clinic/features/psw/screens/sections/psw_system_logs_filter_bar_section.dart' as migrated218;
import 'package:primecare_clinic/features/psw/screens/sections/psw_system_logs_header_section.dart' as migrated219;
import 'package:primecare_clinic/features/psw/screens/sections/psw_system_logs_pagination_section.dart' as migrated220;
import 'package:primecare_clinic/features/psw/screens/sections/psw_task_list_action_bar_section.dart' as migrated221;
import 'package:primecare_clinic/features/psw/screens/sections/psw_task_list_header_section.dart' as migrated222;
import 'package:primecare_clinic/features/psw/screens/sections/psw_task_list_task_details_section.dart' as migrated223;
import 'package:primecare_clinic/features/psw/screens/sections/psw_task_list_task_filters_section.dart' as migrated224;
import 'package:primecare_clinic/features/psw/screens/sections/psw_task_list_task_list_section.dart' as migrated225;
import 'package:primecare_clinic/features/rn/screens/rn_charting/sections/rn_charting_action_bar_section.dart' as migrated226;
import 'package:primecare_clinic/features/rn/screens/rn_charting/sections/rn_charting_content_summary_section.dart' as migrated227;
import 'package:primecare_clinic/features/rn/screens/rn_charting/sections/rn_charting_header_section.dart' as migrated228;
import 'package:primecare_clinic/features/rn/screens/rn_charting/sections/rn_charting_primary_content_section.dart' as migrated229;
import 'package:primecare_clinic/features/rn/screens/rn_charting_screen.dart' as migrated230;
import 'package:primecare_clinic/features/rn/screens/rn_messaging/sections/rn_messaging_action_bar_section.dart' as migrated231;
import 'package:primecare_clinic/features/rn/screens/rn_messaging/sections/rn_messaging_content_summary_section.dart' as migrated232;
import 'package:primecare_clinic/features/rn/screens/rn_messaging/sections/rn_messaging_header_section.dart' as migrated233;
import 'package:primecare_clinic/features/rn/screens/rn_messaging/sections/rn_messaging_primary_content_section.dart' as migrated234;
import 'package:primecare_clinic/features/rn/screens/rn_messaging_screen.dart' as migrated235;
import 'package:primecare_clinic/features/rn/screens/sections/rn_charting_action_bar_section.dart' as migrated236;
import 'package:primecare_clinic/features/rn/screens/sections/rn_charting_content_summary_section.dart' as migrated237;
import 'package:primecare_clinic/features/rn/screens/sections/rn_charting_header_section.dart' as migrated238;
import 'package:primecare_clinic/features/rn/screens/sections/rn_charting_primary_content_section.dart' as migrated239;
import 'package:primecare_clinic/features/rn/screens/sections/rn_messaging_action_bar_section.dart' as migrated240;
import 'package:primecare_clinic/features/rn/screens/sections/rn_messaging_content_summary_section.dart' as migrated241;
import 'package:primecare_clinic/features/rn/screens/sections/rn_messaging_header_section.dart' as migrated242;
import 'package:primecare_clinic/features/rn/screens/sections/rn_messaging_primary_content_section.dart' as migrated243;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs/sections/clinic_history_logs_action_bar_section.dart' as migrated244;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs/sections/clinic_history_logs_data_table_section.dart' as migrated245;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs/sections/clinic_history_logs_filter_bar_section.dart' as migrated246;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs/sections/clinic_history_logs_header_section.dart' as migrated247;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs/sections/clinic_history_logs_pagination_section.dart' as migrated248;
import 'package:primecare_clinic/features/shared/screens/clinic_history_logs_screen.dart' as migrated249;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report/sections/clinic_incident_report_chart_area_section.dart' as migrated250;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report/sections/clinic_incident_report_export_actions_section.dart' as migrated251;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report/sections/clinic_incident_report_filter_bar_section.dart' as migrated252;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report/sections/clinic_incident_report_header_section.dart' as migrated253;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report/sections/clinic_incident_report_metrics_summary_section.dart' as migrated254;
import 'package:primecare_clinic/features/shared/screens/clinic_incident_report_screen.dart' as migrated255;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_history_logs_action_bar_section.dart' as migrated256;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_history_logs_data_table_section.dart' as migrated257;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_history_logs_filter_bar_section.dart' as migrated258;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_history_logs_header_section.dart' as migrated259;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_history_logs_pagination_section.dart' as migrated260;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_incident_report_chart_area_section.dart' as migrated261;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_incident_report_export_actions_section.dart' as migrated262;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_incident_report_filter_bar_section.dart' as migrated263;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_incident_report_header_section.dart' as migrated264;
import 'package:primecare_clinic/features/shared/screens/sections/clinic_incident_report_metrics_summary_section.dart' as migrated265;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
      migrated0.ChiropractorDashboardScreen,
      migrated1.ClinicalDirectorDashboardScreen,
      migrated2.ClinicalDirectorQualityMetricsChartAreaSection,
      migrated3.ClinicalDirectorQualityMetricsExportActionsSection,
      migrated4.ClinicalDirectorQualityMetricsFilterBarSection,
      migrated5.ClinicalDirectorQualityMetricsHeaderSection,
      migrated6.ClinicalDirectorQualityMetricsMetricsSummarySection,
      migrated7.ClinicalDirectorQualityMetricsScreenState,
      migrated8.ClinicalDirectorStaffingActionBarSection,
      migrated9.ClinicalDirectorStaffingContentSummarySection,
      migrated10.ClinicalDirectorStaffingHeaderSection,
      migrated11.ClinicalDirectorStaffingPrimaryContentSection,
      migrated12.ClinicalDirectorStaffingScreenState,
      migrated13.InfectionControlDashboardChartOverviewSection,
      migrated14.InfectionControlDashboardHeaderSection,
      migrated15.InfectionControlDashboardQuickActionsSection,
      migrated16.InfectionControlDashboardRecentActivitySection,
      migrated17.InfectionControlDashboardSummaryCardsSection,
      migrated18.InfectionControlDashboardScreenState,
      migrated19.IntakeCoordinatorAssessmentsActionBarSection,
      migrated20.IntakeCoordinatorAssessmentsContentSummarySection,
      migrated21.IntakeCoordinatorAssessmentsHeaderSection,
      migrated22.IntakeCoordinatorAssessmentsPrimaryContentSection,
      migrated23.IntakeCoordinatorAssessmentsScreenState,
      migrated24.IntakeCoordinatorDashboardScreen,
      migrated25.NurseDashboardChartOverviewSection,
      migrated26.NurseDashboardHeaderSection,
      migrated27.NurseDashboardQuickActionsSection,
      migrated28.NurseDashboardRecentActivitySection,
      migrated29.NurseDashboardSummaryCardsSection,
      migrated30.NurseDashboardScreenState,
      migrated31.PhysicianDashboardScreen,
      migrated32.PhysiotherapistDashboardScreen,
      migrated33.PswCheckInScreen,
      migrated34.PswDashboardScreen,
      migrated35.PswDocumentsScreen,
      migrated36.PswHelpSupportScreen,
      migrated37.PswMessagesScreen,
      migrated38.PswNotificationsScreen,
      migrated39.PswObservationVitalsLogActionBarSection,
      migrated40.PswObservationVitalsLogDataTableSection,
      migrated41.PswObservationVitalsLogFilterBarSection,
      migrated42.PswObservationVitalsLogHeaderSection,
      migrated43.PswObservationVitalsLogPaginationSection,
      migrated44.PswObservationVitalsLogScreenState,
      migrated45.PswPatientProfileActionBarSection,
      migrated46.PswPatientProfileDetailsFormSection,
      migrated47.PswPatientProfileHeaderSection,
      migrated48.PswPatientProfileIdentitySummarySection,
      migrated49.PswPatientProfilePreferencesOrDocumentsSection,
      migrated50.PswPatientProfileScreenState,
      migrated51.PswProfileScreen,
      migrated52.PswReportsScreen,
      migrated53.PswScheduleActionBarSection,
      migrated54.PswScheduleAppointmentDetailsSection,
      migrated55.PswScheduleCalendarControlsSection,
      migrated56.PswScheduleHeaderSection,
      migrated57.PswScheduleScheduleListSection,
      migrated58.PswScheduleScreenState,
      migrated59.PswSystemLogsScreen,
      migrated60.PswVisitChecklistActionBarSection,
      migrated61.PswVisitChecklistAppointmentDetailsSection,
      migrated62.PswVisitChecklistCalendarControlsSection,
      migrated63.PswVisitChecklistHeaderSection,
      migrated64.PswVisitChecklistScheduleListSection,
      migrated65.PswVisitChecklistScreenState,
      migrated66.PswVisitNotesScreen,
      migrated67.RmtDashboardScreen,
      migrated68.RnDashboardScreen,
      migrated69.ClinicalDirectorQualityMetricsChartAreaSection,
      migrated70.ClinicalDirectorQualityMetricsExportActionsSection,
      migrated71.ClinicalDirectorQualityMetricsFilterBarSection,
      migrated72.ClinicalDirectorQualityMetricsHeaderSection,
      migrated73.ClinicalDirectorQualityMetricsMetricsSummarySection,
      migrated74.ClinicalDirectorStaffingActionBarSection,
      migrated75.ClinicalDirectorStaffingContentSummarySection,
      migrated76.ClinicalDirectorStaffingHeaderSection,
      migrated77.ClinicalDirectorStaffingPrimaryContentSection,
      migrated78.InfectionControlDashboardChartOverviewSection,
      migrated79.InfectionControlDashboardHeaderSection,
      migrated80.InfectionControlDashboardQuickActionsSection,
      migrated81.InfectionControlDashboardRecentActivitySection,
      migrated82.InfectionControlDashboardSummaryCardsSection,
      migrated83.IntakeCoordinatorAssessmentsActionBarSection,
      migrated84.IntakeCoordinatorAssessmentsContentSummarySection,
      migrated85.IntakeCoordinatorAssessmentsHeaderSection,
      migrated86.IntakeCoordinatorAssessmentsPrimaryContentSection,
      migrated87.NurseDashboardChartOverviewSection,
      migrated88.NurseDashboardHeaderSection,
      migrated89.NurseDashboardQuickActionsSection,
      migrated90.NurseDashboardRecentActivitySection,
      migrated91.NurseDashboardSummaryCardsSection,
      migrated92.PswObservationVitalsLogActionBarSection,
      migrated93.PswObservationVitalsLogDataTableSection,
      migrated94.PswObservationVitalsLogFilterBarSection,
      migrated95.PswObservationVitalsLogHeaderSection,
      migrated96.PswObservationVitalsLogPaginationSection,
      migrated97.PswPatientProfileActionBarSection,
      migrated98.PswPatientProfileDetailsFormSection,
      migrated99.PswPatientProfileHeaderSection,
      migrated100.PswPatientProfileIdentitySummarySection,
      migrated101.PswPatientProfilePreferencesOrDocumentsSection,
      migrated102.PswScheduleActionBarSection,
      migrated103.PswScheduleAppointmentDetailsSection,
      migrated104.PswScheduleCalendarControlsSection,
      migrated105.PswScheduleHeaderSection,
      migrated106.PswScheduleScheduleListSection,
      migrated107.PswVisitChecklistActionBarSection,
      migrated108.PswVisitChecklistAppointmentDetailsSection,
      migrated109.PswVisitChecklistCalendarControlsSection,
      migrated110.PswVisitChecklistHeaderSection,
      migrated111.PswVisitChecklistScheduleListSection,
      migrated112.SocialWorkerDashboardScreen,
      migrated113.TherapistDashboardScreen,
      migrated114.UnknownDashboardScreen,
      migrated115.PswCareDashboardChartOverviewSection,
      migrated116.PswCareDashboardHeaderSection,
      migrated117.PswCareDashboardQuickActionsSection,
      migrated118.PswCareDashboardRecentActivitySection,
      migrated119.PswCareDashboardSummaryCardsSection,
      migrated120.PswCareDashboardScreenState,
      migrated121.PswCheckInActionBarSection,
      migrated122.PswCheckInContentSummarySection,
      migrated123.PswCheckInHeaderSection,
      migrated124.PswCheckInPrimaryContentSection,
      migrated125.PswCheckInScreenState,
      migrated126.PswDailyNotesActionBarSection,
      migrated127.PswDailyNotesClientContextSection,
      migrated128.PswDailyNotesHeaderSection,
      migrated129.PswDailyNotesNotesFormSection,
      migrated130.PswDailyNotesNotesHistorySection,
      migrated131.PswDailyNotesScreenState,
      migrated132.PswHelpSupportActionBarSection,
      migrated133.PswHelpSupportContentSummarySection,
      migrated134.PswHelpSupportHeaderSection,
      migrated135.PswHelpSupportPrimaryContentSection,
      migrated136.PswHelpSupportScreenState,
      migrated137.PswMessagingActionBarSection,
      migrated138.PswMessagingContentSummarySection,
      migrated139.PswMessagingHeaderSection,
      migrated140.PswMessagingPrimaryContentSection,
      migrated141.PswMessagingScreenState,
      migrated142.PswMyClientsActionBarSection,
      migrated143.PswMyClientsContentSummarySection,
      migrated144.PswMyClientsHeaderSection,
      migrated145.PswMyClientsPrimaryContentSection,
      migrated146.PswMyClientsScreenState,
      migrated147.PswNotificationsActionBarSection,
      migrated148.PswNotificationsContentSummarySection,
      migrated149.PswNotificationsHeaderSection,
      migrated150.PswNotificationsPrimaryContentSection,
      migrated151.PswNotificationsScreenState,
      migrated152.PswProfileActionBarSection,
      migrated153.PswProfileDetailsFormSection,
      migrated154.PswProfileHeaderSection,
      migrated155.PswProfileIdentitySummarySection,
      migrated156.PswProfilePreferencesOrDocumentsSection,
      migrated157.PswProfileScreenState,
      migrated158.PswReportsChartAreaSection,
      migrated159.PswReportsExportActionsSection,
      migrated160.PswReportsFilterBarSection,
      migrated161.PswReportsHeaderSection,
      migrated162.PswReportsMetricsSummarySection,
      migrated163.PswReportsScreenState,
      migrated164.PswSystemLogsActionBarSection,
      migrated165.PswSystemLogsDataTableSection,
      migrated166.PswSystemLogsFilterBarSection,
      migrated167.PswSystemLogsHeaderSection,
      migrated168.PswSystemLogsPaginationSection,
      migrated169.PswSystemLogsScreenState,
      migrated170.PswTaskListActionBarSection,
      migrated171.PswTaskListHeaderSection,
      migrated172.PswTaskListTaskDetailsSection,
      migrated173.PswTaskListTaskFiltersSection,
      migrated174.PswTaskListTaskListSection,
      migrated175.PswTaskListScreenState,
      migrated176.PswCareDashboardChartOverviewSection,
      migrated177.PswCareDashboardHeaderSection,
      migrated178.PswCareDashboardQuickActionsSection,
      migrated179.PswCareDashboardRecentActivitySection,
      migrated180.PswCareDashboardSummaryCardsSection,
      migrated181.PswCheckInActionBarSection,
      migrated182.PswCheckInContentSummarySection,
      migrated183.PswCheckInHeaderSection,
      migrated184.PswCheckInPrimaryContentSection,
      migrated185.PswDailyNotesActionBarSection,
      migrated186.PswDailyNotesClientContextSection,
      migrated187.PswDailyNotesHeaderSection,
      migrated188.PswDailyNotesNotesFormSection,
      migrated189.PswDailyNotesNotesHistorySection,
      migrated190.PswHelpSupportActionBarSection,
      migrated191.PswHelpSupportContentSummarySection,
      migrated192.PswHelpSupportHeaderSection,
      migrated193.PswHelpSupportPrimaryContentSection,
      migrated194.PswMessagingActionBarSection,
      migrated195.PswMessagingContentSummarySection,
      migrated196.PswMessagingHeaderSection,
      migrated197.PswMessagingPrimaryContentSection,
      migrated198.PswMyClientsActionBarSection,
      migrated199.PswMyClientsContentSummarySection,
      migrated200.PswMyClientsHeaderSection,
      migrated201.PswMyClientsPrimaryContentSection,
      migrated202.PswNotificationsActionBarSection,
      migrated203.PswNotificationsContentSummarySection,
      migrated204.PswNotificationsHeaderSection,
      migrated205.PswNotificationsPrimaryContentSection,
      migrated206.PswProfileActionBarSection,
      migrated207.PswProfileDetailsFormSection,
      migrated208.PswProfileHeaderSection,
      migrated209.PswProfileIdentitySummarySection,
      migrated210.PswProfilePreferencesOrDocumentsSection,
      migrated211.PswReportsChartAreaSection,
      migrated212.PswReportsExportActionsSection,
      migrated213.PswReportsFilterBarSection,
      migrated214.PswReportsHeaderSection,
      migrated215.PswReportsMetricsSummarySection,
      migrated216.PswSystemLogsActionBarSection,
      migrated217.PswSystemLogsDataTableSection,
      migrated218.PswSystemLogsFilterBarSection,
      migrated219.PswSystemLogsHeaderSection,
      migrated220.PswSystemLogsPaginationSection,
      migrated221.PswTaskListActionBarSection,
      migrated222.PswTaskListHeaderSection,
      migrated223.PswTaskListTaskDetailsSection,
      migrated224.PswTaskListTaskFiltersSection,
      migrated225.PswTaskListTaskListSection,
      migrated226.RnChartingActionBarSection,
      migrated227.RnChartingContentSummarySection,
      migrated228.RnChartingHeaderSection,
      migrated229.RnChartingPrimaryContentSection,
      migrated230.RnChartingScreenState,
      migrated231.RnMessagingActionBarSection,
      migrated232.RnMessagingContentSummarySection,
      migrated233.RnMessagingHeaderSection,
      migrated234.RnMessagingPrimaryContentSection,
      migrated235.RnMessagingScreenState,
      migrated236.RnChartingActionBarSection,
      migrated237.RnChartingContentSummarySection,
      migrated238.RnChartingHeaderSection,
      migrated239.RnChartingPrimaryContentSection,
      migrated240.RnMessagingActionBarSection,
      migrated241.RnMessagingContentSummarySection,
      migrated242.RnMessagingHeaderSection,
      migrated243.RnMessagingPrimaryContentSection,
      migrated244.ClinicHistoryLogsActionBarSection,
      migrated245.ClinicHistoryLogsDataTableSection,
      migrated246.ClinicHistoryLogsFilterBarSection,
      migrated247.ClinicHistoryLogsHeaderSection,
      migrated248.ClinicHistoryLogsPaginationSection,
      migrated249.ClinicHistoryLogsScreenState,
      migrated250.ClinicIncidentReportChartAreaSection,
      migrated251.ClinicIncidentReportExportActionsSection,
      migrated252.ClinicIncidentReportFilterBarSection,
      migrated253.ClinicIncidentReportHeaderSection,
      migrated254.ClinicIncidentReportMetricsSummarySection,
      migrated255.ClinicIncidentReportScreenState,
      migrated256.ClinicHistoryLogsActionBarSection,
      migrated257.ClinicHistoryLogsDataTableSection,
      migrated258.ClinicHistoryLogsFilterBarSection,
      migrated259.ClinicHistoryLogsHeaderSection,
      migrated260.ClinicHistoryLogsPaginationSection,
      migrated261.ClinicIncidentReportChartAreaSection,
      migrated262.ClinicIncidentReportExportActionsSection,
      migrated263.ClinicIncidentReportFilterBarSection,
      migrated264.ClinicIncidentReportHeaderSection,
      migrated265.ClinicIncidentReportMetricsSummarySection,
    ];
    expect(migratedTypes, hasLength(266));
  });
}
