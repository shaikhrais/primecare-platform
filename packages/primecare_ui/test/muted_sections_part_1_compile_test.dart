// Compilation does not establish screen/runtime readiness.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_action_bar_section.dart' as section0;
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_content_summary_section.dart' as section1;
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_header_section.dart' as section2;
import 'package:primecare_ui/src/screens/admin/admin_screen_health/sections/admin_screen_health_primary_content_section.dart' as section3;
import 'package:primecare_ui/src/screens/allied/adjustment_notes/sections/adjustment_notes_action_bar_section.dart' as section4;
import 'package:primecare_ui/src/screens/allied/adjustment_notes/sections/adjustment_notes_client_context_section.dart' as section5;
import 'package:primecare_ui/src/screens/allied/adjustment_notes/sections/adjustment_notes_header_section.dart' as section6;
import 'package:primecare_ui/src/screens/allied/adjustment_notes/sections/adjustment_notes_notes_form_section.dart' as section7;
import 'package:primecare_ui/src/screens/allied/adjustment_notes/sections/adjustment_notes_notes_history_section.dart' as section8;
import 'package:primecare_ui/src/screens/allied/chiropractic_assessment/sections/chiropractic_assessment_action_bar_section.dart' as section9;
import 'package:primecare_ui/src/screens/allied/chiropractic_assessment/sections/chiropractic_assessment_content_summary_section.dart' as section10;
import 'package:primecare_ui/src/screens/allied/chiropractic_assessment/sections/chiropractic_assessment_header_section.dart' as section11;
import 'package:primecare_ui/src/screens/allied/chiropractic_assessment/sections/chiropractic_assessment_primary_content_section.dart' as section12;
import 'package:primecare_ui/src/screens/allied/chiropractic_progress_tracking/sections/chiropractic_progress_tracking_action_bar_section.dart' as section13;
import 'package:primecare_ui/src/screens/allied/chiropractic_progress_tracking/sections/chiropractic_progress_tracking_content_summary_section.dart' as section14;
import 'package:primecare_ui/src/screens/allied/chiropractic_progress_tracking/sections/chiropractic_progress_tracking_header_section.dart' as section15;
import 'package:primecare_ui/src/screens/allied/chiropractic_progress_tracking/sections/chiropractic_progress_tracking_primary_content_section.dart' as section16;
import 'package:primecare_ui/src/screens/allied/chiropractor_appointments/sections/chiropractor_appointments_action_bar_section.dart' as section17;
import 'package:primecare_ui/src/screens/allied/chiropractor_appointments/sections/chiropractor_appointments_appointment_details_section.dart' as section18;
import 'package:primecare_ui/src/screens/allied/chiropractor_appointments/sections/chiropractor_appointments_calendar_controls_section.dart' as section19;
import 'package:primecare_ui/src/screens/allied/chiropractor_appointments/sections/chiropractor_appointments_header_section.dart' as section20;
import 'package:primecare_ui/src/screens/allied/chiropractor_appointments/sections/chiropractor_appointments_schedule_list_section.dart' as section21;
import 'package:primecare_ui/src/screens/allied/chiropractor_assessment/sections/chiropractor_assessment_action_bar_section.dart' as section22;
import 'package:primecare_ui/src/screens/allied/chiropractor_assessment/sections/chiropractor_assessment_content_summary_section.dart' as section23;
import 'package:primecare_ui/src/screens/allied/chiropractor_assessment/sections/chiropractor_assessment_header_section.dart' as section24;
import 'package:primecare_ui/src/screens/allied/chiropractor_assessment/sections/chiropractor_assessment_primary_content_section.dart' as section25;
import 'package:primecare_ui/src/screens/allied/chiropractor_billing_link/sections/chiropractor_billing_link_action_bar_section.dart' as section26;
import 'package:primecare_ui/src/screens/allied/chiropractor_billing_link/sections/chiropractor_billing_link_content_summary_section.dart' as section27;
import 'package:primecare_ui/src/screens/allied/chiropractor_billing_link/sections/chiropractor_billing_link_header_section.dart' as section28;
import 'package:primecare_ui/src/screens/allied/chiropractor_billing_link/sections/chiropractor_billing_link_primary_content_section.dart' as section29;
import 'package:primecare_ui/src/screens/allied/chiropractor_client_intake/sections/chiropractor_client_intake_action_bar_section.dart' as section30;
import 'package:primecare_ui/src/screens/allied/chiropractor_client_intake/sections/chiropractor_client_intake_content_summary_section.dart' as section31;
import 'package:primecare_ui/src/screens/allied/chiropractor_client_intake/sections/chiropractor_client_intake_header_section.dart' as section32;
import 'package:primecare_ui/src/screens/allied/chiropractor_client_intake/sections/chiropractor_client_intake_primary_content_section.dart' as section33;
import 'package:primecare_ui/src/screens/allied/chiropractor_command_center/sections/chiropractor_command_center_action_bar_section.dart' as section34;
import 'package:primecare_ui/src/screens/allied/chiropractor_command_center/sections/chiropractor_command_center_content_summary_section.dart' as section35;
import 'package:primecare_ui/src/screens/allied/chiropractor_command_center/sections/chiropractor_command_center_header_section.dart' as section36;
import 'package:primecare_ui/src/screens/allied/chiropractor_command_center/sections/chiropractor_command_center_primary_content_section.dart' as section37;
import 'package:primecare_ui/src/screens/allied/chiropractor_exercise_plan/sections/chiropractor_exercise_plan_action_bar_section.dart' as section38;
import 'package:primecare_ui/src/screens/allied/chiropractor_exercise_plan/sections/chiropractor_exercise_plan_content_summary_section.dart' as section39;
import 'package:primecare_ui/src/screens/allied/chiropractor_exercise_plan/sections/chiropractor_exercise_plan_header_section.dart' as section40;
import 'package:primecare_ui/src/screens/allied/chiropractor_exercise_plan/sections/chiropractor_exercise_plan_primary_content_section.dart' as section41;
import 'package:primecare_ui/src/screens/allied/chiropractor_reports/sections/chiropractor_reports_chart_area_section.dart' as section42;
import 'package:primecare_ui/src/screens/allied/chiropractor_reports/sections/chiropractor_reports_export_actions_section.dart' as section43;
import 'package:primecare_ui/src/screens/allied/chiropractor_reports/sections/chiropractor_reports_filter_bar_section.dart' as section44;
import 'package:primecare_ui/src/screens/allied/chiropractor_reports/sections/chiropractor_reports_header_section.dart' as section45;
import 'package:primecare_ui/src/screens/allied/chiropractor_reports/sections/chiropractor_reports_metrics_summary_section.dart' as section46;
import 'package:primecare_ui/src/screens/allied/chiropractor_treatment_notes/sections/chiropractor_treatment_notes_action_bar_section.dart' as section47;
import 'package:primecare_ui/src/screens/allied/chiropractor_treatment_notes/sections/chiropractor_treatment_notes_client_context_section.dart' as section48;
import 'package:primecare_ui/src/screens/allied/chiropractor_treatment_notes/sections/chiropractor_treatment_notes_header_section.dart' as section49;
import 'package:primecare_ui/src/screens/allied/chiropractor_treatment_notes/sections/chiropractor_treatment_notes_notes_form_section.dart' as section50;
import 'package:primecare_ui/src/screens/allied/chiropractor_treatment_notes/sections/chiropractor_treatment_notes_notes_history_section.dart' as section51;
import 'package:primecare_ui/src/screens/allied/client_progress/sections/client_progress_action_bar_section.dart' as section52;
import 'package:primecare_ui/src/screens/allied/client_progress/sections/client_progress_content_summary_section.dart' as section53;
import 'package:primecare_ui/src/screens/allied/client_progress/sections/client_progress_header_section.dart' as section54;
import 'package:primecare_ui/src/screens/allied/client_progress/sections/client_progress_primary_content_section.dart' as section55;
import 'package:primecare_ui/src/screens/allied/home_care_plan/sections/home_care_plan_action_bar_section.dart' as section56;
import 'package:primecare_ui/src/screens/allied/home_care_plan/sections/home_care_plan_content_summary_section.dart' as section57;
import 'package:primecare_ui/src/screens/allied/home_care_plan/sections/home_care_plan_header_section.dart' as section58;
import 'package:primecare_ui/src/screens/allied/home_care_plan/sections/home_care_plan_primary_content_section.dart' as section59;
import 'package:primecare_ui/src/screens/allied/massage_assessment/sections/massage_assessment_action_bar_section.dart' as section60;
import 'package:primecare_ui/src/screens/allied/massage_assessment/sections/massage_assessment_content_summary_section.dart' as section61;
import 'package:primecare_ui/src/screens/allied/massage_assessment/sections/massage_assessment_header_section.dart' as section62;
import 'package:primecare_ui/src/screens/allied/massage_assessment/sections/massage_assessment_primary_content_section.dart' as section63;
import 'package:primecare_ui/src/screens/allied/physiotherapist_appointments/sections/physiotherapist_appointments_action_bar_section.dart' as section64;
import 'package:primecare_ui/src/screens/allied/physiotherapist_appointments/sections/physiotherapist_appointments_appointment_details_section.dart' as section65;
import 'package:primecare_ui/src/screens/allied/physiotherapist_appointments/sections/physiotherapist_appointments_calendar_controls_section.dart' as section66;
import 'package:primecare_ui/src/screens/allied/physiotherapist_appointments/sections/physiotherapist_appointments_header_section.dart' as section67;
import 'package:primecare_ui/src/screens/allied/physiotherapist_appointments/sections/physiotherapist_appointments_schedule_list_section.dart' as section68;
import 'package:primecare_ui/src/screens/allied/physiotherapist_assessment/sections/physiotherapist_assessment_action_bar_section.dart' as section69;
import 'package:primecare_ui/src/screens/allied/physiotherapist_assessment/sections/physiotherapist_assessment_content_summary_section.dart' as section70;
import 'package:primecare_ui/src/screens/allied/physiotherapist_assessment/sections/physiotherapist_assessment_header_section.dart' as section71;
import 'package:primecare_ui/src/screens/allied/physiotherapist_assessment/sections/physiotherapist_assessment_primary_content_section.dart' as section72;
import 'package:primecare_ui/src/screens/allied/physiotherapist_billing_link/sections/physiotherapist_billing_link_action_bar_section.dart' as section73;
import 'package:primecare_ui/src/screens/allied/physiotherapist_billing_link/sections/physiotherapist_billing_link_content_summary_section.dart' as section74;
import 'package:primecare_ui/src/screens/allied/physiotherapist_billing_link/sections/physiotherapist_billing_link_header_section.dart' as section75;
import 'package:primecare_ui/src/screens/allied/physiotherapist_billing_link/sections/physiotherapist_billing_link_primary_content_section.dart' as section76;
import 'package:primecare_ui/src/screens/allied/physiotherapist_client_intake/sections/physiotherapist_client_intake_action_bar_section.dart' as section77;
import 'package:primecare_ui/src/screens/allied/physiotherapist_client_intake/sections/physiotherapist_client_intake_content_summary_section.dart' as section78;
import 'package:primecare_ui/src/screens/allied/physiotherapist_client_intake/sections/physiotherapist_client_intake_header_section.dart' as section79;
import 'package:primecare_ui/src/screens/allied/physiotherapist_client_intake/sections/physiotherapist_client_intake_primary_content_section.dart' as section80;
import 'package:primecare_ui/src/screens/allied/physiotherapist_command_center/sections/physiotherapist_command_center_action_bar_section.dart' as section81;
import 'package:primecare_ui/src/screens/allied/physiotherapist_command_center/sections/physiotherapist_command_center_content_summary_section.dart' as section82;
import 'package:primecare_ui/src/screens/allied/physiotherapist_command_center/sections/physiotherapist_command_center_header_section.dart' as section83;
import 'package:primecare_ui/src/screens/allied/physiotherapist_command_center/sections/physiotherapist_command_center_primary_content_section.dart' as section84;
import 'package:primecare_ui/src/screens/allied/physiotherapist_exercise_plan/sections/physiotherapist_exercise_plan_action_bar_section.dart' as section85;
import 'package:primecare_ui/src/screens/allied/physiotherapist_exercise_plan/sections/physiotherapist_exercise_plan_content_summary_section.dart' as section86;
import 'package:primecare_ui/src/screens/allied/physiotherapist_exercise_plan/sections/physiotherapist_exercise_plan_header_section.dart' as section87;
import 'package:primecare_ui/src/screens/allied/physiotherapist_exercise_plan/sections/physiotherapist_exercise_plan_primary_content_section.dart' as section88;
import 'package:primecare_ui/src/screens/allied/physiotherapist_reports/sections/physiotherapist_reports_chart_area_section.dart' as section89;
import 'package:primecare_ui/src/screens/allied/physiotherapist_reports/sections/physiotherapist_reports_export_actions_section.dart' as section90;
import 'package:primecare_ui/src/screens/allied/physiotherapist_reports/sections/physiotherapist_reports_filter_bar_section.dart' as section91;
import 'package:primecare_ui/src/screens/allied/physiotherapist_reports/sections/physiotherapist_reports_header_section.dart' as section92;
import 'package:primecare_ui/src/screens/allied/physiotherapist_reports/sections/physiotherapist_reports_metrics_summary_section.dart' as section93;
import 'package:primecare_ui/src/screens/allied/physiotherapist_treatment_notes/sections/physiotherapist_treatment_notes_action_bar_section.dart' as section94;
import 'package:primecare_ui/src/screens/allied/physiotherapist_treatment_notes/sections/physiotherapist_treatment_notes_client_context_section.dart' as section95;
import 'package:primecare_ui/src/screens/allied/physiotherapist_treatment_notes/sections/physiotherapist_treatment_notes_header_section.dart' as section96;
import 'package:primecare_ui/src/screens/allied/physiotherapist_treatment_notes/sections/physiotherapist_treatment_notes_notes_form_section.dart' as section97;
import 'package:primecare_ui/src/screens/allied/physiotherapist_treatment_notes/sections/physiotherapist_treatment_notes_notes_history_section.dart' as section98;
import 'package:primecare_ui/src/screens/allied/rmt_analytics/sections/rmt_analytics_chart_area_section.dart' as section99;
import 'package:primecare_ui/src/screens/allied/rmt_analytics/sections/rmt_analytics_export_actions_section.dart' as section100;
import 'package:primecare_ui/src/screens/allied/rmt_analytics/sections/rmt_analytics_filter_bar_section.dart' as section101;
import 'package:primecare_ui/src/screens/allied/rmt_analytics/sections/rmt_analytics_header_section.dart' as section102;
import 'package:primecare_ui/src/screens/allied/rmt_analytics/sections/rmt_analytics_metrics_summary_section.dart' as section103;
import 'package:primecare_ui/src/screens/allied/rmt_appointments/sections/rmt_appointments_action_bar_section.dart' as section104;
import 'package:primecare_ui/src/screens/allied/rmt_appointments/sections/rmt_appointments_appointment_details_section.dart' as section105;
import 'package:primecare_ui/src/screens/allied/rmt_appointments/sections/rmt_appointments_calendar_controls_section.dart' as section106;
import 'package:primecare_ui/src/screens/allied/rmt_appointments/sections/rmt_appointments_header_section.dart' as section107;
import 'package:primecare_ui/src/screens/allied/rmt_appointments/sections/rmt_appointments_schedule_list_section.dart' as section108;
import 'package:primecare_ui/src/screens/allied/rmt_assessment/sections/rmt_assessment_action_bar_section.dart' as section109;
import 'package:primecare_ui/src/screens/allied/rmt_assessment/sections/rmt_assessment_content_summary_section.dart' as section110;
import 'package:primecare_ui/src/screens/allied/rmt_assessment/sections/rmt_assessment_header_section.dart' as section111;
import 'package:primecare_ui/src/screens/allied/rmt_assessment/sections/rmt_assessment_primary_content_section.dart' as section112;
import 'package:primecare_ui/src/screens/allied/rmt_billing_link/sections/rmt_billing_link_action_bar_section.dart' as section113;
import 'package:primecare_ui/src/screens/allied/rmt_billing_link/sections/rmt_billing_link_content_summary_section.dart' as section114;
import 'package:primecare_ui/src/screens/allied/rmt_billing_link/sections/rmt_billing_link_header_section.dart' as section115;
import 'package:primecare_ui/src/screens/allied/rmt_billing_link/sections/rmt_billing_link_primary_content_section.dart' as section116;
import 'package:primecare_ui/src/screens/allied/rmt_client_intake/sections/rmt_client_intake_action_bar_section.dart' as section117;
import 'package:primecare_ui/src/screens/allied/rmt_client_intake/sections/rmt_client_intake_content_summary_section.dart' as section118;
import 'package:primecare_ui/src/screens/allied/rmt_client_intake/sections/rmt_client_intake_header_section.dart' as section119;
import 'package:primecare_ui/src/screens/allied/rmt_client_intake/sections/rmt_client_intake_primary_content_section.dart' as section120;
import 'package:primecare_ui/src/screens/allied/rmt_command_center/sections/rmt_command_center_action_bar_section.dart' as section121;
import 'package:primecare_ui/src/screens/allied/rmt_command_center/sections/rmt_command_center_content_summary_section.dart' as section122;
import 'package:primecare_ui/src/screens/allied/rmt_command_center/sections/rmt_command_center_header_section.dart' as section123;
import 'package:primecare_ui/src/screens/allied/rmt_command_center/sections/rmt_command_center_primary_content_section.dart' as section124;
import 'package:primecare_ui/src/screens/allied/rmt_compliance/sections/rmt_compliance_action_bar_section.dart' as section125;
import 'package:primecare_ui/src/screens/allied/rmt_compliance/sections/rmt_compliance_content_summary_section.dart' as section126;
import 'package:primecare_ui/src/screens/allied/rmt_compliance/sections/rmt_compliance_header_section.dart' as section127;
import 'package:primecare_ui/src/screens/allied/rmt_compliance/sections/rmt_compliance_primary_content_section.dart' as section128;
import 'package:primecare_ui/src/screens/allied/rmt_exercise_plan/sections/rmt_exercise_plan_action_bar_section.dart' as section129;
import 'package:primecare_ui/src/screens/allied/rmt_exercise_plan/sections/rmt_exercise_plan_content_summary_section.dart' as section130;
import 'package:primecare_ui/src/screens/allied/rmt_exercise_plan/sections/rmt_exercise_plan_header_section.dart' as section131;
import 'package:primecare_ui/src/screens/allied/rmt_exercise_plan/sections/rmt_exercise_plan_primary_content_section.dart' as section132;
import 'package:primecare_ui/src/screens/allied/rmt_reports/sections/rmt_reports_chart_area_section.dart' as section133;
import 'package:primecare_ui/src/screens/allied/rmt_reports/sections/rmt_reports_export_actions_section.dart' as section134;
import 'package:primecare_ui/src/screens/allied/rmt_reports/sections/rmt_reports_filter_bar_section.dart' as section135;
import 'package:primecare_ui/src/screens/allied/rmt_reports/sections/rmt_reports_header_section.dart' as section136;
import 'package:primecare_ui/src/screens/allied/rmt_reports/sections/rmt_reports_metrics_summary_section.dart' as section137;
import 'package:primecare_ui/src/screens/allied/rmt_treatment_notes/sections/rmt_treatment_notes_action_bar_section.dart' as section138;
import 'package:primecare_ui/src/screens/allied/rmt_treatment_notes/sections/rmt_treatment_notes_client_context_section.dart' as section139;
import 'package:primecare_ui/src/screens/allied/rmt_treatment_notes/sections/rmt_treatment_notes_header_section.dart' as section140;
import 'package:primecare_ui/src/screens/allied/rmt_treatment_notes/sections/rmt_treatment_notes_notes_form_section.dart' as section141;
import 'package:primecare_ui/src/screens/allied/rmt_treatment_notes/sections/rmt_treatment_notes_notes_history_section.dart' as section142;
import 'package:primecare_ui/src/screens/allied/rmt_workflow/sections/rmt_workflow_action_bar_section.dart' as section143;
import 'package:primecare_ui/src/screens/allied/rmt_workflow/sections/rmt_workflow_header_section.dart' as section144;
import 'package:primecare_ui/src/screens/allied/rmt_workflow/sections/rmt_workflow_task_details_section.dart' as section145;
import 'package:primecare_ui/src/screens/allied/rmt_workflow/sections/rmt_workflow_task_filters_section.dart' as section146;
import 'package:primecare_ui/src/screens/allied/rmt_workflow/sections/rmt_workflow_task_list_section.dart' as section147;
import 'package:primecare_ui/src/screens/allied/therapist_analytics/sections/therapist_analytics_chart_area_section.dart' as section148;
import 'package:primecare_ui/src/screens/allied/therapist_analytics/sections/therapist_analytics_export_actions_section.dart' as section149;
import 'package:primecare_ui/src/screens/allied/therapist_analytics/sections/therapist_analytics_filter_bar_section.dart' as section150;
import 'package:primecare_ui/src/screens/allied/therapist_analytics/sections/therapist_analytics_header_section.dart' as section151;
import 'package:primecare_ui/src/screens/allied/therapist_analytics/sections/therapist_analytics_metrics_summary_section.dart' as section152;
import 'package:primecare_ui/src/screens/allied/therapist_workflow/sections/therapist_workflow_action_bar_section.dart' as section153;
import 'package:primecare_ui/src/screens/allied/therapist_workflow/sections/therapist_workflow_header_section.dart' as section154;
import 'package:primecare_ui/src/screens/allied/therapist_workflow/sections/therapist_workflow_task_details_section.dart' as section155;
import 'package:primecare_ui/src/screens/allied/therapist_workflow/sections/therapist_workflow_task_filters_section.dart' as section156;
import 'package:primecare_ui/src/screens/allied/therapist_workflow/sections/therapist_workflow_task_list_section.dart' as section157;
import 'package:primecare_ui/src/screens/allied/xray_review/sections/xray_review_action_bar_section.dart' as section158;
import 'package:primecare_ui/src/screens/allied/xray_review/sections/xray_review_data_table_section.dart' as section159;
import 'package:primecare_ui/src/screens/allied/xray_review/sections/xray_review_filter_bar_section.dart' as section160;
import 'package:primecare_ui/src/screens/allied/xray_review/sections/xray_review_header_section.dart' as section161;
import 'package:primecare_ui/src/screens/allied/xray_review/sections/xray_review_pagination_section.dart' as section162;
import 'package:primecare_ui/src/screens/clinical/clinical_analytics/sections/clinical_analytics_chart_area_section.dart' as section163;
import 'package:primecare_ui/src/screens/clinical/clinical_analytics/sections/clinical_analytics_export_actions_section.dart' as section164;
import 'package:primecare_ui/src/screens/clinical/clinical_analytics/sections/clinical_analytics_filter_bar_section.dart' as section165;
import 'package:primecare_ui/src/screens/clinical/clinical_analytics/sections/clinical_analytics_header_section.dart' as section166;
import 'package:primecare_ui/src/screens/clinical/clinical_analytics/sections/clinical_analytics_metrics_summary_section.dart' as section167;
import 'package:primecare_ui/src/screens/clinical/clinical_compliance/sections/clinical_compliance_action_bar_section.dart' as section168;
import 'package:primecare_ui/src/screens/clinical/clinical_compliance/sections/clinical_compliance_content_summary_section.dart' as section169;
import 'package:primecare_ui/src/screens/clinical/clinical_compliance/sections/clinical_compliance_header_section.dart' as section170;
import 'package:primecare_ui/src/screens/clinical/clinical_compliance/sections/clinical_compliance_primary_content_section.dart' as section171;
import 'package:primecare_ui/src/screens/clinical/clinical_director_approvals/sections/clinical_director_approvals_action_bar_section.dart' as section172;
import 'package:primecare_ui/src/screens/clinical/clinical_director_approvals/sections/clinical_director_approvals_content_summary_section.dart' as section173;
import 'package:primecare_ui/src/screens/clinical/clinical_director_approvals/sections/clinical_director_approvals_header_section.dart' as section174;
import 'package:primecare_ui/src/screens/clinical/clinical_director_approvals/sections/clinical_director_approvals_primary_content_section.dart' as section175;
import 'package:primecare_ui/src/screens/clinical/clinical_director_compliance/sections/clinical_director_compliance_action_bar_section.dart' as section176;
import 'package:primecare_ui/src/screens/clinical/clinical_director_compliance/sections/clinical_director_compliance_content_summary_section.dart' as section177;
import 'package:primecare_ui/src/screens/clinical/clinical_director_compliance/sections/clinical_director_compliance_header_section.dart' as section178;
import 'package:primecare_ui/src/screens/clinical/clinical_director_compliance/sections/clinical_director_compliance_primary_content_section.dart' as section179;
import 'package:primecare_ui/src/screens/clinical/clinical_director_incident_review/sections/clinical_director_incident_review_action_bar_section.dart' as section180;
import 'package:primecare_ui/src/screens/clinical/clinical_director_incident_review/sections/clinical_director_incident_review_data_table_section.dart' as section181;
import 'package:primecare_ui/src/screens/clinical/clinical_director_incident_review/sections/clinical_director_incident_review_filter_bar_section.dart' as section182;
import 'package:primecare_ui/src/screens/clinical/clinical_director_incident_review/sections/clinical_director_incident_review_header_section.dart' as section183;
import 'package:primecare_ui/src/screens/clinical/clinical_director_incident_review/sections/clinical_director_incident_review_pagination_section.dart' as section184;
import 'package:primecare_ui/src/screens/clinical/clinical_director_performance/sections/clinical_director_performance_action_bar_section.dart' as section185;
import 'package:primecare_ui/src/screens/clinical/clinical_director_performance/sections/clinical_director_performance_form_body_section.dart' as section186;
import 'package:primecare_ui/src/screens/clinical/clinical_director_performance/sections/clinical_director_performance_header_section.dart' as section187;
import 'package:primecare_ui/src/screens/clinical/clinical_director_performance/sections/clinical_director_performance_validation_messages_section.dart' as section188;
import 'package:primecare_ui/src/screens/clinical/clinical_director_reports/sections/clinical_director_reports_chart_area_section.dart' as section189;
import 'package:primecare_ui/src/screens/clinical/clinical_director_reports/sections/clinical_director_reports_export_actions_section.dart' as section190;
import 'package:primecare_ui/src/screens/clinical/clinical_director_reports/sections/clinical_director_reports_filter_bar_section.dart' as section191;
import 'package:primecare_ui/src/screens/clinical/clinical_director_reports/sections/clinical_director_reports_header_section.dart' as section192;
import 'package:primecare_ui/src/screens/clinical/clinical_director_reports/sections/clinical_director_reports_metrics_summary_section.dart' as section193;
import 'package:primecare_ui/src/screens/clinical/clinical_director_staff_quality/sections/clinical_director_staff_quality_action_bar_section.dart' as section194;
import 'package:primecare_ui/src/screens/clinical/clinical_director_staff_quality/sections/clinical_director_staff_quality_content_summary_section.dart' as section195;
import 'package:primecare_ui/src/screens/clinical/clinical_director_staff_quality/sections/clinical_director_staff_quality_header_section.dart' as section196;
import 'package:primecare_ui/src/screens/clinical/clinical_director_staff_quality/sections/clinical_director_staff_quality_primary_content_section.dart' as section197;
import 'package:primecare_ui/src/screens/clinical/clinical_operations4_k/sections/clinical_operations4_k_action_bar_section.dart' as section198;
import 'package:primecare_ui/src/screens/clinical/clinical_operations4_k/sections/clinical_operations4_k_content_summary_section.dart' as section199;
import 'package:primecare_ui/src/screens/clinical/clinical_operations4_k/sections/clinical_operations4_k_header_section.dart' as section200;
import 'package:primecare_ui/src/screens/clinical/clinical_operations4_k/sections/clinical_operations4_k_primary_content_section.dart' as section201;
import 'package:primecare_ui/src/screens/clinical/clinical_quality/sections/clinical_quality_action_bar_section.dart' as section202;
import 'package:primecare_ui/src/screens/clinical/clinical_quality/sections/clinical_quality_content_summary_section.dart' as section203;
import 'package:primecare_ui/src/screens/clinical/clinical_quality/sections/clinical_quality_header_section.dart' as section204;
import 'package:primecare_ui/src/screens/clinical/clinical_quality/sections/clinical_quality_primary_content_section.dart' as section205;
import 'package:primecare_ui/src/screens/clinical/clinical_workflow/sections/clinical_workflow_action_bar_section.dart' as section206;
import 'package:primecare_ui/src/screens/clinical/clinical_workflow/sections/clinical_workflow_header_section.dart' as section207;
import 'package:primecare_ui/src/screens/clinical/clinical_workflow/sections/clinical_workflow_task_details_section.dart' as section208;
import 'package:primecare_ui/src/screens/clinical/clinical_workflow/sections/clinical_workflow_task_filters_section.dart' as section209;
import 'package:primecare_ui/src/screens/clinical/clinical_workflow/sections/clinical_workflow_task_list_section.dart' as section210;
import 'package:primecare_ui/src/screens/clinical/compliance_review/sections/compliance_review_action_bar_section.dart' as section211;
import 'package:primecare_ui/src/screens/clinical/compliance_review/sections/compliance_review_data_table_section.dart' as section212;
import 'package:primecare_ui/src/screens/clinical/compliance_review/sections/compliance_review_filter_bar_section.dart' as section213;
import 'package:primecare_ui/src/screens/clinical/compliance_review/sections/compliance_review_header_section.dart' as section214;
import 'package:primecare_ui/src/screens/clinical/compliance_review/sections/compliance_review_pagination_section.dart' as section215;
import 'package:primecare_ui/src/screens/clinical/exercise_prescription/sections/exercise_prescription_action_bar_section.dart' as section216;
import 'package:primecare_ui/src/screens/clinical/exercise_prescription/sections/exercise_prescription_content_summary_section.dart' as section217;
import 'package:primecare_ui/src/screens/clinical/exercise_prescription/sections/exercise_prescription_header_section.dart' as section218;
import 'package:primecare_ui/src/screens/clinical/exercise_prescription/sections/exercise_prescription_primary_content_section.dart' as section219;
import 'package:primecare_ui/src/screens/clinical/hsw_adl_logger/sections/hsw_adl_logger_action_bar_section.dart' as section220;
import 'package:primecare_ui/src/screens/clinical/hsw_adl_logger/sections/hsw_adl_logger_data_table_section.dart' as section221;
import 'package:primecare_ui/src/screens/clinical/hsw_adl_logger/sections/hsw_adl_logger_filter_bar_section.dart' as section222;
import 'package:primecare_ui/src/screens/clinical/hsw_adl_logger/sections/hsw_adl_logger_header_section.dart' as section223;
import 'package:primecare_ui/src/screens/clinical/hsw_adl_logger/sections/hsw_adl_logger_pagination_section.dart' as section224;
import 'package:primecare_ui/src/screens/clinical/hsw_care_plans/sections/hsw_care_plans_action_bar_section.dart' as section225;
import 'package:primecare_ui/src/screens/clinical/hsw_care_plans/sections/hsw_care_plans_content_summary_section.dart' as section226;
import 'package:primecare_ui/src/screens/clinical/hsw_care_plans/sections/hsw_care_plans_header_section.dart' as section227;
import 'package:primecare_ui/src/screens/clinical/hsw_care_plans/sections/hsw_care_plans_primary_content_section.dart' as section228;
import 'package:primecare_ui/src/screens/clinical/hsw_incident_reports/sections/hsw_incident_reports_chart_area_section.dart' as section229;
import 'package:primecare_ui/src/screens/clinical/hsw_incident_reports/sections/hsw_incident_reports_export_actions_section.dart' as section230;
import 'package:primecare_ui/src/screens/clinical/hsw_incident_reports/sections/hsw_incident_reports_filter_bar_section.dart' as section231;
import 'package:primecare_ui/src/screens/clinical/hsw_incident_reports/sections/hsw_incident_reports_header_section.dart' as section232;
import 'package:primecare_ui/src/screens/clinical/hsw_incident_reports/sections/hsw_incident_reports_metrics_summary_section.dart' as section233;
import 'package:primecare_ui/src/screens/clinical/hsw_schedule/sections/hsw_schedule_action_bar_section.dart' as section234;
import 'package:primecare_ui/src/screens/clinical/hsw_schedule/sections/hsw_schedule_appointment_details_section.dart' as section235;
import 'package:primecare_ui/src/screens/clinical/hsw_schedule/sections/hsw_schedule_calendar_controls_section.dart' as section236;
import 'package:primecare_ui/src/screens/clinical/hsw_schedule/sections/hsw_schedule_header_section.dart' as section237;
import 'package:primecare_ui/src/screens/clinical/hsw_schedule/sections/hsw_schedule_schedule_list_section.dart' as section238;
import 'package:primecare_ui/src/screens/clinical/incident_oversight/sections/incident_oversight_action_bar_section.dart' as section239;
import 'package:primecare_ui/src/screens/clinical/incident_oversight/sections/incident_oversight_content_summary_section.dart' as section240;
import 'package:primecare_ui/src/screens/clinical/incident_oversight/sections/incident_oversight_header_section.dart' as section241;
import 'package:primecare_ui/src/screens/clinical/incident_oversight/sections/incident_oversight_primary_content_section.dart' as section242;
import 'package:primecare_ui/src/screens/clinical/medication/sections/medication_action_bar_section.dart' as section243;
import 'package:primecare_ui/src/screens/clinical/medication/sections/medication_content_summary_section.dart' as section244;
import 'package:primecare_ui/src/screens/clinical/medication/sections/medication_header_section.dart' as section245;
import 'package:primecare_ui/src/screens/clinical/medication/sections/medication_primary_content_section.dart' as section246;
import 'package:primecare_ui/src/screens/clinical/nursing_task/sections/nursing_task_action_bar_section.dart' as section247;
import 'package:primecare_ui/src/screens/clinical/nursing_task/sections/nursing_task_header_section.dart' as section248;
import 'package:primecare_ui/src/screens/clinical/nursing_task/sections/nursing_task_task_details_section.dart' as section249;
import 'package:primecare_ui/src/screens/clinical/nursing_task/sections/nursing_task_task_filters_section.dart' as section250;
import 'package:primecare_ui/src/screens/clinical/nursing_task/sections/nursing_task_task_list_section.dart' as section251;
import 'package:primecare_ui/src/screens/clinical/patient_observation/sections/patient_observation_action_bar_section.dart' as section252;
import 'package:primecare_ui/src/screens/clinical/patient_observation/sections/patient_observation_content_summary_section.dart' as section253;
import 'package:primecare_ui/src/screens/clinical/patient_observation/sections/patient_observation_header_section.dart' as section254;
import 'package:primecare_ui/src/screens/clinical/patient_observation/sections/patient_observation_primary_content_section.dart' as section255;
import 'package:primecare_ui/src/screens/clinical/pediatric_analytics/sections/pediatric_analytics_chart_area_section.dart' as section256;
import 'package:primecare_ui/src/screens/clinical/pediatric_analytics/sections/pediatric_analytics_export_actions_section.dart' as section257;
import 'package:primecare_ui/src/screens/clinical/pediatric_analytics/sections/pediatric_analytics_filter_bar_section.dart' as section258;
import 'package:primecare_ui/src/screens/clinical/pediatric_analytics/sections/pediatric_analytics_header_section.dart' as section259;
import 'package:primecare_ui/src/screens/clinical/pediatric_analytics/sections/pediatric_analytics_metrics_summary_section.dart' as section260;
import 'package:primecare_ui/src/screens/clinical/pediatric_workflow/sections/pediatric_workflow_action_bar_section.dart' as section261;
import 'package:primecare_ui/src/screens/clinical/pediatric_workflow/sections/pediatric_workflow_header_section.dart' as section262;
import 'package:primecare_ui/src/screens/clinical/pediatric_workflow/sections/pediatric_workflow_task_details_section.dart' as section263;
import 'package:primecare_ui/src/screens/clinical/pediatric_workflow/sections/pediatric_workflow_task_filters_section.dart' as section264;
import 'package:primecare_ui/src/screens/clinical/pediatric_workflow/sections/pediatric_workflow_task_list_section.dart' as section265;
import 'package:primecare_ui/src/screens/clinical/physician_analytics/sections/physician_analytics_chart_area_section.dart' as section266;
import 'package:primecare_ui/src/screens/clinical/physician_analytics/sections/physician_analytics_export_actions_section.dart' as section267;
import 'package:primecare_ui/src/screens/clinical/physician_analytics/sections/physician_analytics_filter_bar_section.dart' as section268;
import 'package:primecare_ui/src/screens/clinical/physician_analytics/sections/physician_analytics_header_section.dart' as section269;
import 'package:primecare_ui/src/screens/clinical/physician_analytics/sections/physician_analytics_metrics_summary_section.dart' as section270;
import 'package:primecare_ui/src/screens/clinical/physician_workflow/sections/physician_workflow_action_bar_section.dart' as section271;
import 'package:primecare_ui/src/screens/clinical/physician_workflow/sections/physician_workflow_header_section.dart' as section272;
import 'package:primecare_ui/src/screens/clinical/physician_workflow/sections/physician_workflow_task_details_section.dart' as section273;
import 'package:primecare_ui/src/screens/clinical/physician_workflow/sections/physician_workflow_task_filters_section.dart' as section274;
import 'package:primecare_ui/src/screens/clinical/physician_workflow/sections/physician_workflow_task_list_section.dart' as section275;
import 'package:primecare_ui/src/screens/clinical/progress_tracking/sections/progress_tracking_action_bar_section.dart' as section276;
import 'package:primecare_ui/src/screens/clinical/progress_tracking/sections/progress_tracking_content_summary_section.dart' as section277;
import 'package:primecare_ui/src/screens/clinical/progress_tracking/sections/progress_tracking_header_section.dart' as section278;
import 'package:primecare_ui/src/screens/clinical/progress_tracking/sections/progress_tracking_primary_content_section.dart' as section279;
import 'package:primecare_ui/src/screens/clinical/staff_performance/sections/staff_performance_action_bar_section.dart' as section280;
import 'package:primecare_ui/src/screens/clinical/staff_performance/sections/staff_performance_form_body_section.dart' as section281;
import 'package:primecare_ui/src/screens/clinical/staff_performance/sections/staff_performance_header_section.dart' as section282;
import 'package:primecare_ui/src/screens/clinical/staff_performance/sections/staff_performance_validation_messages_section.dart' as section283;
import 'package:primecare_ui/src/screens/clinical/treatment_plan/sections/treatment_plan_action_bar_section.dart' as section284;
import 'package:primecare_ui/src/screens/clinical/treatment_plan/sections/treatment_plan_content_summary_section.dart' as section285;
import 'package:primecare_ui/src/screens/clinical/treatment_plan/sections/treatment_plan_header_section.dart' as section286;
import 'package:primecare_ui/src/screens/clinical/treatment_plan/sections/treatment_plan_primary_content_section.dart' as section287;
import 'package:primecare_ui/src/screens/clinical/vitals_tracking/sections/vitals_tracking_action_bar_section.dart' as section288;
import 'package:primecare_ui/src/screens/clinical/vitals_tracking/sections/vitals_tracking_content_summary_section.dart' as section289;
import 'package:primecare_ui/src/screens/clinical/vitals_tracking/sections/vitals_tracking_header_section.dart' as section290;
import 'package:primecare_ui/src/screens/clinical/vitals_tracking/sections/vitals_tracking_primary_content_section.dart' as section291;
import 'package:primecare_ui/src/screens/common/agent_dispatch/sections/agent_dispatch_action_bar_section.dart' as section292;
import 'package:primecare_ui/src/screens/common/agent_dispatch/sections/agent_dispatch_content_summary_section.dart' as section293;
import 'package:primecare_ui/src/screens/common/agent_dispatch/sections/agent_dispatch_header_section.dart' as section294;
import 'package:primecare_ui/src/screens/common/agent_dispatch/sections/agent_dispatch_primary_content_section.dart' as section295;
import 'package:primecare_ui/src/screens/common/api_health_dashboard/sections/api_health_dashboard_chart_overview_section.dart' as section296;
import 'package:primecare_ui/src/screens/common/api_health_dashboard/sections/api_health_dashboard_header_section.dart' as section297;
import 'package:primecare_ui/src/screens/common/api_health_dashboard/sections/api_health_dashboard_quick_actions_section.dart' as section298;
import 'package:primecare_ui/src/screens/common/api_health_dashboard/sections/api_health_dashboard_recent_activity_section.dart' as section299;
import 'package:primecare_ui/src/screens/common/api_health_dashboard/sections/api_health_dashboard_summary_cards_section.dart' as section300;
import 'package:primecare_ui/src/screens/common/appointment/sections/appointment_action_bar_section.dart' as section301;
import 'package:primecare_ui/src/screens/common/appointment/sections/appointment_appointment_details_section.dart' as section302;
import 'package:primecare_ui/src/screens/common/appointment/sections/appointment_calendar_controls_section.dart' as section303;
import 'package:primecare_ui/src/screens/common/appointment/sections/appointment_header_section.dart' as section304;
import 'package:primecare_ui/src/screens/common/appointment/sections/appointment_schedule_list_section.dart' as section305;
import 'package:primecare_ui/src/screens/common/architecture_planning_analytics/sections/architecture_planning_analytics_chart_area_section.dart' as section306;
import 'package:primecare_ui/src/screens/common/architecture_planning_analytics/sections/architecture_planning_analytics_export_actions_section.dart' as section307;
import 'package:primecare_ui/src/screens/common/architecture_planning_analytics/sections/architecture_planning_analytics_filter_bar_section.dart' as section308;
import 'package:primecare_ui/src/screens/common/architecture_planning_analytics/sections/architecture_planning_analytics_header_section.dart' as section309;
import 'package:primecare_ui/src/screens/common/architecture_planning_analytics/sections/architecture_planning_analytics_metrics_summary_section.dart' as section310;
import 'package:primecare_ui/src/screens/common/architecture_planning_compliance/sections/architecture_planning_compliance_action_bar_section.dart' as section311;
import 'package:primecare_ui/src/screens/common/architecture_planning_compliance/sections/architecture_planning_compliance_content_summary_section.dart' as section312;
import 'package:primecare_ui/src/screens/common/architecture_planning_compliance/sections/architecture_planning_compliance_header_section.dart' as section313;
import 'package:primecare_ui/src/screens/common/architecture_planning_compliance/sections/architecture_planning_compliance_primary_content_section.dart' as section314;
import 'package:primecare_ui/src/screens/common/architecture_planning_workflow/sections/architecture_planning_workflow_action_bar_section.dart' as section315;
import 'package:primecare_ui/src/screens/common/architecture_planning_workflow/sections/architecture_planning_workflow_header_section.dart' as section316;
import 'package:primecare_ui/src/screens/common/architecture_planning_workflow/sections/architecture_planning_workflow_task_details_section.dart' as section317;
import 'package:primecare_ui/src/screens/common/architecture_planning_workflow/sections/architecture_planning_workflow_task_filters_section.dart' as section318;
import 'package:primecare_ui/src/screens/common/architecture_planning_workflow/sections/architecture_planning_workflow_task_list_section.dart' as section319;
import 'package:primecare_ui/src/screens/common/audit/sections/audit_action_bar_section.dart' as section320;
import 'package:primecare_ui/src/screens/common/audit/sections/audit_content_summary_section.dart' as section321;
import 'package:primecare_ui/src/screens/common/audit/sections/audit_header_section.dart' as section322;
import 'package:primecare_ui/src/screens/common/audit/sections/audit_primary_content_section.dart' as section323;
import 'package:primecare_ui/src/screens/common/audit/sections/screen_audit_action_bar_section.dart' as section324;
import 'package:primecare_ui/src/screens/common/audit/sections/screen_audit_content_summary_section.dart' as section325;
import 'package:primecare_ui/src/screens/common/audit/sections/screen_audit_header_section.dart' as section326;
import 'package:primecare_ui/src/screens/common/audit/sections/screen_audit_primary_content_section.dart' as section327;
import 'package:primecare_ui/src/screens/common/billing/sections/billing_action_bar_section.dart' as section328;
import 'package:primecare_ui/src/screens/common/billing/sections/billing_content_summary_section.dart' as section329;
import 'package:primecare_ui/src/screens/common/billing/sections/billing_header_section.dart' as section330;
import 'package:primecare_ui/src/screens/common/billing/sections/billing_primary_content_section.dart' as section331;
import 'package:primecare_ui/src/screens/common/billing_overview/sections/billing_overview_action_bar_section.dart' as section332;
import 'package:primecare_ui/src/screens/common/billing_overview/sections/billing_overview_data_table_section.dart' as section333;
import 'package:primecare_ui/src/screens/common/billing_overview/sections/billing_overview_filter_bar_section.dart' as section334;
import 'package:primecare_ui/src/screens/common/billing_overview/sections/billing_overview_header_section.dart' as section335;
import 'package:primecare_ui/src/screens/common/billing_overview/sections/billing_overview_pagination_section.dart' as section336;
import 'package:primecare_ui/src/screens/common/business_development_analytics/sections/business_development_analytics_chart_area_section.dart' as section337;
import 'package:primecare_ui/src/screens/common/business_development_analytics/sections/business_development_analytics_export_actions_section.dart' as section338;
import 'package:primecare_ui/src/screens/common/business_development_analytics/sections/business_development_analytics_filter_bar_section.dart' as section339;
import 'package:primecare_ui/src/screens/common/business_development_analytics/sections/business_development_analytics_header_section.dart' as section340;
import 'package:primecare_ui/src/screens/common/business_development_analytics/sections/business_development_analytics_metrics_summary_section.dart' as section341;
import 'package:primecare_ui/src/screens/common/business_development_compliance/sections/business_development_compliance_action_bar_section.dart' as section342;
import 'package:primecare_ui/src/screens/common/business_development_compliance/sections/business_development_compliance_content_summary_section.dart' as section343;
import 'package:primecare_ui/src/screens/common/business_development_compliance/sections/business_development_compliance_header_section.dart' as section344;
import 'package:primecare_ui/src/screens/common/business_development_compliance/sections/business_development_compliance_primary_content_section.dart' as section345;
import 'package:primecare_ui/src/screens/common/business_development_dashboard/sections/business_development_dashboard_chart_overview_section.dart' as section346;
import 'package:primecare_ui/src/screens/common/business_development_dashboard/sections/business_development_dashboard_header_section.dart' as section347;
import 'package:primecare_ui/src/screens/common/business_development_dashboard/sections/business_development_dashboard_quick_actions_section.dart' as section348;
import 'package:primecare_ui/src/screens/common/business_development_dashboard/sections/business_development_dashboard_recent_activity_section.dart' as section349;
import 'package:primecare_ui/src/screens/common/business_development_dashboard/sections/business_development_dashboard_summary_cards_section.dart' as section350;
import 'package:primecare_ui/src/screens/common/business_development_workflow/sections/business_development_workflow_action_bar_section.dart' as section351;
import 'package:primecare_ui/src/screens/common/business_development_workflow/sections/business_development_workflow_header_section.dart' as section352;
import 'package:primecare_ui/src/screens/common/business_development_workflow/sections/business_development_workflow_task_details_section.dart' as section353;
import 'package:primecare_ui/src/screens/common/business_development_workflow/sections/business_development_workflow_task_filters_section.dart' as section354;
import 'package:primecare_ui/src/screens/common/business_development_workflow/sections/business_development_workflow_task_list_section.dart' as section355;
import 'package:primecare_ui/src/screens/common/care_plan/sections/care_plan_action_bar_section.dart' as section356;
import 'package:primecare_ui/src/screens/common/care_plan/sections/care_plan_content_summary_section.dart' as section357;
import 'package:primecare_ui/src/screens/common/care_plan/sections/care_plan_header_section.dart' as section358;
import 'package:primecare_ui/src/screens/common/care_plan/sections/care_plan_primary_content_section.dart' as section359;
import 'package:primecare_ui/src/screens/common/care_updates/sections/care_updates_action_bar_section.dart' as section360;
import 'package:primecare_ui/src/screens/common/care_updates/sections/care_updates_content_summary_section.dart' as section361;
import 'package:primecare_ui/src/screens/common/care_updates/sections/care_updates_header_section.dart' as section362;
import 'package:primecare_ui/src/screens/common/care_updates/sections/care_updates_primary_content_section.dart' as section363;
import 'package:primecare_ui/src/screens/common/caregiver_dashboard/sections/caregiver_dashboard_chart_overview_section.dart' as section364;
import 'package:primecare_ui/src/screens/common/caregiver_dashboard/sections/caregiver_dashboard_header_section.dart' as section365;
import 'package:primecare_ui/src/screens/common/caregiver_dashboard/sections/caregiver_dashboard_quick_actions_section.dart' as section366;
import 'package:primecare_ui/src/screens/common/caregiver_dashboard/sections/caregiver_dashboard_recent_activity_section.dart' as section367;
import 'package:primecare_ui/src/screens/common/caregiver_dashboard/sections/caregiver_dashboard_summary_cards_section.dart' as section368;
import 'package:primecare_ui/src/screens/common/chiropractor_analytics/sections/chiropractor_analytics_chart_area_section.dart' as section369;
import 'package:primecare_ui/src/screens/common/chiropractor_analytics/sections/chiropractor_analytics_export_actions_section.dart' as section370;
import 'package:primecare_ui/src/screens/common/chiropractor_analytics/sections/chiropractor_analytics_filter_bar_section.dart' as section371;
import 'package:primecare_ui/src/screens/common/chiropractor_analytics/sections/chiropractor_analytics_header_section.dart' as section372;
import 'package:primecare_ui/src/screens/common/chiropractor_analytics/sections/chiropractor_analytics_metrics_summary_section.dart' as section373;
import 'package:primecare_ui/src/screens/common/chiropractor_compliance/sections/chiropractor_compliance_action_bar_section.dart' as section374;
import 'package:primecare_ui/src/screens/common/chiropractor_compliance/sections/chiropractor_compliance_content_summary_section.dart' as section375;
import 'package:primecare_ui/src/screens/common/chiropractor_compliance/sections/chiropractor_compliance_header_section.dart' as section376;
import 'package:primecare_ui/src/screens/common/chiropractor_compliance/sections/chiropractor_compliance_primary_content_section.dart' as section377;
import 'package:primecare_ui/src/screens/common/chiropractor_dashboard/sections/chiropractor_dashboard_chart_overview_section.dart' as section378;
import 'package:primecare_ui/src/screens/common/chiropractor_dashboard/sections/chiropractor_dashboard_header_section.dart' as section379;
import 'package:primecare_ui/src/screens/common/chiropractor_dashboard/sections/chiropractor_dashboard_quick_actions_section.dart' as section380;
import 'package:primecare_ui/src/screens/common/chiropractor_dashboard/sections/chiropractor_dashboard_recent_activity_section.dart' as section381;
import 'package:primecare_ui/src/screens/common/chiropractor_dashboard/sections/chiropractor_dashboard_summary_cards_section.dart' as section382;
import 'package:primecare_ui/src/screens/common/chiropractor_workflow/sections/chiropractor_workflow_action_bar_section.dart' as section383;
import 'package:primecare_ui/src/screens/common/chiropractor_workflow/sections/chiropractor_workflow_header_section.dart' as section384;
import 'package:primecare_ui/src/screens/common/chiropractor_workflow/sections/chiropractor_workflow_task_details_section.dart' as section385;
import 'package:primecare_ui/src/screens/common/chiropractor_workflow/sections/chiropractor_workflow_task_filters_section.dart' as section386;
import 'package:primecare_ui/src/screens/common/chiropractor_workflow/sections/chiropractor_workflow_task_list_section.dart' as section387;
import 'package:primecare_ui/src/screens/common/clinic_analytics/sections/clinic_analytics_chart_area_section.dart' as section388;
import 'package:primecare_ui/src/screens/common/clinic_analytics/sections/clinic_analytics_export_actions_section.dart' as section389;
import 'package:primecare_ui/src/screens/common/clinic_analytics/sections/clinic_analytics_filter_bar_section.dart' as section390;
import 'package:primecare_ui/src/screens/common/clinic_analytics/sections/clinic_analytics_header_section.dart' as section391;
import 'package:primecare_ui/src/screens/common/clinic_analytics/sections/clinic_analytics_metrics_summary_section.dart' as section392;
import 'package:primecare_ui/src/screens/common/clinic_compliance/sections/clinic_compliance_action_bar_section.dart' as section393;
import 'package:primecare_ui/src/screens/common/clinic_compliance/sections/clinic_compliance_content_summary_section.dart' as section394;
import 'package:primecare_ui/src/screens/common/clinic_compliance/sections/clinic_compliance_header_section.dart' as section395;
import 'package:primecare_ui/src/screens/common/clinic_compliance/sections/clinic_compliance_primary_content_section.dart' as section396;
import 'package:primecare_ui/src/screens/common/clinic_dashboard/sections/clinic_dashboard_chart_overview_section.dart' as section397;
import 'package:primecare_ui/src/screens/common/clinic_dashboard/sections/clinic_dashboard_header_section.dart' as section398;
import 'package:primecare_ui/src/screens/common/clinic_dashboard/sections/clinic_dashboard_quick_actions_section.dart' as section399;
import 'package:primecare_ui/src/screens/common/clinic_dashboard/sections/clinic_dashboard_recent_activity_section.dart' as section400;
import 'package:primecare_ui/src/screens/common/clinic_dashboard/sections/clinic_dashboard_summary_cards_section.dart' as section401;
import 'package:primecare_ui/src/screens/common/clinic_workflow/sections/clinic_workflow_action_bar_section.dart' as section402;
import 'package:primecare_ui/src/screens/common/clinic_workflow/sections/clinic_workflow_header_section.dart' as section403;
import 'package:primecare_ui/src/screens/common/clinic_workflow/sections/clinic_workflow_task_details_section.dart' as section404;
import 'package:primecare_ui/src/screens/common/clinic_workflow/sections/clinic_workflow_task_filters_section.dart' as section405;
import 'package:primecare_ui/src/screens/common/clinic_workflow/sections/clinic_workflow_task_list_section.dart' as section406;
import 'package:primecare_ui/src/screens/common/course_architect_analytics/sections/course_architect_analytics_chart_area_section.dart' as section407;
import 'package:primecare_ui/src/screens/common/course_architect_analytics/sections/course_architect_analytics_export_actions_section.dart' as section408;
import 'package:primecare_ui/src/screens/common/course_architect_analytics/sections/course_architect_analytics_filter_bar_section.dart' as section409;
import 'package:primecare_ui/src/screens/common/course_architect_analytics/sections/course_architect_analytics_header_section.dart' as section410;
import 'package:primecare_ui/src/screens/common/course_architect_analytics/sections/course_architect_analytics_metrics_summary_section.dart' as section411;
import 'package:primecare_ui/src/screens/common/course_architect_compliance/sections/course_architect_compliance_action_bar_section.dart' as section412;
import 'package:primecare_ui/src/screens/common/course_architect_compliance/sections/course_architect_compliance_data_table_section.dart' as section413;
import 'package:primecare_ui/src/screens/common/course_architect_compliance/sections/course_architect_compliance_filter_bar_section.dart' as section414;
import 'package:primecare_ui/src/screens/common/course_architect_compliance/sections/course_architect_compliance_header_section.dart' as section415;
import 'package:primecare_ui/src/screens/common/course_architect_compliance/sections/course_architect_compliance_pagination_section.dart' as section416;
import 'package:primecare_ui/src/screens/common/course_architect_dashboard/sections/course_architect_dashboard_chart_overview_section.dart' as section417;
import 'package:primecare_ui/src/screens/common/course_architect_dashboard/sections/course_architect_dashboard_header_section.dart' as section418;
import 'package:primecare_ui/src/screens/common/course_architect_dashboard/sections/course_architect_dashboard_quick_actions_section.dart' as section419;
import 'package:primecare_ui/src/screens/common/course_architect_dashboard/sections/course_architect_dashboard_recent_activity_section.dart' as section420;
import 'package:primecare_ui/src/screens/common/course_architect_dashboard/sections/course_architect_dashboard_summary_cards_section.dart' as section421;
import 'package:primecare_ui/src/screens/common/course_architect_workflow/sections/course_architect_workflow_action_bar_section.dart' as section422;
import 'package:primecare_ui/src/screens/common/course_architect_workflow/sections/course_architect_workflow_header_section.dart' as section423;
import 'package:primecare_ui/src/screens/common/course_architect_workflow/sections/course_architect_workflow_task_details_section.dart' as section424;
import 'package:primecare_ui/src/screens/common/course_architect_workflow/sections/course_architect_workflow_task_filters_section.dart' as section425;
import 'package:primecare_ui/src/screens/common/course_architect_workflow/sections/course_architect_workflow_task_list_section.dart' as section426;
import 'package:primecare_ui/src/screens/common/customer_support_analytics/sections/customer_support_analytics_chart_area_section.dart' as section427;
import 'package:primecare_ui/src/screens/common/customer_support_analytics/sections/customer_support_analytics_export_actions_section.dart' as section428;
import 'package:primecare_ui/src/screens/common/customer_support_analytics/sections/customer_support_analytics_filter_bar_section.dart' as section429;
import 'package:primecare_ui/src/screens/common/customer_support_analytics/sections/customer_support_analytics_header_section.dart' as section430;
import 'package:primecare_ui/src/screens/common/customer_support_analytics/sections/customer_support_analytics_metrics_summary_section.dart' as section431;
import 'package:primecare_ui/src/screens/common/customer_support_compliance/sections/customer_support_compliance_action_bar_section.dart' as section432;
import 'package:primecare_ui/src/screens/common/customer_support_compliance/sections/customer_support_compliance_content_summary_section.dart' as section433;
import 'package:primecare_ui/src/screens/common/customer_support_compliance/sections/customer_support_compliance_header_section.dart' as section434;
import 'package:primecare_ui/src/screens/common/customer_support_compliance/sections/customer_support_compliance_primary_content_section.dart' as section435;
import 'package:primecare_ui/src/screens/common/customer_support_workflow/sections/customer_support_workflow_action_bar_section.dart' as section436;
import 'package:primecare_ui/src/screens/common/customer_support_workflow/sections/customer_support_workflow_header_section.dart' as section437;
import 'package:primecare_ui/src/screens/common/customer_support_workflow/sections/customer_support_workflow_task_details_section.dart' as section438;
import 'package:primecare_ui/src/screens/common/customer_support_workflow/sections/customer_support_workflow_task_filters_section.dart' as section439;
import 'package:primecare_ui/src/screens/common/customer_support_workflow/sections/customer_support_workflow_task_list_section.dart' as section440;
import 'package:primecare_ui/src/screens/common/default_not_implemented/sections/default_not_implemented_action_bar_section.dart' as section441;
import 'package:primecare_ui/src/screens/common/default_not_implemented/sections/default_not_implemented_content_summary_section.dart' as section442;
import 'package:primecare_ui/src/screens/common/default_not_implemented/sections/default_not_implemented_header_section.dart' as section443;
import 'package:primecare_ui/src/screens/common/default_not_implemented/sections/default_not_implemented_primary_content_section.dart' as section444;
import 'package:primecare_ui/src/screens/common/documents/sections/documents_action_bar_section.dart' as section445;
import 'package:primecare_ui/src/screens/common/documents/sections/documents_content_summary_section.dart' as section446;
import 'package:primecare_ui/src/screens/common/documents/sections/documents_header_section.dart' as section447;
import 'package:primecare_ui/src/screens/common/documents/sections/documents_primary_content_section.dart' as section448;
import 'package:primecare_ui/src/screens/common/drift_findings/sections/drift_findings_action_bar_section.dart' as section449;
import 'package:primecare_ui/src/screens/common/drift_findings/sections/drift_findings_content_summary_section.dart' as section450;
import 'package:primecare_ui/src/screens/common/drift_findings/sections/drift_findings_header_section.dart' as section451;
import 'package:primecare_ui/src/screens/common/drift_findings/sections/drift_findings_primary_content_section.dart' as section452;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_dashboard_chart_overview_section.dart' as section453;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_dashboard_header_section.dart' as section454;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_dashboard_quick_actions_section.dart' as section455;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_dashboard_recent_activity_section.dart' as section456;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_dashboard_summary_cards_section.dart' as section457;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_screen_dashboard_chart_overview_section.dart' as section458;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_screen_dashboard_header_section.dart' as section459;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_screen_dashboard_quick_actions_section.dart' as section460;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_screen_dashboard_recent_activity_section.dart' as section461;
import 'package:primecare_ui/src/screens/common/dynamic_screen_dashboard/sections/dynamic_screen_dashboard_summary_cards_section.dart' as section462;
import 'package:primecare_ui/src/screens/common/dynamic_workflow/sections/dynamic_workflow_action_bar_section.dart' as section463;
import 'package:primecare_ui/src/screens/common/dynamic_workflow/sections/dynamic_workflow_header_section.dart' as section464;
import 'package:primecare_ui/src/screens/common/dynamic_workflow/sections/dynamic_workflow_task_details_section.dart' as section465;
import 'package:primecare_ui/src/screens/common/dynamic_workflow/sections/dynamic_workflow_task_filters_section.dart' as section466;
import 'package:primecare_ui/src/screens/common/dynamic_workflow/sections/dynamic_workflow_task_list_section.dart' as section467;
import 'package:primecare_ui/src/screens/common/emergency_contacts/sections/emergency_contacts_action_bar_section.dart' as section468;
import 'package:primecare_ui/src/screens/common/emergency_contacts/sections/emergency_contacts_content_summary_section.dart' as section469;
import 'package:primecare_ui/src/screens/common/emergency_contacts/sections/emergency_contacts_header_section.dart' as section470;
import 'package:primecare_ui/src/screens/common/emergency_contacts/sections/emergency_contacts_primary_content_section.dart' as section471;
import 'package:primecare_ui/src/screens/common/family_member_analytics/sections/family_member_analytics_chart_area_section.dart' as section472;
import 'package:primecare_ui/src/screens/common/family_member_analytics/sections/family_member_analytics_export_actions_section.dart' as section473;
import 'package:primecare_ui/src/screens/common/family_member_analytics/sections/family_member_analytics_filter_bar_section.dart' as section474;
import 'package:primecare_ui/src/screens/common/family_member_analytics/sections/family_member_analytics_header_section.dart' as section475;
import 'package:primecare_ui/src/screens/common/family_member_analytics/sections/family_member_analytics_metrics_summary_section.dart' as section476;
import 'package:primecare_ui/src/screens/common/family_member_compliance/sections/family_member_compliance_action_bar_section.dart' as section477;
import 'package:primecare_ui/src/screens/common/family_member_compliance/sections/family_member_compliance_content_summary_section.dart' as section478;
import 'package:primecare_ui/src/screens/common/family_member_compliance/sections/family_member_compliance_header_section.dart' as section479;
import 'package:primecare_ui/src/screens/common/family_member_compliance/sections/family_member_compliance_primary_content_section.dart' as section480;
import 'package:primecare_ui/src/screens/common/family_member_dashboard/sections/family_member_dashboard_chart_overview_section.dart' as section481;
import 'package:primecare_ui/src/screens/common/family_member_dashboard/sections/family_member_dashboard_header_section.dart' as section482;
import 'package:primecare_ui/src/screens/common/family_member_dashboard/sections/family_member_dashboard_quick_actions_section.dart' as section483;
import 'package:primecare_ui/src/screens/common/family_member_dashboard/sections/family_member_dashboard_recent_activity_section.dart' as section484;
import 'package:primecare_ui/src/screens/common/family_member_dashboard/sections/family_member_dashboard_summary_cards_section.dart' as section485;
import 'package:primecare_ui/src/screens/common/family_member_workflow/sections/family_member_workflow_action_bar_section.dart' as section486;
import 'package:primecare_ui/src/screens/common/family_member_workflow/sections/family_member_workflow_header_section.dart' as section487;
import 'package:primecare_ui/src/screens/common/family_member_workflow/sections/family_member_workflow_task_details_section.dart' as section488;
import 'package:primecare_ui/src/screens/common/family_member_workflow/sections/family_member_workflow_task_filters_section.dart' as section489;
import 'package:primecare_ui/src/screens/common/family_member_workflow/sections/family_member_workflow_task_list_section.dart' as section490;
import 'package:primecare_ui/src/screens/common/family_overview/sections/family_overview_action_bar_section.dart' as section491;
import 'package:primecare_ui/src/screens/common/family_overview/sections/family_overview_data_table_section.dart' as section492;
import 'package:primecare_ui/src/screens/common/family_overview/sections/family_overview_filter_bar_section.dart' as section493;
import 'package:primecare_ui/src/screens/common/family_overview/sections/family_overview_header_section.dart' as section494;
import 'package:primecare_ui/src/screens/common/family_overview/sections/family_overview_pagination_section.dart' as section495;
import 'package:primecare_ui/src/screens/common/file_verification_dashboard/sections/file_verification_dashboard_chart_overview_section.dart' as section496;
import 'package:primecare_ui/src/screens/common/file_verification_dashboard/sections/file_verification_dashboard_header_section.dart' as section497;
import 'package:primecare_ui/src/screens/common/file_verification_dashboard/sections/file_verification_dashboard_quick_actions_section.dart' as section498;
import 'package:primecare_ui/src/screens/common/file_verification_dashboard/sections/file_verification_dashboard_recent_activity_section.dart' as section499;
import 'package:primecare_ui/src/screens/common/file_verification_dashboard/sections/file_verification_dashboard_summary_cards_section.dart' as section500;
import 'package:primecare_ui/src/screens/common/franchise_analytics/sections/franchise_analytics_chart_area_section.dart' as section501;
import 'package:primecare_ui/src/screens/common/franchise_analytics/sections/franchise_analytics_export_actions_section.dart' as section502;
import 'package:primecare_ui/src/screens/common/franchise_analytics/sections/franchise_analytics_filter_bar_section.dart' as section503;
import 'package:primecare_ui/src/screens/common/franchise_analytics/sections/franchise_analytics_header_section.dart' as section504;
import 'package:primecare_ui/src/screens/common/franchise_analytics/sections/franchise_analytics_metrics_summary_section.dart' as section505;
import 'package:primecare_ui/src/screens/common/franchise_compliance/sections/franchise_compliance_action_bar_section.dart' as section506;
import 'package:primecare_ui/src/screens/common/franchise_compliance/sections/franchise_compliance_content_summary_section.dart' as section507;
import 'package:primecare_ui/src/screens/common/franchise_compliance/sections/franchise_compliance_header_section.dart' as section508;
import 'package:primecare_ui/src/screens/common/franchise_compliance/sections/franchise_compliance_primary_content_section.dart' as section509;
import 'package:primecare_ui/src/screens/common/franchise_dashboard/sections/franchise_dashboard_chart_overview_section.dart' as section510;
import 'package:primecare_ui/src/screens/common/franchise_dashboard/sections/franchise_dashboard_header_section.dart' as section511;
import 'package:primecare_ui/src/screens/common/franchise_dashboard/sections/franchise_dashboard_quick_actions_section.dart' as section512;
import 'package:primecare_ui/src/screens/common/franchise_dashboard/sections/franchise_dashboard_recent_activity_section.dart' as section513;
import 'package:primecare_ui/src/screens/common/franchise_dashboard/sections/franchise_dashboard_summary_cards_section.dart' as section514;
import 'package:primecare_ui/src/screens/common/franchise_workflow/sections/franchise_workflow_action_bar_section.dart' as section515;
import 'package:primecare_ui/src/screens/common/franchise_workflow/sections/franchise_workflow_header_section.dart' as section516;
import 'package:primecare_ui/src/screens/common/franchise_workflow/sections/franchise_workflow_task_details_section.dart' as section517;
import 'package:primecare_ui/src/screens/common/franchise_workflow/sections/franchise_workflow_task_filters_section.dart' as section518;
import 'package:primecare_ui/src/screens/common/franchise_workflow/sections/franchise_workflow_task_list_section.dart' as section519;
import 'package:primecare_ui/src/screens/common/governance_control_room/sections/governance_control_room_action_bar_section.dart' as section520;
import 'package:primecare_ui/src/screens/common/governance_control_room/sections/governance_control_room_content_summary_section.dart' as section521;
import 'package:primecare_ui/src/screens/common/governance_control_room/sections/governance_control_room_header_section.dart' as section522;
import 'package:primecare_ui/src/screens/common/governance_control_room/sections/governance_control_room_primary_content_section.dart' as section523;
import 'package:primecare_ui/src/screens/common/governance_operations4_k/sections/governance_operations4_k_action_bar_section.dart' as section524;
import 'package:primecare_ui/src/screens/common/governance_operations4_k/sections/governance_operations4_k_content_summary_section.dart' as section525;
import 'package:primecare_ui/src/screens/common/governance_operations4_k/sections/governance_operations4_k_header_section.dart' as section526;
import 'package:primecare_ui/src/screens/common/governance_operations4_k/sections/governance_operations4_k_primary_content_section.dart' as section527;
import 'package:primecare_ui/src/screens/common/governed/sections/governed_action_bar_section.dart' as section528;
import 'package:primecare_ui/src/screens/common/governed/sections/governed_content_summary_section.dart' as section529;
import 'package:primecare_ui/src/screens/common/governed/sections/governed_header_section.dart' as section530;
import 'package:primecare_ui/src/screens/common/governed/sections/governed_primary_content_section.dart' as section531;
import 'package:primecare_ui/src/screens/common/guest_analytics/sections/guest_analytics_chart_area_section.dart' as section532;
import 'package:primecare_ui/src/screens/common/guest_analytics/sections/guest_analytics_export_actions_section.dart' as section533;
import 'package:primecare_ui/src/screens/common/guest_analytics/sections/guest_analytics_filter_bar_section.dart' as section534;
import 'package:primecare_ui/src/screens/common/guest_analytics/sections/guest_analytics_header_section.dart' as section535;
import 'package:primecare_ui/src/screens/common/guest_analytics/sections/guest_analytics_metrics_summary_section.dart' as section536;
import 'package:primecare_ui/src/screens/common/guest_compliance/sections/guest_compliance_action_bar_section.dart' as section537;
import 'package:primecare_ui/src/screens/common/guest_compliance/sections/guest_compliance_content_summary_section.dart' as section538;
import 'package:primecare_ui/src/screens/common/guest_compliance/sections/guest_compliance_header_section.dart' as section539;
import 'package:primecare_ui/src/screens/common/guest_compliance/sections/guest_compliance_primary_content_section.dart' as section540;
import 'package:primecare_ui/src/screens/common/guest_workflow/sections/guest_workflow_action_bar_section.dart' as section541;
import 'package:primecare_ui/src/screens/common/guest_workflow/sections/guest_workflow_header_section.dart' as section542;
import 'package:primecare_ui/src/screens/common/guest_workflow/sections/guest_workflow_task_details_section.dart' as section543;
import 'package:primecare_ui/src/screens/common/guest_workflow/sections/guest_workflow_task_filters_section.dart' as section544;
import 'package:primecare_ui/src/screens/common/guest_workflow/sections/guest_workflow_task_list_section.dart' as section545;
import 'package:primecare_ui/src/screens/common/infrastructure_compliance/sections/infrastructure_compliance_action_bar_section.dart' as section546;
import 'package:primecare_ui/src/screens/common/infrastructure_compliance/sections/infrastructure_compliance_content_summary_section.dart' as section547;
import 'package:primecare_ui/src/screens/common/infrastructure_compliance/sections/infrastructure_compliance_header_section.dart' as section548;
import 'package:primecare_ui/src/screens/common/infrastructure_compliance/sections/infrastructure_compliance_primary_content_section.dart' as section549;
import 'package:primecare_ui/src/screens/common/infrastructure_dashboard/sections/infrastructure_dashboard_chart_overview_section.dart' as section550;
import 'package:primecare_ui/src/screens/common/infrastructure_dashboard/sections/infrastructure_dashboard_header_section.dart' as section551;
import 'package:primecare_ui/src/screens/common/infrastructure_dashboard/sections/infrastructure_dashboard_quick_actions_section.dart' as section552;
import 'package:primecare_ui/src/screens/common/infrastructure_dashboard/sections/infrastructure_dashboard_recent_activity_section.dart' as section553;
import 'package:primecare_ui/src/screens/common/infrastructure_dashboard/sections/infrastructure_dashboard_summary_cards_section.dart' as section554;
import 'package:primecare_ui/src/screens/common/intake_analytics/sections/intake_analytics_chart_area_section.dart' as section555;
import 'package:primecare_ui/src/screens/common/intake_analytics/sections/intake_analytics_export_actions_section.dart' as section556;
import 'package:primecare_ui/src/screens/common/intake_analytics/sections/intake_analytics_filter_bar_section.dart' as section557;
import 'package:primecare_ui/src/screens/common/intake_analytics/sections/intake_analytics_header_section.dart' as section558;
import 'package:primecare_ui/src/screens/common/intake_analytics/sections/intake_analytics_metrics_summary_section.dart' as section559;
import 'package:primecare_ui/src/screens/common/intake_compliance/sections/intake_compliance_action_bar_section.dart' as section560;
import 'package:primecare_ui/src/screens/common/intake_compliance/sections/intake_compliance_content_summary_section.dart' as section561;
import 'package:primecare_ui/src/screens/common/intake_compliance/sections/intake_compliance_header_section.dart' as section562;
import 'package:primecare_ui/src/screens/common/intake_compliance/sections/intake_compliance_primary_content_section.dart' as section563;
import 'package:primecare_ui/src/screens/common/intake_dashboard/sections/intake_dashboard_chart_overview_section.dart' as section564;
import 'package:primecare_ui/src/screens/common/intake_dashboard/sections/intake_dashboard_header_section.dart' as section565;
import 'package:primecare_ui/src/screens/common/intake_dashboard/sections/intake_dashboard_quick_actions_section.dart' as section566;
import 'package:primecare_ui/src/screens/common/intake_dashboard/sections/intake_dashboard_recent_activity_section.dart' as section567;
import 'package:primecare_ui/src/screens/common/intake_dashboard/sections/intake_dashboard_summary_cards_section.dart' as section568;
import 'package:primecare_ui/src/screens/common/intake_workflow/sections/intake_workflow_action_bar_section.dart' as section569;
import 'package:primecare_ui/src/screens/common/intake_workflow/sections/intake_workflow_header_section.dart' as section570;
import 'package:primecare_ui/src/screens/common/intake_workflow/sections/intake_workflow_task_details_section.dart' as section571;
import 'package:primecare_ui/src/screens/common/intake_workflow/sections/intake_workflow_task_filters_section.dart' as section572;
import 'package:primecare_ui/src/screens/common/intake_workflow/sections/intake_workflow_task_list_section.dart' as section573;
import 'package:primecare_ui/src/screens/common/office_analytics/sections/office_analytics_chart_area_section.dart' as section574;
import 'package:primecare_ui/src/screens/common/office_analytics/sections/office_analytics_export_actions_section.dart' as section575;
import 'package:primecare_ui/src/screens/common/office_analytics/sections/office_analytics_filter_bar_section.dart' as section576;
import 'package:primecare_ui/src/screens/common/office_analytics/sections/office_analytics_header_section.dart' as section577;
import 'package:primecare_ui/src/screens/common/office_analytics/sections/office_analytics_metrics_summary_section.dart' as section578;
import 'package:primecare_ui/src/screens/common/office_compliance/sections/office_compliance_action_bar_section.dart' as section579;
import 'package:primecare_ui/src/screens/common/office_compliance/sections/office_compliance_content_summary_section.dart' as section580;
import 'package:primecare_ui/src/screens/common/office_compliance/sections/office_compliance_header_section.dart' as section581;
import 'package:primecare_ui/src/screens/common/office_compliance/sections/office_compliance_primary_content_section.dart' as section582;
import 'package:primecare_ui/src/screens/common/office_dashboard/sections/office_dashboard_chart_overview_section.dart' as section583;
import 'package:primecare_ui/src/screens/common/office_dashboard/sections/office_dashboard_header_section.dart' as section584;
import 'package:primecare_ui/src/screens/common/office_dashboard/sections/office_dashboard_quick_actions_section.dart' as section585;
import 'package:primecare_ui/src/screens/common/office_dashboard/sections/office_dashboard_recent_activity_section.dart' as section586;
import 'package:primecare_ui/src/screens/common/office_dashboard/sections/office_dashboard_summary_cards_section.dart' as section587;
import 'package:primecare_ui/src/screens/common/office_workflow/sections/office_workflow_action_bar_section.dart' as section588;
import 'package:primecare_ui/src/screens/common/office_workflow/sections/office_workflow_header_section.dart' as section589;
import 'package:primecare_ui/src/screens/common/office_workflow/sections/office_workflow_task_details_section.dart' as section590;
import 'package:primecare_ui/src/screens/common/office_workflow/sections/office_workflow_task_filters_section.dart' as section591;
import 'package:primecare_ui/src/screens/common/office_workflow/sections/office_workflow_task_list_section.dart' as section592;
import 'package:primecare_ui/src/screens/common/patient_analytics/sections/patient_analytics_chart_area_section.dart' as section593;
import 'package:primecare_ui/src/screens/common/patient_analytics/sections/patient_analytics_export_actions_section.dart' as section594;
import 'package:primecare_ui/src/screens/common/patient_analytics/sections/patient_analytics_filter_bar_section.dart' as section595;
import 'package:primecare_ui/src/screens/common/patient_analytics/sections/patient_analytics_header_section.dart' as section596;
import 'package:primecare_ui/src/screens/common/patient_analytics/sections/patient_analytics_metrics_summary_section.dart' as section597;
import 'package:primecare_ui/src/screens/common/patient_appointments/sections/patient_appointments_action_bar_section.dart' as section598;
import 'package:primecare_ui/src/screens/common/patient_appointments/sections/patient_appointments_appointment_details_section.dart' as section599;

