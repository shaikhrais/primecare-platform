// Compile smoke coverage for migrated shared controls.
// Compilation does not establish screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_client/ai_chatbot/sections/ai_chatbot_action_bar_section.dart' as migrated0;
import 'package:primecare_client/ai_chatbot/sections/ai_chatbot_content_summary_section.dart' as migrated1;
import 'package:primecare_client/ai_chatbot/sections/ai_chatbot_header_section.dart' as migrated2;
import 'package:primecare_client/ai_chatbot/sections/ai_chatbot_primary_content_section.dart' as migrated3;
import 'package:primecare_client/ai_chatbot_screen.dart' as migrated4;
import 'package:primecare_client/features/family/screens/family_billing/sections/family_billing_action_bar_section.dart' as migrated5;
import 'package:primecare_client/features/family/screens/family_billing/sections/family_billing_content_summary_section.dart' as migrated6;
import 'package:primecare_client/features/family/screens/family_billing/sections/family_billing_header_section.dart' as migrated7;
import 'package:primecare_client/features/family/screens/family_billing/sections/family_billing_primary_content_section.dart' as migrated8;
import 'package:primecare_client/features/family/screens/family_billing_screen.dart' as migrated9;
import 'package:primecare_client/features/family/screens/family_care_updates/sections/family_care_updates_action_bar_section.dart' as migrated10;
import 'package:primecare_client/features/family/screens/family_care_updates/sections/family_care_updates_content_summary_section.dart' as migrated11;
import 'package:primecare_client/features/family/screens/family_care_updates/sections/family_care_updates_header_section.dart' as migrated12;
import 'package:primecare_client/features/family/screens/family_care_updates/sections/family_care_updates_primary_content_section.dart' as migrated13;
import 'package:primecare_client/features/family/screens/family_care_updates_screen.dart' as migrated14;
import 'package:primecare_client/features/family/screens/family_dashboard/sections/family_dashboard_chart_overview_section.dart' as migrated15;
import 'package:primecare_client/features/family/screens/family_dashboard/sections/family_dashboard_header_section.dart' as migrated16;
import 'package:primecare_client/features/family/screens/family_dashboard/sections/family_dashboard_quick_actions_section.dart' as migrated17;
import 'package:primecare_client/features/family/screens/family_dashboard/sections/family_dashboard_recent_activity_section.dart' as migrated18;
import 'package:primecare_client/features/family/screens/family_dashboard/sections/family_dashboard_summary_cards_section.dart' as migrated19;
import 'package:primecare_client/features/family/screens/family_dashboard_screen.dart' as migrated20;
import 'package:primecare_client/features/family/screens/family_emergency_contacts/sections/family_emergency_contacts_action_bar_section.dart' as migrated21;
import 'package:primecare_client/features/family/screens/family_emergency_contacts/sections/family_emergency_contacts_content_summary_section.dart' as migrated22;
import 'package:primecare_client/features/family/screens/family_emergency_contacts/sections/family_emergency_contacts_header_section.dart' as migrated23;
import 'package:primecare_client/features/family/screens/family_emergency_contacts/sections/family_emergency_contacts_primary_content_section.dart' as migrated24;
import 'package:primecare_client/features/family/screens/family_emergency_contacts_screen.dart' as migrated25;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule/sections/family_loved_one_schedule_action_bar_section.dart' as migrated26;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule/sections/family_loved_one_schedule_appointment_details_section.dart' as migrated27;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule/sections/family_loved_one_schedule_calendar_controls_section.dart' as migrated28;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule/sections/family_loved_one_schedule_header_section.dart' as migrated29;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule/sections/family_loved_one_schedule_schedule_list_section.dart' as migrated30;
import 'package:primecare_client/features/family/screens/family_loved_one_schedule_screen.dart' as migrated31;
import 'package:primecare_client/features/family/screens/family_profile/sections/family_profile_action_bar_section.dart' as migrated32;
import 'package:primecare_client/features/family/screens/family_profile/sections/family_profile_details_form_section.dart' as migrated33;
import 'package:primecare_client/features/family/screens/family_profile/sections/family_profile_header_section.dart' as migrated34;
import 'package:primecare_client/features/family/screens/family_profile/sections/family_profile_identity_summary_section.dart' as migrated35;
import 'package:primecare_client/features/family/screens/family_profile/sections/family_profile_preferences_or_documents_section.dart' as migrated36;
import 'package:primecare_client/features/family/screens/family_profile_screen.dart' as migrated37;
import 'package:primecare_client/features/family/screens/sections/family_billing_action_bar_section.dart' as migrated38;
import 'package:primecare_client/features/family/screens/sections/family_billing_content_summary_section.dart' as migrated39;
import 'package:primecare_client/features/family/screens/sections/family_billing_header_section.dart' as migrated40;
import 'package:primecare_client/features/family/screens/sections/family_billing_primary_content_section.dart' as migrated41;
import 'package:primecare_client/features/family/screens/sections/family_care_updates_action_bar_section.dart' as migrated42;
import 'package:primecare_client/features/family/screens/sections/family_care_updates_content_summary_section.dart' as migrated43;
import 'package:primecare_client/features/family/screens/sections/family_care_updates_header_section.dart' as migrated44;
import 'package:primecare_client/features/family/screens/sections/family_care_updates_primary_content_section.dart' as migrated45;
import 'package:primecare_client/features/family/screens/sections/family_dashboard_chart_overview_section.dart' as migrated46;
import 'package:primecare_client/features/family/screens/sections/family_dashboard_header_section.dart' as migrated47;
import 'package:primecare_client/features/family/screens/sections/family_dashboard_quick_actions_section.dart' as migrated48;
import 'package:primecare_client/features/family/screens/sections/family_dashboard_recent_activity_section.dart' as migrated49;
import 'package:primecare_client/features/family/screens/sections/family_dashboard_summary_cards_section.dart' as migrated50;
import 'package:primecare_client/features/family/screens/sections/family_emergency_contacts_action_bar_section.dart' as migrated51;
import 'package:primecare_client/features/family/screens/sections/family_emergency_contacts_content_summary_section.dart' as migrated52;
import 'package:primecare_client/features/family/screens/sections/family_emergency_contacts_header_section.dart' as migrated53;
import 'package:primecare_client/features/family/screens/sections/family_emergency_contacts_primary_content_section.dart' as migrated54;
import 'package:primecare_client/features/family/screens/sections/family_loved_one_schedule_action_bar_section.dart' as migrated55;
import 'package:primecare_client/features/family/screens/sections/family_loved_one_schedule_appointment_details_section.dart' as migrated56;
import 'package:primecare_client/features/family/screens/sections/family_loved_one_schedule_calendar_controls_section.dart' as migrated57;
import 'package:primecare_client/features/family/screens/sections/family_loved_one_schedule_header_section.dart' as migrated58;
import 'package:primecare_client/features/family/screens/sections/family_loved_one_schedule_schedule_list_section.dart' as migrated59;
import 'package:primecare_client/features/family/screens/sections/family_profile_action_bar_section.dart' as migrated60;
import 'package:primecare_client/features/family/screens/sections/family_profile_details_form_section.dart' as migrated61;
import 'package:primecare_client/features/family/screens/sections/family_profile_header_section.dart' as migrated62;
import 'package:primecare_client/features/family/screens/sections/family_profile_identity_summary_section.dart' as migrated63;
import 'package:primecare_client/features/family/screens/sections/family_profile_preferences_or_documents_section.dart' as migrated64;
import 'package:primecare_client/features/generated_screens/client_book_appointment/sections/client_book_appointment_action_bar_section.dart' as migrated65;
import 'package:primecare_client/features/generated_screens/client_book_appointment/sections/client_book_appointment_appointment_details_section.dart' as migrated66;
import 'package:primecare_client/features/generated_screens/client_book_appointment/sections/client_book_appointment_calendar_controls_section.dart' as migrated67;
import 'package:primecare_client/features/generated_screens/client_book_appointment/sections/client_book_appointment_header_section.dart' as migrated68;
import 'package:primecare_client/features/generated_screens/client_book_appointment/sections/client_book_appointment_schedule_list_section.dart' as migrated69;
import 'package:primecare_client/features/generated_screens/client_book_appointment_screen.dart' as migrated70;
import 'package:primecare_client/features/generated_screens/client_care_team/sections/client_care_team_action_bar_section.dart' as migrated71;
import 'package:primecare_client/features/generated_screens/client_care_team/sections/client_care_team_content_summary_section.dart' as migrated72;
import 'package:primecare_client/features/generated_screens/client_care_team/sections/client_care_team_header_section.dart' as migrated73;
import 'package:primecare_client/features/generated_screens/client_care_team/sections/client_care_team_primary_content_section.dart' as migrated74;
import 'package:primecare_client/features/generated_screens/client_care_team_screen.dart' as migrated75;
import 'package:primecare_client/features/generated_screens/client_dashboard/sections/client_dashboard_chart_overview_section.dart' as migrated76;
import 'package:primecare_client/features/generated_screens/client_dashboard/sections/client_dashboard_header_section.dart' as migrated77;
import 'package:primecare_client/features/generated_screens/client_dashboard/sections/client_dashboard_quick_actions_section.dart' as migrated78;
import 'package:primecare_client/features/generated_screens/client_dashboard/sections/client_dashboard_recent_activity_section.dart' as migrated79;
import 'package:primecare_client/features/generated_screens/client_dashboard/sections/client_dashboard_summary_cards_section.dart' as migrated80;
import 'package:primecare_client/features/generated_screens/client_dashboard_screen.dart' as migrated81;
import 'package:primecare_client/features/generated_screens/client_my_appointments/sections/client_my_appointments_action_bar_section.dart' as migrated82;
import 'package:primecare_client/features/generated_screens/client_my_appointments/sections/client_my_appointments_appointment_details_section.dart' as migrated83;
import 'package:primecare_client/features/generated_screens/client_my_appointments/sections/client_my_appointments_calendar_controls_section.dart' as migrated84;
import 'package:primecare_client/features/generated_screens/client_my_appointments/sections/client_my_appointments_header_section.dart' as migrated85;
import 'package:primecare_client/features/generated_screens/client_my_appointments/sections/client_my_appointments_schedule_list_section.dart' as migrated86;
import 'package:primecare_client/features/generated_screens/client_my_appointments_screen.dart' as migrated87;
import 'package:primecare_client/features/generated_screens/client_payments/sections/client_payments_action_bar_section.dart' as migrated88;
import 'package:primecare_client/features/generated_screens/client_payments/sections/client_payments_content_summary_section.dart' as migrated89;
import 'package:primecare_client/features/generated_screens/client_payments/sections/client_payments_header_section.dart' as migrated90;
import 'package:primecare_client/features/generated_screens/client_payments/sections/client_payments_primary_content_section.dart' as migrated91;
import 'package:primecare_client/features/generated_screens/client_payments_screen.dart' as migrated92;
import 'package:primecare_client/features/generated_screens/client_profile/sections/client_profile_action_bar_section.dart' as migrated93;
import 'package:primecare_client/features/generated_screens/client_profile/sections/client_profile_details_form_section.dart' as migrated94;
import 'package:primecare_client/features/generated_screens/client_profile/sections/client_profile_header_section.dart' as migrated95;
import 'package:primecare_client/features/generated_screens/client_profile/sections/client_profile_identity_summary_section.dart' as migrated96;
import 'package:primecare_client/features/generated_screens/client_profile/sections/client_profile_preferences_or_documents_section.dart' as migrated97;
import 'package:primecare_client/features/generated_screens/client_profile_screen.dart' as migrated98;
import 'package:primecare_client/features/generated_screens/client_treatment_history/sections/client_treatment_history_action_bar_section.dart' as migrated99;
import 'package:primecare_client/features/generated_screens/client_treatment_history/sections/client_treatment_history_data_table_section.dart' as migrated100;
import 'package:primecare_client/features/generated_screens/client_treatment_history/sections/client_treatment_history_filter_bar_section.dart' as migrated101;
import 'package:primecare_client/features/generated_screens/client_treatment_history/sections/client_treatment_history_header_section.dart' as migrated102;
import 'package:primecare_client/features/generated_screens/client_treatment_history/sections/client_treatment_history_pagination_section.dart' as migrated103;
import 'package:primecare_client/features/generated_screens/client_treatment_history_screen.dart' as migrated104;
import 'package:primecare_client/features/generated_screens/family_member_billing/sections/family_member_billing_action_bar_section.dart' as migrated105;
import 'package:primecare_client/features/generated_screens/family_member_billing/sections/family_member_billing_content_summary_section.dart' as migrated106;
import 'package:primecare_client/features/generated_screens/family_member_billing/sections/family_member_billing_header_section.dart' as migrated107;
import 'package:primecare_client/features/generated_screens/family_member_billing/sections/family_member_billing_primary_content_section.dart' as migrated108;
import 'package:primecare_client/features/generated_screens/family_member_billing_screen.dart' as migrated109;
import 'package:primecare_client/features/generated_screens/family_member_care_updates/sections/family_member_care_updates_action_bar_section.dart' as migrated110;
import 'package:primecare_client/features/generated_screens/family_member_care_updates/sections/family_member_care_updates_content_summary_section.dart' as migrated111;
import 'package:primecare_client/features/generated_screens/family_member_care_updates/sections/family_member_care_updates_header_section.dart' as migrated112;
import 'package:primecare_client/features/generated_screens/family_member_care_updates/sections/family_member_care_updates_primary_content_section.dart' as migrated113;
import 'package:primecare_client/features/generated_screens/family_member_care_updates_screen.dart' as migrated114;
import 'package:primecare_client/features/generated_screens/family_member_dashboard_screen.dart' as migrated115;
import 'package:primecare_client/features/generated_screens/family_member_emergency_contacts/sections/family_member_emergency_contacts_action_bar_section.dart' as migrated116;
import 'package:primecare_client/features/generated_screens/family_member_emergency_contacts/sections/family_member_emergency_contacts_content_summary_section.dart' as migrated117;
import 'package:primecare_client/features/generated_screens/family_member_emergency_contacts/sections/family_member_emergency_contacts_header_section.dart' as migrated118;
import 'package:primecare_client/features/generated_screens/family_member_emergency_contacts/sections/family_member_emergency_contacts_primary_content_section.dart' as migrated119;
import 'package:primecare_client/features/generated_screens/family_member_emergency_contacts_screen.dart' as migrated120;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule/sections/family_member_loved_one_schedule_action_bar_section.dart' as migrated121;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule/sections/family_member_loved_one_schedule_appointment_details_section.dart' as migrated122;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule/sections/family_member_loved_one_schedule_calendar_controls_section.dart' as migrated123;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule/sections/family_member_loved_one_schedule_header_section.dart' as migrated124;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule/sections/family_member_loved_one_schedule_schedule_list_section.dart' as migrated125;
import 'package:primecare_client/features/generated_screens/family_member_loved_one_schedule_screen.dart' as migrated126;
import 'package:primecare_client/features/generated_screens/family_member_profile/sections/family_member_profile_action_bar_section.dart' as migrated127;
import 'package:primecare_client/features/generated_screens/family_member_profile/sections/family_member_profile_details_form_section.dart' as migrated128;
import 'package:primecare_client/features/generated_screens/family_member_profile/sections/family_member_profile_header_section.dart' as migrated129;
import 'package:primecare_client/features/generated_screens/family_member_profile/sections/family_member_profile_identity_summary_section.dart' as migrated130;
import 'package:primecare_client/features/generated_screens/family_member_profile/sections/family_member_profile_preferences_or_documents_section.dart' as migrated131;
import 'package:primecare_client/features/generated_screens/family_member_profile_screen.dart' as migrated132;
import 'package:primecare_client/features/generated_screens/sections/client_book_appointment_action_bar_section.dart' as migrated133;
import 'package:primecare_client/features/generated_screens/sections/client_book_appointment_appointment_details_section.dart' as migrated134;
import 'package:primecare_client/features/generated_screens/sections/client_book_appointment_calendar_controls_section.dart' as migrated135;
import 'package:primecare_client/features/generated_screens/sections/client_book_appointment_header_section.dart' as migrated136;
import 'package:primecare_client/features/generated_screens/sections/client_book_appointment_schedule_list_section.dart' as migrated137;
import 'package:primecare_client/features/generated_screens/sections/client_care_team_action_bar_section.dart' as migrated138;
import 'package:primecare_client/features/generated_screens/sections/client_care_team_content_summary_section.dart' as migrated139;
import 'package:primecare_client/features/generated_screens/sections/client_care_team_header_section.dart' as migrated140;
import 'package:primecare_client/features/generated_screens/sections/client_care_team_primary_content_section.dart' as migrated141;
import 'package:primecare_client/features/generated_screens/sections/client_dashboard_chart_overview_section.dart' as migrated142;
import 'package:primecare_client/features/generated_screens/sections/client_dashboard_header_section.dart' as migrated143;
import 'package:primecare_client/features/generated_screens/sections/client_dashboard_quick_actions_section.dart' as migrated144;
import 'package:primecare_client/features/generated_screens/sections/client_dashboard_recent_activity_section.dart' as migrated145;
import 'package:primecare_client/features/generated_screens/sections/client_dashboard_summary_cards_section.dart' as migrated146;
import 'package:primecare_client/features/generated_screens/sections/client_my_appointments_action_bar_section.dart' as migrated147;
import 'package:primecare_client/features/generated_screens/sections/client_my_appointments_appointment_details_section.dart' as migrated148;
import 'package:primecare_client/features/generated_screens/sections/client_my_appointments_calendar_controls_section.dart' as migrated149;
import 'package:primecare_client/features/generated_screens/sections/client_my_appointments_header_section.dart' as migrated150;
import 'package:primecare_client/features/generated_screens/sections/client_my_appointments_schedule_list_section.dart' as migrated151;
import 'package:primecare_client/features/generated_screens/sections/client_payments_action_bar_section.dart' as migrated152;
import 'package:primecare_client/features/generated_screens/sections/client_payments_content_summary_section.dart' as migrated153;
import 'package:primecare_client/features/generated_screens/sections/client_payments_header_section.dart' as migrated154;
import 'package:primecare_client/features/generated_screens/sections/client_payments_primary_content_section.dart' as migrated155;
import 'package:primecare_client/features/generated_screens/sections/client_profile_action_bar_section.dart' as migrated156;
import 'package:primecare_client/features/generated_screens/sections/client_profile_details_form_section.dart' as migrated157;
import 'package:primecare_client/features/generated_screens/sections/client_profile_header_section.dart' as migrated158;
import 'package:primecare_client/features/generated_screens/sections/client_profile_identity_summary_section.dart' as migrated159;
import 'package:primecare_client/features/generated_screens/sections/client_profile_preferences_or_documents_section.dart' as migrated160;
import 'package:primecare_client/features/generated_screens/sections/client_treatment_history_action_bar_section.dart' as migrated161;
import 'package:primecare_client/features/generated_screens/sections/client_treatment_history_data_table_section.dart' as migrated162;
import 'package:primecare_client/features/generated_screens/sections/client_treatment_history_filter_bar_section.dart' as migrated163;
import 'package:primecare_client/features/generated_screens/sections/client_treatment_history_header_section.dart' as migrated164;
import 'package:primecare_client/features/generated_screens/sections/client_treatment_history_pagination_section.dart' as migrated165;
import 'package:primecare_client/features/generated_screens/sections/family_member_billing_action_bar_section.dart' as migrated166;
import 'package:primecare_client/features/generated_screens/sections/family_member_billing_content_summary_section.dart' as migrated167;
import 'package:primecare_client/features/generated_screens/sections/family_member_billing_header_section.dart' as migrated168;
import 'package:primecare_client/features/generated_screens/sections/family_member_billing_primary_content_section.dart' as migrated169;
import 'package:primecare_client/features/generated_screens/sections/family_member_care_updates_action_bar_section.dart' as migrated170;
import 'package:primecare_client/features/generated_screens/sections/family_member_care_updates_content_summary_section.dart' as migrated171;
import 'package:primecare_client/features/generated_screens/sections/family_member_care_updates_header_section.dart' as migrated172;
import 'package:primecare_client/features/generated_screens/sections/family_member_care_updates_primary_content_section.dart' as migrated173;
import 'package:primecare_client/features/generated_screens/sections/family_member_emergency_contacts_action_bar_section.dart' as migrated174;
import 'package:primecare_client/features/generated_screens/sections/family_member_emergency_contacts_content_summary_section.dart' as migrated175;
import 'package:primecare_client/features/generated_screens/sections/family_member_emergency_contacts_header_section.dart' as migrated176;
import 'package:primecare_client/features/generated_screens/sections/family_member_emergency_contacts_primary_content_section.dart' as migrated177;
import 'package:primecare_client/features/generated_screens/sections/family_member_loved_one_schedule_action_bar_section.dart' as migrated178;
import 'package:primecare_client/features/generated_screens/sections/family_member_loved_one_schedule_appointment_details_section.dart' as migrated179;
import 'package:primecare_client/features/generated_screens/sections/family_member_loved_one_schedule_calendar_controls_section.dart' as migrated180;
import 'package:primecare_client/features/generated_screens/sections/family_member_loved_one_schedule_header_section.dart' as migrated181;
import 'package:primecare_client/features/generated_screens/sections/family_member_loved_one_schedule_schedule_list_section.dart' as migrated182;
import 'package:primecare_client/features/generated_screens/sections/family_member_profile_action_bar_section.dart' as migrated183;
import 'package:primecare_client/features/generated_screens/sections/family_member_profile_details_form_section.dart' as migrated184;
import 'package:primecare_client/features/generated_screens/sections/family_member_profile_header_section.dart' as migrated185;
import 'package:primecare_client/features/generated_screens/sections/family_member_profile_identity_summary_section.dart' as migrated186;
import 'package:primecare_client/features/generated_screens/sections/family_member_profile_preferences_or_documents_section.dart' as migrated187;
import 'package:primecare_client/features/generated_screens/unknown_dashboard_screen.dart' as migrated188;
import 'package:primecare_client/features/patient/screens/patient_book_appointment/sections/patient_book_appointment_action_bar_section.dart' as migrated189;
import 'package:primecare_client/features/patient/screens/patient_book_appointment/sections/patient_book_appointment_appointment_details_section.dart' as migrated190;
import 'package:primecare_client/features/patient/screens/patient_book_appointment/sections/patient_book_appointment_calendar_controls_section.dart' as migrated191;
import 'package:primecare_client/features/patient/screens/patient_book_appointment/sections/patient_book_appointment_header_section.dart' as migrated192;
import 'package:primecare_client/features/patient/screens/patient_book_appointment/sections/patient_book_appointment_schedule_list_section.dart' as migrated193;
import 'package:primecare_client/features/patient/screens/patient_book_appointment_screen.dart' as migrated194;
import 'package:primecare_client/features/patient/screens/patient_care_team/sections/patient_care_team_action_bar_section.dart' as migrated195;
import 'package:primecare_client/features/patient/screens/patient_care_team/sections/patient_care_team_content_summary_section.dart' as migrated196;
import 'package:primecare_client/features/patient/screens/patient_care_team/sections/patient_care_team_header_section.dart' as migrated197;
import 'package:primecare_client/features/patient/screens/patient_care_team/sections/patient_care_team_primary_content_section.dart' as migrated198;
import 'package:primecare_client/features/patient/screens/patient_care_team_screen.dart' as migrated199;
import 'package:primecare_client/features/patient/screens/patient_dashboard_screen.dart' as migrated200;
import 'package:primecare_client/features/patient/screens/patient_my_appointments/sections/patient_my_appointments_action_bar_section.dart' as migrated201;
import 'package:primecare_client/features/patient/screens/patient_my_appointments/sections/patient_my_appointments_appointment_details_section.dart' as migrated202;
import 'package:primecare_client/features/patient/screens/patient_my_appointments/sections/patient_my_appointments_calendar_controls_section.dart' as migrated203;
import 'package:primecare_client/features/patient/screens/patient_my_appointments/sections/patient_my_appointments_header_section.dart' as migrated204;
import 'package:primecare_client/features/patient/screens/patient_my_appointments/sections/patient_my_appointments_schedule_list_section.dart' as migrated205;
import 'package:primecare_client/features/patient/screens/patient_my_appointments_screen.dart' as migrated206;
import 'package:primecare_client/features/patient/screens/patient_payments/sections/patient_payments_action_bar_section.dart' as migrated207;
import 'package:primecare_client/features/patient/screens/patient_payments/sections/patient_payments_content_summary_section.dart' as migrated208;
import 'package:primecare_client/features/patient/screens/patient_payments/sections/patient_payments_header_section.dart' as migrated209;
import 'package:primecare_client/features/patient/screens/patient_payments/sections/patient_payments_primary_content_section.dart' as migrated210;
import 'package:primecare_client/features/patient/screens/patient_payments_screen.dart' as migrated211;
import 'package:primecare_client/features/patient/screens/patient_profile_screen.dart' as migrated212;
import 'package:primecare_client/features/patient/screens/patient_treatment_history/sections/patient_treatment_history_action_bar_section.dart' as migrated213;
import 'package:primecare_client/features/patient/screens/patient_treatment_history/sections/patient_treatment_history_data_table_section.dart' as migrated214;
import 'package:primecare_client/features/patient/screens/patient_treatment_history/sections/patient_treatment_history_filter_bar_section.dart' as migrated215;
import 'package:primecare_client/features/patient/screens/patient_treatment_history/sections/patient_treatment_history_header_section.dart' as migrated216;
import 'package:primecare_client/features/patient/screens/patient_treatment_history/sections/patient_treatment_history_pagination_section.dart' as migrated217;
import 'package:primecare_client/features/patient/screens/patient_treatment_history_screen.dart' as migrated218;
import 'package:primecare_client/features/patient/screens/sections/patient_book_appointment_action_bar_section.dart' as migrated219;
import 'package:primecare_client/features/patient/screens/sections/patient_book_appointment_appointment_details_section.dart' as migrated220;
import 'package:primecare_client/features/patient/screens/sections/patient_book_appointment_calendar_controls_section.dart' as migrated221;
import 'package:primecare_client/features/patient/screens/sections/patient_book_appointment_header_section.dart' as migrated222;
import 'package:primecare_client/features/patient/screens/sections/patient_book_appointment_schedule_list_section.dart' as migrated223;
import 'package:primecare_client/features/patient/screens/sections/patient_care_team_action_bar_section.dart' as migrated224;
import 'package:primecare_client/features/patient/screens/sections/patient_care_team_content_summary_section.dart' as migrated225;
import 'package:primecare_client/features/patient/screens/sections/patient_care_team_header_section.dart' as migrated226;
import 'package:primecare_client/features/patient/screens/sections/patient_care_team_primary_content_section.dart' as migrated227;
import 'package:primecare_client/features/patient/screens/sections/patient_my_appointments_action_bar_section.dart' as migrated228;
import 'package:primecare_client/features/patient/screens/sections/patient_my_appointments_appointment_details_section.dart' as migrated229;
import 'package:primecare_client/features/patient/screens/sections/patient_my_appointments_calendar_controls_section.dart' as migrated230;
import 'package:primecare_client/features/patient/screens/sections/patient_my_appointments_header_section.dart' as migrated231;
import 'package:primecare_client/features/patient/screens/sections/patient_my_appointments_schedule_list_section.dart' as migrated232;
import 'package:primecare_client/features/patient/screens/sections/patient_payments_action_bar_section.dart' as migrated233;
import 'package:primecare_client/features/patient/screens/sections/patient_payments_content_summary_section.dart' as migrated234;
import 'package:primecare_client/features/patient/screens/sections/patient_payments_header_section.dart' as migrated235;
import 'package:primecare_client/features/patient/screens/sections/patient_payments_primary_content_section.dart' as migrated236;
import 'package:primecare_client/features/patient/screens/sections/patient_treatment_history_action_bar_section.dart' as migrated237;
import 'package:primecare_client/features/patient/screens/sections/patient_treatment_history_data_table_section.dart' as migrated238;
import 'package:primecare_client/features/patient/screens/sections/patient_treatment_history_filter_bar_section.dart' as migrated239;
import 'package:primecare_client/features/patient/screens/sections/patient_treatment_history_header_section.dart' as migrated240;
import 'package:primecare_client/features/patient/screens/sections/patient_treatment_history_pagination_section.dart' as migrated241;
import 'package:primecare_client/sections/ai_chatbot_action_bar_section.dart' as migrated242;
import 'package:primecare_client/sections/ai_chatbot_content_summary_section.dart' as migrated243;
import 'package:primecare_client/sections/ai_chatbot_header_section.dart' as migrated244;
import 'package:primecare_client/sections/ai_chatbot_primary_content_section.dart' as migrated245;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
      migrated0.AiChatbotActionBarSection,
      migrated1.AiChatbotContentSummarySection,
      migrated2.AiChatbotHeaderSection,
      migrated3.AiChatbotPrimaryContentSection,
      migrated4.AiChatbotScreenState,
      migrated5.FamilyBillingActionBarSection,
      migrated6.FamilyBillingContentSummarySection,
      migrated7.FamilyBillingHeaderSection,
      migrated8.FamilyBillingPrimaryContentSection,
      migrated9.FamilyBillingScreenState,
      migrated10.FamilyCareUpdatesActionBarSection,
      migrated11.FamilyCareUpdatesContentSummarySection,
      migrated12.FamilyCareUpdatesHeaderSection,
      migrated13.FamilyCareUpdatesPrimaryContentSection,
      migrated14.FamilyCareUpdatesScreenState,
      migrated15.FamilyDashboardChartOverviewSection,
      migrated16.FamilyDashboardHeaderSection,
      migrated17.FamilyDashboardQuickActionsSection,
      migrated18.FamilyDashboardRecentActivitySection,
      migrated19.FamilyDashboardSummaryCardsSection,
      migrated20.FamilyDashboardScreenState,
      migrated21.FamilyEmergencyContactsActionBarSection,
      migrated22.FamilyEmergencyContactsContentSummarySection,
      migrated23.FamilyEmergencyContactsHeaderSection,
      migrated24.FamilyEmergencyContactsPrimaryContentSection,
      migrated25.FamilyEmergencyContactsScreenState,
      migrated26.FamilyLovedOneScheduleActionBarSection,
      migrated27.FamilyLovedOneScheduleAppointmentDetailsSection,
      migrated28.FamilyLovedOneScheduleCalendarControlsSection,
      migrated29.FamilyLovedOneScheduleHeaderSection,
      migrated30.FamilyLovedOneScheduleScheduleListSection,
      migrated31.FamilyLovedOneScheduleScreenState,
      migrated32.FamilyProfileActionBarSection,
      migrated33.FamilyProfileDetailsFormSection,
      migrated34.FamilyProfileHeaderSection,
      migrated35.FamilyProfileIdentitySummarySection,
      migrated36.FamilyProfilePreferencesOrDocumentsSection,
      migrated37.FamilyProfileScreenState,
      migrated38.FamilyBillingActionBarSection,
      migrated39.FamilyBillingContentSummarySection,
      migrated40.FamilyBillingHeaderSection,
      migrated41.FamilyBillingPrimaryContentSection,
      migrated42.FamilyCareUpdatesActionBarSection,
      migrated43.FamilyCareUpdatesContentSummarySection,
      migrated44.FamilyCareUpdatesHeaderSection,
      migrated45.FamilyCareUpdatesPrimaryContentSection,
      migrated46.FamilyDashboardChartOverviewSection,
      migrated47.FamilyDashboardHeaderSection,
      migrated48.FamilyDashboardQuickActionsSection,
      migrated49.FamilyDashboardRecentActivitySection,
      migrated50.FamilyDashboardSummaryCardsSection,
      migrated51.FamilyEmergencyContactsActionBarSection,
      migrated52.FamilyEmergencyContactsContentSummarySection,
      migrated53.FamilyEmergencyContactsHeaderSection,
      migrated54.FamilyEmergencyContactsPrimaryContentSection,
      migrated55.FamilyLovedOneScheduleActionBarSection,
      migrated56.FamilyLovedOneScheduleAppointmentDetailsSection,
      migrated57.FamilyLovedOneScheduleCalendarControlsSection,
      migrated58.FamilyLovedOneScheduleHeaderSection,
      migrated59.FamilyLovedOneScheduleScheduleListSection,
      migrated60.FamilyProfileActionBarSection,
      migrated61.FamilyProfileDetailsFormSection,
      migrated62.FamilyProfileHeaderSection,
      migrated63.FamilyProfileIdentitySummarySection,
      migrated64.FamilyProfilePreferencesOrDocumentsSection,
      migrated65.ClientBookAppointmentActionBarSection,
      migrated66.ClientBookAppointmentAppointmentDetailsSection,
      migrated67.ClientBookAppointmentCalendarControlsSection,
      migrated68.ClientBookAppointmentHeaderSection,
      migrated69.ClientBookAppointmentScheduleListSection,
      migrated70.ClientBookAppointmentScreenState,
      migrated71.ClientCareTeamActionBarSection,
      migrated72.ClientCareTeamContentSummarySection,
      migrated73.ClientCareTeamHeaderSection,
      migrated74.ClientCareTeamPrimaryContentSection,
      migrated75.ClientCareTeamScreenState,
      migrated76.ClientDashboardChartOverviewSection,
      migrated77.ClientDashboardHeaderSection,
      migrated78.ClientDashboardQuickActionsSection,
      migrated79.ClientDashboardRecentActivitySection,
      migrated80.ClientDashboardSummaryCardsSection,
      migrated81.ClientDashboardScreenState,
      migrated82.ClientMyAppointmentsActionBarSection,
      migrated83.ClientMyAppointmentsAppointmentDetailsSection,
      migrated84.ClientMyAppointmentsCalendarControlsSection,
      migrated85.ClientMyAppointmentsHeaderSection,
      migrated86.ClientMyAppointmentsScheduleListSection,
      migrated87.ClientMyAppointmentsScreenState,
      migrated88.ClientPaymentsActionBarSection,
      migrated89.ClientPaymentsContentSummarySection,
      migrated90.ClientPaymentsHeaderSection,
      migrated91.ClientPaymentsPrimaryContentSection,
      migrated92.ClientPaymentsScreenState,
      migrated93.ClientProfileActionBarSection,
      migrated94.ClientProfileDetailsFormSection,
      migrated95.ClientProfileHeaderSection,
      migrated96.ClientProfileIdentitySummarySection,
      migrated97.ClientProfilePreferencesOrDocumentsSection,
      migrated98.ClientProfileScreenState,
      migrated99.ClientTreatmentHistoryActionBarSection,
      migrated100.ClientTreatmentHistoryDataTableSection,
      migrated101.ClientTreatmentHistoryFilterBarSection,
      migrated102.ClientTreatmentHistoryHeaderSection,
      migrated103.ClientTreatmentHistoryPaginationSection,
      migrated104.ClientTreatmentHistoryScreenState,
      migrated105.FamilyMemberBillingActionBarSection,
      migrated106.FamilyMemberBillingContentSummarySection,
      migrated107.FamilyMemberBillingHeaderSection,
      migrated108.FamilyMemberBillingPrimaryContentSection,
      migrated109.FamilyMemberBillingScreenState,
      migrated110.FamilyMemberCareUpdatesActionBarSection,
      migrated111.FamilyMemberCareUpdatesContentSummarySection,
      migrated112.FamilyMemberCareUpdatesHeaderSection,
      migrated113.FamilyMemberCareUpdatesPrimaryContentSection,
      migrated114.FamilyMemberCareUpdatesScreenState,
      migrated115.FamilyMemberDashboardScreen,
      migrated116.FamilyMemberEmergencyContactsActionBarSection,
      migrated117.FamilyMemberEmergencyContactsContentSummarySection,
      migrated118.FamilyMemberEmergencyContactsHeaderSection,
      migrated119.FamilyMemberEmergencyContactsPrimaryContentSection,
      migrated120.FamilyMemberEmergencyContactsScreenState,
      migrated121.FamilyMemberLovedOneScheduleActionBarSection,
      migrated122.FamilyMemberLovedOneScheduleAppointmentDetailsSection,
      migrated123.FamilyMemberLovedOneScheduleCalendarControlsSection,
      migrated124.FamilyMemberLovedOneScheduleHeaderSection,
      migrated125.FamilyMemberLovedOneScheduleScheduleListSection,
      migrated126.FamilyMemberLovedOneScheduleScreenState,
      migrated127.FamilyMemberProfileActionBarSection,
      migrated128.FamilyMemberProfileDetailsFormSection,
      migrated129.FamilyMemberProfileHeaderSection,
      migrated130.FamilyMemberProfileIdentitySummarySection,
      migrated131.FamilyMemberProfilePreferencesOrDocumentsSection,
      migrated132.FamilyMemberProfileScreenState,
      migrated133.ClientBookAppointmentActionBarSection,
      migrated134.ClientBookAppointmentAppointmentDetailsSection,
      migrated135.ClientBookAppointmentCalendarControlsSection,
      migrated136.ClientBookAppointmentHeaderSection,
      migrated137.ClientBookAppointmentScheduleListSection,
      migrated138.ClientCareTeamActionBarSection,
      migrated139.ClientCareTeamContentSummarySection,
      migrated140.ClientCareTeamHeaderSection,
      migrated141.ClientCareTeamPrimaryContentSection,
      migrated142.ClientDashboardChartOverviewSection,
      migrated143.ClientDashboardHeaderSection,
      migrated144.ClientDashboardQuickActionsSection,
      migrated145.ClientDashboardRecentActivitySection,
      migrated146.ClientDashboardSummaryCardsSection,
      migrated147.ClientMyAppointmentsActionBarSection,
      migrated148.ClientMyAppointmentsAppointmentDetailsSection,
      migrated149.ClientMyAppointmentsCalendarControlsSection,
      migrated150.ClientMyAppointmentsHeaderSection,
      migrated151.ClientMyAppointmentsScheduleListSection,
      migrated152.ClientPaymentsActionBarSection,
      migrated153.ClientPaymentsContentSummarySection,
      migrated154.ClientPaymentsHeaderSection,
      migrated155.ClientPaymentsPrimaryContentSection,
      migrated156.ClientProfileActionBarSection,
      migrated157.ClientProfileDetailsFormSection,
      migrated158.ClientProfileHeaderSection,
      migrated159.ClientProfileIdentitySummarySection,
      migrated160.ClientProfilePreferencesOrDocumentsSection,
      migrated161.ClientTreatmentHistoryActionBarSection,
      migrated162.ClientTreatmentHistoryDataTableSection,
      migrated163.ClientTreatmentHistoryFilterBarSection,
      migrated164.ClientTreatmentHistoryHeaderSection,
      migrated165.ClientTreatmentHistoryPaginationSection,
      migrated166.FamilyMemberBillingActionBarSection,
      migrated167.FamilyMemberBillingContentSummarySection,
      migrated168.FamilyMemberBillingHeaderSection,
      migrated169.FamilyMemberBillingPrimaryContentSection,
      migrated170.FamilyMemberCareUpdatesActionBarSection,
      migrated171.FamilyMemberCareUpdatesContentSummarySection,
      migrated172.FamilyMemberCareUpdatesHeaderSection,
      migrated173.FamilyMemberCareUpdatesPrimaryContentSection,
      migrated174.FamilyMemberEmergencyContactsActionBarSection,
      migrated175.FamilyMemberEmergencyContactsContentSummarySection,
      migrated176.FamilyMemberEmergencyContactsHeaderSection,
      migrated177.FamilyMemberEmergencyContactsPrimaryContentSection,
      migrated178.FamilyMemberLovedOneScheduleActionBarSection,
      migrated179.FamilyMemberLovedOneScheduleAppointmentDetailsSection,
      migrated180.FamilyMemberLovedOneScheduleCalendarControlsSection,
      migrated181.FamilyMemberLovedOneScheduleHeaderSection,
      migrated182.FamilyMemberLovedOneScheduleScheduleListSection,
      migrated183.FamilyMemberProfileActionBarSection,
      migrated184.FamilyMemberProfileDetailsFormSection,
      migrated185.FamilyMemberProfileHeaderSection,
      migrated186.FamilyMemberProfileIdentitySummarySection,
      migrated187.FamilyMemberProfilePreferencesOrDocumentsSection,
      migrated188.UnknownDashboardScreen,
      migrated189.PatientBookAppointmentActionBarSection,
      migrated190.PatientBookAppointmentAppointmentDetailsSection,
      migrated191.PatientBookAppointmentCalendarControlsSection,
      migrated192.PatientBookAppointmentHeaderSection,
      migrated193.PatientBookAppointmentScheduleListSection,
      migrated194.PatientBookAppointmentScreenState,
      migrated195.PatientCareTeamActionBarSection,
      migrated196.PatientCareTeamContentSummarySection,
      migrated197.PatientCareTeamHeaderSection,
      migrated198.PatientCareTeamPrimaryContentSection,
      migrated199.PatientCareTeamScreenState,
      migrated200.PatientDashboardScreen,
      migrated201.PatientMyAppointmentsActionBarSection,
      migrated202.PatientMyAppointmentsAppointmentDetailsSection,
      migrated203.PatientMyAppointmentsCalendarControlsSection,
      migrated204.PatientMyAppointmentsHeaderSection,
      migrated205.PatientMyAppointmentsScheduleListSection,
      migrated206.PatientMyAppointmentsScreenState,
      migrated207.PatientPaymentsActionBarSection,
      migrated208.PatientPaymentsContentSummarySection,
      migrated209.PatientPaymentsHeaderSection,
      migrated210.PatientPaymentsPrimaryContentSection,
      migrated211.PatientPaymentsScreenState,
      migrated212.PatientProfileScreen,
      migrated213.PatientTreatmentHistoryActionBarSection,
      migrated214.PatientTreatmentHistoryDataTableSection,
      migrated215.PatientTreatmentHistoryFilterBarSection,
      migrated216.PatientTreatmentHistoryHeaderSection,
      migrated217.PatientTreatmentHistoryPaginationSection,
      migrated218.PatientTreatmentHistoryScreenState,
      migrated219.PatientBookAppointmentActionBarSection,
      migrated220.PatientBookAppointmentAppointmentDetailsSection,
      migrated221.PatientBookAppointmentCalendarControlsSection,
      migrated222.PatientBookAppointmentHeaderSection,
      migrated223.PatientBookAppointmentScheduleListSection,
      migrated224.PatientCareTeamActionBarSection,
      migrated225.PatientCareTeamContentSummarySection,
      migrated226.PatientCareTeamHeaderSection,
      migrated227.PatientCareTeamPrimaryContentSection,
      migrated228.PatientMyAppointmentsActionBarSection,
      migrated229.PatientMyAppointmentsAppointmentDetailsSection,
      migrated230.PatientMyAppointmentsCalendarControlsSection,
      migrated231.PatientMyAppointmentsHeaderSection,
      migrated232.PatientMyAppointmentsScheduleListSection,
      migrated233.PatientPaymentsActionBarSection,
      migrated234.PatientPaymentsContentSummarySection,
      migrated235.PatientPaymentsHeaderSection,
      migrated236.PatientPaymentsPrimaryContentSection,
      migrated237.PatientTreatmentHistoryActionBarSection,
      migrated238.PatientTreatmentHistoryDataTableSection,
      migrated239.PatientTreatmentHistoryFilterBarSection,
      migrated240.PatientTreatmentHistoryHeaderSection,
      migrated241.PatientTreatmentHistoryPaginationSection,
      migrated242.AiChatbotActionBarSection,
      migrated243.AiChatbotContentSummarySection,
      migrated244.AiChatbotHeaderSection,
      migrated245.AiChatbotPrimaryContentSection,
    ];
    expect(migratedTypes, hasLength(246));
  });
}