void main() {
  test('all muted section consumers compile, part 1', () {
    final types = <Type>[
      section0.AdminScreenHealthActionBarSection,
      section1.AdminScreenHealthContentSummarySection,
      section2.AdminScreenHealthHeaderSection,
      section3.AdminScreenHealthPrimaryContentSection,
      section4.AdjustmentNotesActionBarSection,
      section5.AdjustmentNotesClientContextSection,
      section6.AdjustmentNotesHeaderSection,
      section7.AdjustmentNotesNotesFormSection,
      section8.AdjustmentNotesNotesHistorySection,
      section9.ChiropracticAssessmentActionBarSection,
      section10.ChiropracticAssessmentContentSummarySection,
      section11.ChiropracticAssessmentHeaderSection,
      section12.ChiropracticAssessmentPrimaryContentSection,
      section13.ChiropracticProgressTrackingActionBarSection,
      section14.ChiropracticProgressTrackingContentSummarySection,
      section15.ChiropracticProgressTrackingHeaderSection,
      section16.ChiropracticProgressTrackingPrimaryContentSection,
      section17.ChiropractorAppointmentsActionBarSection,
      section18.ChiropractorAppointmentsAppointmentDetailsSection,
      section19.ChiropractorAppointmentsCalendarControlsSection,
      section20.ChiropractorAppointmentsHeaderSection,
      section21.ChiropractorAppointmentsScheduleListSection,
      section22.ChiropractorAssessmentActionBarSection,
      section23.ChiropractorAssessmentContentSummarySection,
      section24.ChiropractorAssessmentHeaderSection,
      section25.ChiropractorAssessmentPrimaryContentSection,
      section26.ChiropractorBillingLinkActionBarSection,
      section27.ChiropractorBillingLinkContentSummarySection,
      section28.ChiropractorBillingLinkHeaderSection,
      section29.ChiropractorBillingLinkPrimaryContentSection,
      section30.ChiropractorClientIntakeActionBarSection,
      section31.ChiropractorClientIntakeContentSummarySection,
      section32.ChiropractorClientIntakeHeaderSection,
      section33.ChiropractorClientIntakePrimaryContentSection,
      section34.ChiropractorCommandCenterActionBarSection,
      section35.ChiropractorCommandCenterContentSummarySection,
      section36.ChiropractorCommandCenterHeaderSection,
      section37.ChiropractorCommandCenterPrimaryContentSection,
      section38.ChiropractorExercisePlanActionBarSection,
      section39.ChiropractorExercisePlanContentSummarySection,
      section40.ChiropractorExercisePlanHeaderSection,
      section41.ChiropractorExercisePlanPrimaryContentSection,
      section42.ChiropractorReportsChartAreaSection,
      section43.ChiropractorReportsExportActionsSection,
      section44.ChiropractorReportsFilterBarSection,
      section45.ChiropractorReportsHeaderSection,
      section46.ChiropractorReportsMetricsSummarySection,
      section47.ChiropractorTreatmentNotesActionBarSection,
      section48.ChiropractorTreatmentNotesClientContextSection,
      section49.ChiropractorTreatmentNotesHeaderSection,
      section50.ChiropractorTreatmentNotesNotesFormSection,
      section51.ChiropractorTreatmentNotesNotesHistorySection,
      section52.ClientProgressActionBarSection,
      section53.ClientProgressContentSummarySection,
      section54.ClientProgressHeaderSection,
      section55.ClientProgressPrimaryContentSection,
      section56.HomeCarePlanActionBarSection,
      section57.HomeCarePlanContentSummarySection,
      section58.HomeCarePlanHeaderSection,
      section59.HomeCarePlanPrimaryContentSection,
      section60.MassageAssessmentActionBarSection,
      section61.MassageAssessmentContentSummarySection,
      section62.MassageAssessmentHeaderSection,
      section63.MassageAssessmentPrimaryContentSection,
      section64.PhysiotherapistAppointmentsActionBarSection,
      section65.PhysiotherapistAppointmentsAppointmentDetailsSection,
      section66.PhysiotherapistAppointmentsCalendarControlsSection,
      section67.PhysiotherapistAppointmentsHeaderSection,
      section68.PhysiotherapistAppointmentsScheduleListSection,
      section69.PhysiotherapistAssessmentActionBarSection,
      section70.PhysiotherapistAssessmentContentSummarySection,
      section71.PhysiotherapistAssessmentHeaderSection,
      section72.PhysiotherapistAssessmentPrimaryContentSection,
      section73.PhysiotherapistBillingLinkActionBarSection,
      section74.PhysiotherapistBillingLinkContentSummarySection,
      section75.PhysiotherapistBillingLinkHeaderSection,
      section76.PhysiotherapistBillingLinkPrimaryContentSection,
      section77.PhysiotherapistClientIntakeActionBarSection,
      section78.PhysiotherapistClientIntakeContentSummarySection,
      section79.PhysiotherapistClientIntakeHeaderSection,
      section80.PhysiotherapistClientIntakePrimaryContentSection,
      section81.PhysiotherapistCommandCenterActionBarSection,
      section82.PhysiotherapistCommandCenterContentSummarySection,
      section83.PhysiotherapistCommandCenterHeaderSection,
      section84.PhysiotherapistCommandCenterPrimaryContentSection,
      section85.PhysiotherapistExercisePlanActionBarSection,
      section86.PhysiotherapistExercisePlanContentSummarySection,
      section87.PhysiotherapistExercisePlanHeaderSection,
      section88.PhysiotherapistExercisePlanPrimaryContentSection,
      section89.PhysiotherapistReportsChartAreaSection,
      section90.PhysiotherapistReportsExportActionsSection,
      section91.PhysiotherapistReportsFilterBarSection,
      section92.PhysiotherapistReportsHeaderSection,
      section93.PhysiotherapistReportsMetricsSummarySection,
      section94.PhysiotherapistTreatmentNotesActionBarSection,
      section95.PhysiotherapistTreatmentNotesClientContextSection,
      section96.PhysiotherapistTreatmentNotesHeaderSection,
      section97.PhysiotherapistTreatmentNotesNotesFormSection,
      section98.PhysiotherapistTreatmentNotesNotesHistorySection,
      section99.RmtAnalyticsChartAreaSection,
      section100.RmtAnalyticsExportActionsSection,
      section101.RmtAnalyticsFilterBarSection,
      section102.RmtAnalyticsHeaderSection,
      section103.RmtAnalyticsMetricsSummarySection,
      section104.RmtAppointmentsActionBarSection,
      section105.RmtAppointmentsAppointmentDetailsSection,
      section106.RmtAppointmentsCalendarControlsSection,
      section107.RmtAppointmentsHeaderSection,
      section108.RmtAppointmentsScheduleListSection,
      section109.RmtAssessmentActionBarSection,
      section110.RmtAssessmentContentSummarySection,
      section111.RmtAssessmentHeaderSection,
      section112.RmtAssessmentPrimaryContentSection,
      section113.RmtBillingLinkActionBarSection,
      section114.RmtBillingLinkContentSummarySection,
      section115.RmtBillingLinkHeaderSection,
      section116.RmtBillingLinkPrimaryContentSection,
      section117.RmtClientIntakeActionBarSection,
      section118.RmtClientIntakeContentSummarySection,
      section119.RmtClientIntakeHeaderSection,
      section120.RmtClientIntakePrimaryContentSection,
      section121.RmtCommandCenterActionBarSection,
      section122.RmtCommandCenterContentSummarySection,
      section123.RmtCommandCenterHeaderSection,
      section124.RmtCommandCenterPrimaryContentSection,
      section125.RmtComplianceActionBarSection,
      section126.RmtComplianceContentSummarySection,
      section127.RmtComplianceHeaderSection,
      section128.RmtCompliancePrimaryContentSection,
      section129.RmtExercisePlanActionBarSection,
      section130.RmtExercisePlanContentSummarySection,
      section131.RmtExercisePlanHeaderSection,
      section132.RmtExercisePlanPrimaryContentSection,
      section133.RmtReportsChartAreaSection,
      section134.RmtReportsExportActionsSection,
      section135.RmtReportsFilterBarSection,
      section136.RmtReportsHeaderSection,
      section137.RmtReportsMetricsSummarySection,
      section138.RmtTreatmentNotesActionBarSection,
      section139.RmtTreatmentNotesClientContextSection,
      section140.RmtTreatmentNotesHeaderSection,
      section141.RmtTreatmentNotesNotesFormSection,
      section142.RmtTreatmentNotesNotesHistorySection,
      section143.RmtWorkflowActionBarSection,
      section144.RmtWorkflowHeaderSection,
      section145.RmtWorkflowTaskDetailsSection,
      section146.RmtWorkflowTaskFiltersSection,
      section147.RmtWorkflowTaskListSection,
      section148.TherapistAnalyticsChartAreaSection,
      section149.TherapistAnalyticsExportActionsSection,
      section150.TherapistAnalyticsFilterBarSection,
      section151.TherapistAnalyticsHeaderSection,
      section152.TherapistAnalyticsMetricsSummarySection,
      section153.TherapistWorkflowActionBarSection,
      section154.TherapistWorkflowHeaderSection,
      section155.TherapistWorkflowTaskDetailsSection,
      section156.TherapistWorkflowTaskFiltersSection,
      section157.TherapistWorkflowTaskListSection,
      section158.XrayReviewActionBarSection,
      section159.XrayReviewDataTableSection,
      section160.XrayReviewFilterBarSection,
      section161.XrayReviewHeaderSection,
      section162.XrayReviewPaginationSection,
      section163.ClinicalAnalyticsChartAreaSection,
      section164.ClinicalAnalyticsExportActionsSection,
      section165.ClinicalAnalyticsFilterBarSection,
      section166.ClinicalAnalyticsHeaderSection,
      section167.ClinicalAnalyticsMetricsSummarySection,
      section168.ClinicalComplianceActionBarSection,
      section169.ClinicalComplianceContentSummarySection,
      section170.ClinicalComplianceHeaderSection,
      section171.ClinicalCompliancePrimaryContentSection,
      section172.ClinicalDirectorApprovalsActionBarSection,
      section173.ClinicalDirectorApprovalsContentSummarySection,
      section174.ClinicalDirectorApprovalsHeaderSection,
      section175.ClinicalDirectorApprovalsPrimaryContentSection,
      section176.ClinicalDirectorComplianceActionBarSection,
      section177.ClinicalDirectorComplianceContentSummarySection,
      section178.ClinicalDirectorComplianceHeaderSection,
      section179.ClinicalDirectorCompliancePrimaryContentSection,
      section180.ClinicalDirectorIncidentReviewActionBarSection,
      section181.ClinicalDirectorIncidentReviewDataTableSection,
      section182.ClinicalDirectorIncidentReviewFilterBarSection,
      section183.ClinicalDirectorIncidentReviewHeaderSection,
      section184.ClinicalDirectorIncidentReviewPaginationSection,
      section185.ClinicalDirectorPerformanceActionBarSection,
      section186.ClinicalDirectorPerformanceFormBodySection,
      section187.ClinicalDirectorPerformanceHeaderSection,
      section188.ClinicalDirectorPerformanceValidationMessagesSection,
      section189.ClinicalDirectorReportsChartAreaSection,
      section190.ClinicalDirectorReportsExportActionsSection,
      section191.ClinicalDirectorReportsFilterBarSection,
      section192.ClinicalDirectorReportsHeaderSection,
      section193.ClinicalDirectorReportsMetricsSummarySection,
      section194.ClinicalDirectorStaffQualityActionBarSection,
      section195.ClinicalDirectorStaffQualityContentSummarySection,
      section196.ClinicalDirectorStaffQualityHeaderSection,
      section197.ClinicalDirectorStaffQualityPrimaryContentSection,
      section198.ClinicalOperations4KActionBarSection,
      section199.ClinicalOperations4KContentSummarySection,
      section200.ClinicalOperations4KHeaderSection,
      section201.ClinicalOperations4KPrimaryContentSection,
      section202.ClinicalQualityActionBarSection,
      section203.ClinicalQualityContentSummarySection,
      section204.ClinicalQualityHeaderSection,
      section205.ClinicalQualityPrimaryContentSection,
      section206.ClinicalWorkflowActionBarSection,
      section207.ClinicalWorkflowHeaderSection,
      section208.ClinicalWorkflowTaskDetailsSection,
      section209.ClinicalWorkflowTaskFiltersSection,
      section210.ClinicalWorkflowTaskListSection,
      section211.ComplianceReviewActionBarSection,
      section212.ComplianceReviewDataTableSection,
      section213.ComplianceReviewFilterBarSection,
      section214.ComplianceReviewHeaderSection,
      section215.ComplianceReviewPaginationSection,
      section216.ExercisePrescriptionActionBarSection,
      section217.ExercisePrescriptionContentSummarySection,
      section218.ExercisePrescriptionHeaderSection,
      section219.ExercisePrescriptionPrimaryContentSection,
      section220.HswAdlLoggerActionBarSection,
      section221.HswAdlLoggerDataTableSection,
      section222.HswAdlLoggerFilterBarSection,
      section223.HswAdlLoggerHeaderSection,
      section224.HswAdlLoggerPaginationSection,
      section225.HswCarePlansActionBarSection,
      section226.HswCarePlansContentSummarySection,
      section227.HswCarePlansHeaderSection,
      section228.HswCarePlansPrimaryContentSection,
      section229.HswIncidentReportsChartAreaSection,
      section230.HswIncidentReportsExportActionsSection,
      section231.HswIncidentReportsFilterBarSection,
      section232.HswIncidentReportsHeaderSection,
      section233.HswIncidentReportsMetricsSummarySection,
      section234.HswScheduleActionBarSection,
      section235.HswScheduleAppointmentDetailsSection,
      section236.HswScheduleCalendarControlsSection,
      section237.HswScheduleHeaderSection,
      section238.HswScheduleScheduleListSection,
      section239.IncidentOversightActionBarSection,
      section240.IncidentOversightContentSummarySection,
      section241.IncidentOversightHeaderSection,
      section242.IncidentOversightPrimaryContentSection,
      section243.MedicationActionBarSection,
      section244.MedicationContentSummarySection,
      section245.MedicationHeaderSection,
      section246.MedicationPrimaryContentSection,
      section247.NursingTaskActionBarSection,
      section248.NursingTaskHeaderSection,
      section249.NursingTaskTaskDetailsSection,
      section250.NursingTaskTaskFiltersSection,
      section251.NursingTaskTaskListSection,
      section252.PatientObservationActionBarSection,
      section253.PatientObservationContentSummarySection,
      section254.PatientObservationHeaderSection,
      section255.PatientObservationPrimaryContentSection,
      section256.PediatricAnalyticsChartAreaSection,
      section257.PediatricAnalyticsExportActionsSection,
      section258.PediatricAnalyticsFilterBarSection,
      section259.PediatricAnalyticsHeaderSection,
      section260.PediatricAnalyticsMetricsSummarySection,
      section261.PediatricWorkflowActionBarSection,
      section262.PediatricWorkflowHeaderSection,
      section263.PediatricWorkflowTaskDetailsSection,
      section264.PediatricWorkflowTaskFiltersSection,
      section265.PediatricWorkflowTaskListSection,
      section266.PhysicianAnalyticsChartAreaSection,
      section267.PhysicianAnalyticsExportActionsSection,
      section268.PhysicianAnalyticsFilterBarSection,
      section269.PhysicianAnalyticsHeaderSection,
      section270.PhysicianAnalyticsMetricsSummarySection,
      section271.PhysicianWorkflowActionBarSection,
      section272.PhysicianWorkflowHeaderSection,
      section273.PhysicianWorkflowTaskDetailsSection,
      section274.PhysicianWorkflowTaskFiltersSection,
      section275.PhysicianWorkflowTaskListSection,
      section276.ProgressTrackingActionBarSection,
      section277.ProgressTrackingContentSummarySection,
      section278.ProgressTrackingHeaderSection,
      section279.ProgressTrackingPrimaryContentSection,
      section280.StaffPerformanceActionBarSection,
      section281.StaffPerformanceFormBodySection,
      section282.StaffPerformanceHeaderSection,
      section283.StaffPerformanceValidationMessagesSection,
      section284.TreatmentPlanActionBarSection,
      section285.TreatmentPlanContentSummarySection,
      section286.TreatmentPlanHeaderSection,
      section287.TreatmentPlanPrimaryContentSection,
      section288.VitalsTrackingActionBarSection,
      section289.VitalsTrackingContentSummarySection,
      section290.VitalsTrackingHeaderSection,
      section291.VitalsTrackingPrimaryContentSection,
      section292.AgentDispatchActionBarSection,
      section293.AgentDispatchContentSummarySection,
      section294.AgentDispatchHeaderSection,
      section295.AgentDispatchPrimaryContentSection,
      section296.ApiHealthDashboardChartOverviewSection,
      section297.ApiHealthDashboardHeaderSection,
      section298.ApiHealthDashboardQuickActionsSection,
      section299.ApiHealthDashboardRecentActivitySection,
      section300.ApiHealthDashboardSummaryCardsSection,
      section301.AppointmentActionBarSection,
      section302.AppointmentAppointmentDetailsSection,
      section303.AppointmentCalendarControlsSection,
      section304.AppointmentHeaderSection,
      section305.AppointmentScheduleListSection,
      section306.ArchitecturePlanningAnalyticsChartAreaSection,
      section307.ArchitecturePlanningAnalyticsExportActionsSection,
      section308.ArchitecturePlanningAnalyticsFilterBarSection,
      section309.ArchitecturePlanningAnalyticsHeaderSection,
      section310.ArchitecturePlanningAnalyticsMetricsSummarySection,
      section311.ArchitecturePlanningComplianceActionBarSection,
      section312.ArchitecturePlanningComplianceContentSummarySection,
      section313.ArchitecturePlanningComplianceHeaderSection,
      section314.ArchitecturePlanningCompliancePrimaryContentSection,
      section315.ArchitecturePlanningWorkflowActionBarSection,
      section316.ArchitecturePlanningWorkflowHeaderSection,
      section317.ArchitecturePlanningWorkflowTaskDetailsSection,
      section318.ArchitecturePlanningWorkflowTaskFiltersSection,
      section319.ArchitecturePlanningWorkflowTaskListSection,
      section320.AuditActionBarSection,
      section321.AuditContentSummarySection,
      section322.AuditHeaderSection,
      section323.AuditPrimaryContentSection,
      section324.ScreenAuditActionBarSection,
      section325.ScreenAuditContentSummarySection,
      section326.ScreenAuditHeaderSection,
      section327.ScreenAuditPrimaryContentSection,
      section328.BillingActionBarSection,
      section329.BillingContentSummarySection,
      section330.BillingHeaderSection,
      section331.BillingPrimaryContentSection,
      section332.BillingOverviewActionBarSection,
      section333.BillingOverviewDataTableSection,
      section334.BillingOverviewFilterBarSection,
      section335.BillingOverviewHeaderSection,
      section336.BillingOverviewPaginationSection,
      section337.BusinessDevelopmentAnalyticsChartAreaSection,
      section338.BusinessDevelopmentAnalyticsExportActionsSection,
      section339.BusinessDevelopmentAnalyticsFilterBarSection,
      section340.BusinessDevelopmentAnalyticsHeaderSection,
      section341.BusinessDevelopmentAnalyticsMetricsSummarySection,
      section342.BusinessDevelopmentComplianceActionBarSection,
      section343.BusinessDevelopmentComplianceContentSummarySection,
      section344.BusinessDevelopmentComplianceHeaderSection,
      section345.BusinessDevelopmentCompliancePrimaryContentSection,
      section346.BusinessDevelopmentDashboardChartOverviewSection,
      section347.BusinessDevelopmentDashboardHeaderSection,
      section348.BusinessDevelopmentDashboardQuickActionsSection,
      section349.BusinessDevelopmentDashboardRecentActivitySection,
      section350.BusinessDevelopmentDashboardSummaryCardsSection,
      section351.BusinessDevelopmentWorkflowActionBarSection,
      section352.BusinessDevelopmentWorkflowHeaderSection,
      section353.BusinessDevelopmentWorkflowTaskDetailsSection,
      section354.BusinessDevelopmentWorkflowTaskFiltersSection,
      section355.BusinessDevelopmentWorkflowTaskListSection,
      section356.CarePlanActionBarSection,
      section357.CarePlanContentSummarySection,
      section358.CarePlanHeaderSection,
      section359.CarePlanPrimaryContentSection,
      section360.CareUpdatesActionBarSection,
      section361.CareUpdatesContentSummarySection,
      section362.CareUpdatesHeaderSection,
      section363.CareUpdatesPrimaryContentSection,
      section364.CaregiverDashboardChartOverviewSection,
      section365.CaregiverDashboardHeaderSection,
      section366.CaregiverDashboardQuickActionsSection,
      section367.CaregiverDashboardRecentActivitySection,
      section368.CaregiverDashboardSummaryCardsSection,
      section369.ChiropractorAnalyticsChartAreaSection,
      section370.ChiropractorAnalyticsExportActionsSection,
      section371.ChiropractorAnalyticsFilterBarSection,
      section372.ChiropractorAnalyticsHeaderSection,
      section373.ChiropractorAnalyticsMetricsSummarySection,
      section374.ChiropractorComplianceActionBarSection,
      section375.ChiropractorComplianceContentSummarySection,
      section376.ChiropractorComplianceHeaderSection,
      section377.ChiropractorCompliancePrimaryContentSection,
      section378.ChiropractorDashboardChartOverviewSection,
      section379.ChiropractorDashboardHeaderSection,
      section380.ChiropractorDashboardQuickActionsSection,
      section381.ChiropractorDashboardRecentActivitySection,
      section382.ChiropractorDashboardSummaryCardsSection,
      section383.ChiropractorWorkflowActionBarSection,
      section384.ChiropractorWorkflowHeaderSection,
      section385.ChiropractorWorkflowTaskDetailsSection,
      section386.ChiropractorWorkflowTaskFiltersSection,
      section387.ChiropractorWorkflowTaskListSection,
      section388.ClinicAnalyticsChartAreaSection,
      section389.ClinicAnalyticsExportActionsSection,
      section390.ClinicAnalyticsFilterBarSection,
      section391.ClinicAnalyticsHeaderSection,
      section392.ClinicAnalyticsMetricsSummarySection,
      section393.ClinicComplianceActionBarSection,
      section394.ClinicComplianceContentSummarySection,
      section395.ClinicComplianceHeaderSection,
      section396.ClinicCompliancePrimaryContentSection,
      section397.ClinicDashboardChartOverviewSection,
      section398.ClinicDashboardHeaderSection,
      section399.ClinicDashboardQuickActionsSection,
      section400.ClinicDashboardRecentActivitySection,
      section401.ClinicDashboardSummaryCardsSection,
      section402.ClinicWorkflowActionBarSection,
      section403.ClinicWorkflowHeaderSection,
      section404.ClinicWorkflowTaskDetailsSection,
      section405.ClinicWorkflowTaskFiltersSection,
      section406.ClinicWorkflowTaskListSection,
      section407.CourseArchitectAnalyticsChartAreaSection,
      section408.CourseArchitectAnalyticsExportActionsSection,
      section409.CourseArchitectAnalyticsFilterBarSection,
      section410.CourseArchitectAnalyticsHeaderSection,
      section411.CourseArchitectAnalyticsMetricsSummarySection,
      section412.CourseArchitectComplianceActionBarSection,
      section413.CourseArchitectComplianceDataTableSection,
      section414.CourseArchitectComplianceFilterBarSection,
      section415.CourseArchitectComplianceHeaderSection,
      section416.CourseArchitectCompliancePaginationSection,
      section417.CourseArchitectDashboardChartOverviewSection,
      section418.CourseArchitectDashboardHeaderSection,
      section419.CourseArchitectDashboardQuickActionsSection,
      section420.CourseArchitectDashboardRecentActivitySection,
      section421.CourseArchitectDashboardSummaryCardsSection,
      section422.CourseArchitectWorkflowActionBarSection,
      section423.CourseArchitectWorkflowHeaderSection,
      section424.CourseArchitectWorkflowTaskDetailsSection,
      section425.CourseArchitectWorkflowTaskFiltersSection,
      section426.CourseArchitectWorkflowTaskListSection,
      section427.CustomerSupportAnalyticsChartAreaSection,
      section428.CustomerSupportAnalyticsExportActionsSection,
      section429.CustomerSupportAnalyticsFilterBarSection,
      section430.CustomerSupportAnalyticsHeaderSection,
      section431.CustomerSupportAnalyticsMetricsSummarySection,
      section432.CustomerSupportComplianceActionBarSection,
      section433.CustomerSupportComplianceContentSummarySection,
      section434.CustomerSupportComplianceHeaderSection,
      section435.CustomerSupportCompliancePrimaryContentSection,
      section436.CustomerSupportWorkflowActionBarSection,
      section437.CustomerSupportWorkflowHeaderSection,
      section438.CustomerSupportWorkflowTaskDetailsSection,
      section439.CustomerSupportWorkflowTaskFiltersSection,
      section440.CustomerSupportWorkflowTaskListSection,
      section441.DefaultNotImplementedActionBarSection,
      section442.DefaultNotImplementedContentSummarySection,
      section443.DefaultNotImplementedHeaderSection,
      section444.DefaultNotImplementedPrimaryContentSection,
      section445.DocumentsActionBarSection,
      section446.DocumentsContentSummarySection,
      section447.DocumentsHeaderSection,
      section448.DocumentsPrimaryContentSection,
      section449.DriftFindingsActionBarSection,
      section450.DriftFindingsContentSummarySection,
      section451.DriftFindingsHeaderSection,
      section452.DriftFindingsPrimaryContentSection,
      section453.DynamicDashboardChartOverviewSection,
      section454.DynamicDashboardHeaderSection,
      section455.DynamicDashboardQuickActionsSection,
      section456.DynamicDashboardRecentActivitySection,
      section457.DynamicDashboardSummaryCardsSection,
      section458.DynamicScreenDashboardChartOverviewSection,
      section459.DynamicScreenDashboardHeaderSection,
      section460.DynamicScreenDashboardQuickActionsSection,
      section461.DynamicScreenDashboardRecentActivitySection,
      section462.DynamicScreenDashboardSummaryCardsSection,
      section463.DynamicWorkflowActionBarSection,
      section464.DynamicWorkflowHeaderSection,
      section465.DynamicWorkflowTaskDetailsSection,
      section466.DynamicWorkflowTaskFiltersSection,
      section467.DynamicWorkflowTaskListSection,
      section468.EmergencyContactsActionBarSection,
      section469.EmergencyContactsContentSummarySection,
      section470.EmergencyContactsHeaderSection,
      section471.EmergencyContactsPrimaryContentSection,
      section472.FamilyMemberAnalyticsChartAreaSection,
      section473.FamilyMemberAnalyticsExportActionsSection,
      section474.FamilyMemberAnalyticsFilterBarSection,
      section475.FamilyMemberAnalyticsHeaderSection,
      section476.FamilyMemberAnalyticsMetricsSummarySection,
      section477.FamilyMemberComplianceActionBarSection,
      section478.FamilyMemberComplianceContentSummarySection,
      section479.FamilyMemberComplianceHeaderSection,
      section480.FamilyMemberCompliancePrimaryContentSection,
      section481.FamilyMemberDashboardChartOverviewSection,
      section482.FamilyMemberDashboardHeaderSection,
      section483.FamilyMemberDashboardQuickActionsSection,
      section484.FamilyMemberDashboardRecentActivitySection,
      section485.FamilyMemberDashboardSummaryCardsSection,
      section486.FamilyMemberWorkflowActionBarSection,
      section487.FamilyMemberWorkflowHeaderSection,
      section488.FamilyMemberWorkflowTaskDetailsSection,
      section489.FamilyMemberWorkflowTaskFiltersSection,
      section490.FamilyMemberWorkflowTaskListSection,
      section491.FamilyOverviewActionBarSection,
      section492.FamilyOverviewDataTableSection,
      section493.FamilyOverviewFilterBarSection,
      section494.FamilyOverviewHeaderSection,
      section495.FamilyOverviewPaginationSection,
      section496.FileVerificationDashboardChartOverviewSection,
      section497.FileVerificationDashboardHeaderSection,
      section498.FileVerificationDashboardQuickActionsSection,
      section499.FileVerificationDashboardRecentActivitySection,
      section500.FileVerificationDashboardSummaryCardsSection,
      section501.FranchiseAnalyticsChartAreaSection,
      section502.FranchiseAnalyticsExportActionsSection,
      section503.FranchiseAnalyticsFilterBarSection,
      section504.FranchiseAnalyticsHeaderSection,
      section505.FranchiseAnalyticsMetricsSummarySection,
      section506.FranchiseComplianceActionBarSection,
      section507.FranchiseComplianceContentSummarySection,
      section508.FranchiseComplianceHeaderSection,
      section509.FranchiseCompliancePrimaryContentSection,
      section510.FranchiseDashboardChartOverviewSection,
      section511.FranchiseDashboardHeaderSection,
      section512.FranchiseDashboardQuickActionsSection,
      section513.FranchiseDashboardRecentActivitySection,
      section514.FranchiseDashboardSummaryCardsSection,
      section515.FranchiseWorkflowActionBarSection,
      section516.FranchiseWorkflowHeaderSection,
      section517.FranchiseWorkflowTaskDetailsSection,
      section518.FranchiseWorkflowTaskFiltersSection,
      section519.FranchiseWorkflowTaskListSection,
      section520.GovernanceControlRoomActionBarSection,
      section521.GovernanceControlRoomContentSummarySection,
      section522.GovernanceControlRoomHeaderSection,
      section523.GovernanceControlRoomPrimaryContentSection,
      section524.GovernanceOperations4KActionBarSection,
      section525.GovernanceOperations4KContentSummarySection,
      section526.GovernanceOperations4KHeaderSection,
      section527.GovernanceOperations4KPrimaryContentSection,
      section528.GovernedActionBarSection,
      section529.GovernedContentSummarySection,
      section530.GovernedHeaderSection,
      section531.GovernedPrimaryContentSection,
      section532.GuestAnalyticsChartAreaSection,
      section533.GuestAnalyticsExportActionsSection,
      section534.GuestAnalyticsFilterBarSection,
      section535.GuestAnalyticsHeaderSection,
      section536.GuestAnalyticsMetricsSummarySection,
      section537.GuestComplianceActionBarSection,
      section538.GuestComplianceContentSummarySection,
      section539.GuestComplianceHeaderSection,
      section540.GuestCompliancePrimaryContentSection,
      section541.GuestWorkflowActionBarSection,
      section542.GuestWorkflowHeaderSection,
      section543.GuestWorkflowTaskDetailsSection,
      section544.GuestWorkflowTaskFiltersSection,
      section545.GuestWorkflowTaskListSection,
      section546.InfrastructureComplianceActionBarSection,
      section547.InfrastructureComplianceContentSummarySection,
      section548.InfrastructureComplianceHeaderSection,
      section549.InfrastructureCompliancePrimaryContentSection,
      section550.InfrastructureDashboardChartOverviewSection,
      section551.InfrastructureDashboardHeaderSection,
      section552.InfrastructureDashboardQuickActionsSection,
      section553.InfrastructureDashboardRecentActivitySection,
      section554.InfrastructureDashboardSummaryCardsSection,
      section555.IntakeAnalyticsChartAreaSection,
      section556.IntakeAnalyticsExportActionsSection,
      section557.IntakeAnalyticsFilterBarSection,
      section558.IntakeAnalyticsHeaderSection,
      section559.IntakeAnalyticsMetricsSummarySection,
      section560.IntakeComplianceActionBarSection,
      section561.IntakeComplianceContentSummarySection,
      section562.IntakeComplianceHeaderSection,
      section563.IntakeCompliancePrimaryContentSection,
      section564.IntakeDashboardChartOverviewSection,
      section565.IntakeDashboardHeaderSection,
      section566.IntakeDashboardQuickActionsSection,
      section567.IntakeDashboardRecentActivitySection,
      section568.IntakeDashboardSummaryCardsSection,
      section569.IntakeWorkflowActionBarSection,
      section570.IntakeWorkflowHeaderSection,
      section571.IntakeWorkflowTaskDetailsSection,
      section572.IntakeWorkflowTaskFiltersSection,
      section573.IntakeWorkflowTaskListSection,
      section574.OfficeAnalyticsChartAreaSection,
      section575.OfficeAnalyticsExportActionsSection,
      section576.OfficeAnalyticsFilterBarSection,
      section577.OfficeAnalyticsHeaderSection,
      section578.OfficeAnalyticsMetricsSummarySection,
      section579.OfficeComplianceActionBarSection,
      section580.OfficeComplianceContentSummarySection,
      section581.OfficeComplianceHeaderSection,
      section582.OfficeCompliancePrimaryContentSection,
      section583.OfficeDashboardChartOverviewSection,
      section584.OfficeDashboardHeaderSection,
      section585.OfficeDashboardQuickActionsSection,
      section586.OfficeDashboardRecentActivitySection,
      section587.OfficeDashboardSummaryCardsSection,
      section588.OfficeWorkflowActionBarSection,
      section589.OfficeWorkflowHeaderSection,
      section590.OfficeWorkflowTaskDetailsSection,
      section591.OfficeWorkflowTaskFiltersSection,
      section592.OfficeWorkflowTaskListSection,
      section593.PatientAnalyticsChartAreaSection,
      section594.PatientAnalyticsExportActionsSection,
      section595.PatientAnalyticsFilterBarSection,
      section596.PatientAnalyticsHeaderSection,
      section597.PatientAnalyticsMetricsSummarySection,
      section598.PatientAppointmentsActionBarSection,
      section599.PatientAppointmentsAppointmentDetailsSection,
    ];
    expect(types, hasLength(600));
  });
}
